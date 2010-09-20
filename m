From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 09/37] t6020: Modernize style a bit
Date: Mon, 20 Sep 2010 11:24:09 +0200
Message-ID: <4C972839.9050303@viscovery.net>
References: <1284971350-30590-1-git-send-email-newren@gmail.com> <1284971350-30590-10-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 11:24:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxcbg-00045f-SN
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 11:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755931Ab0ITJYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 05:24:11 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:32747 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753480Ab0ITJYK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 05:24:10 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OxcbZ-00007A-J8; Mon, 20 Sep 2010 11:24:09 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 55AF61660F;
	Mon, 20 Sep 2010 11:24:09 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.12) Gecko/20100914 Thunderbird/3.0.8
In-Reply-To: <1284971350-30590-10-git-send-email-newren@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156604>

Am 9/20/2010 10:28, schrieb Elijah Newren:
> -test_expect_code 1 'Merge with d/f conflicts' 'git merge "merge msg" B master'
> +test_expect_success 'Merge with d/f conflicts' '
> +	test_must_fail git merge master
> +'

The old version requested a particular kind of failure. Are you saying
that with modern 'git merge' all non-zero exit codes mean the same kind of
failure?

-- Hannes
