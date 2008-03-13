From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 3/4] builtin-status: configurable submodule summary
 size
Date: Thu, 13 Mar 2008 15:15:02 +0100
Message-ID: <47D936E6.10107@viscovery.net>
References: <1205416085-23431-1-git-send-email-pkufranky@gmail.com> <1205416085-23431-2-git-send-email-pkufranky@gmail.com> <1205416085-23431-3-git-send-email-pkufranky@gmail.com> <1205416085-23431-4-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 15:15:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZoDi-0005MI-Vs
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 15:15:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbYCMOPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 10:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbYCMOPH
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 10:15:07 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:64283 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbYCMOPG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 10:15:06 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JZoCI-0005Q0-22; Thu, 13 Mar 2008 15:14:19 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A3A7A6B7; Thu, 13 Mar 2008 15:15:02 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1205416085-23431-4-git-send-email-pkufranky@gmail.com>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77092>

Ping Yin schrieb:
> +	if (wt_status_submodule_summary == 0) return;

Style:
	if (!wt_status_submodule_summary)
		return;

>  	struct child_process sm_summary;
> +	char summary_limit[64];
> +	sprintf(summary_limit, "%d", wt_status_submodule_summary);
>  	const char *argv[] = {

Declaration after statement. That's not portable.

-- Hannes
