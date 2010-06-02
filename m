From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/5] t/t5800: skip if python version is older than 2.5
Date: Wed, 02 Jun 2010 08:37:12 +0200
Message-ID: <4C05FC18.4090402@viscovery.net>
References: <Wt_M4qptcPdpY0Q3jqUbfIk6yMCN9Ja5RCtRUsADK5OJGrz7R_Cq1oGpeQoN7A9uCvw38jm63Jo@cipher.nrlssc.navy.mil> <Wt_M4qptcPdpY0Q3jqUbfCU_HpY9NEjqs9eujZFD2rsUj5HRo__oQm7EUCxzXu38mC0y-ilUA14@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jun 02 08:37:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJhZs-0002vs-1W
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 08:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375Ab0FBGhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 02:37:17 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:35391 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752069Ab0FBGhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 02:37:16 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OJhZg-0005UW-T8; Wed, 02 Jun 2010 08:37:13 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 971D01660F;
	Wed,  2 Jun 2010 08:37:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <Wt_M4qptcPdpY0Q3jqUbfCU_HpY9NEjqs9eujZFD2rsUj5HRo__oQm7EUCxzXu38mC0y-ilUA14@cipher.nrlssc.navy.mil>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148222>

Am 6/2/2010 2:13, schrieb Brandon Casey:
> +if ! test_have_prereq PYTHON_2_5_OR_NEWER
>  then
> +	say 'skipping git remote-testgit tests: requires Python 2.5 or newer'
...
> +++ b/t/test-lib.sh
> +if test_have_prereq PYTHON && "$PYTHON_PATH" -c '
> +import sys
> +if sys.hexversion < 0x02050000:
> +    sys.exit(1)
> +'
> +then
> +	test_set_prereq PYTHON_2_5_OR_NEWER
> +fi

Please don't burden all test script invocations with this check when the
result is used in only one place.

-- Hannes
