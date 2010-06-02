From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 4/5] t/t7006: ignore return status of shell's unset builtin
Date: Wed, 02 Jun 2010 08:41:59 +0200
Message-ID: <4C05FD37.1080209@viscovery.net>
References: <Wt_M4qptcPdpY0Q3jqUbfIk6yMCN9Ja5RCtRUsADK5OJGrz7R_Cq1oGpeQoN7A9uCvw38jm63Jo@cipher.nrlssc.navy.mil> <Wt_M4qptcPdpY0Q3jqUbfMMZpuKZEHudj8tavRDS41LEhIuAY6Jac5ja0dD0ZRTTyKV_0v7MM6g@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jun 02 08:42:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJheS-0004ow-9j
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 08:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590Ab0FBGmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 02:42:01 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:39587 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751901Ab0FBGmB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 02:42:01 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OJheJ-0005e1-I0; Wed, 02 Jun 2010 08:41:59 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 46EBF1660F;
	Wed,  2 Jun 2010 08:41:59 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <Wt_M4qptcPdpY0Q3jqUbfMMZpuKZEHudj8tavRDS41LEhIuAY6Jac5ja0dD0ZRTTyKV_0v7MM6g@cipher.nrlssc.navy.mil>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148223>

Am 6/2/2010 2:13, schrieb Brandon Casey:
>  test_expect_success 'setup' '
> -	unset GIT_PAGER GIT_PAGER_IN_USE &&
> +	unset GIT_PAGER GIT_PAGER_IN_USE

Maybe we should terminate the line with ';' to document that it is a
deliberate choice that there is no '&&'?

Just an idea...

-- Hannes
