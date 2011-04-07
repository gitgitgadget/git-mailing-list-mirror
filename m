From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v4 0/4] Document diff and filter drivers in config
Date: Thu, 07 Apr 2011 14:47:03 +0200
Message-ID: <4D9DB247.8040708@drmicha.warpmail.net>
References: <1301654600-8901-1-git-send-email-artagnon@gmail.com> <1302083854-2448-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 12:47:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7mk9-0002X6-5J
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 12:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275Ab1DGKrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 06:47:08 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:41670 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753031Ab1DGKrH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Apr 2011 06:47:07 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1B23220729;
	Thu,  7 Apr 2011 06:47:06 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 07 Apr 2011 06:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=n5QLuTOneD6O3IV0jiqlVawHj5Q=; b=cVnG+N4+TXUqGegXZKjuHo45xKh/UO5YwFtP2UDL1pqfbggoPq9q7Y4Enhb7gd3LFgmk8blUO5YDG92qRhDlMqSF3luLLAE2rssZRBJV/Xa07zDoLEV26VUa5e2ce5MxiU3DoCjhyDqoNlFmsRP6klzX2dM4yMFe4AwOMGtjmdo=
X-Sasl-enc: IEcj0VHws+6clcY6HFcVabEHwLTCHvOUwl69Cm/J0XpD 1302173225
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 67B85408ED0;
	Thu,  7 Apr 2011 06:47:05 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <1302083854-2448-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171053>

Ramkumar Ramachandra venit, vidit, dixit 06.04.2011 11:57:
> Also, describe What changed since v3:
> - More language improvements, thanks to Michael.
> - Junio's elaborate note clarifies several options.
> - One more patch in the series to make similar corrections to
>   merge-config.
> 
> Thanks for reading.
> 
> -- Ram
> 
> Ramkumar Ramachandra (4):
>   Documentation: Add filter.<driver>.* to config
>   Documentation: Add diff.<driver>.* to config
>   Documentation: Allow custom diff tools to be specified in 'diff.tool'
>   Documentation: Minor language improvements to merge-config
> 
>  Documentation/config.txt       |   72 ++++---------------------------
>  Documentation/diff-config.txt  |   91 ++++++++++++++++++++++++++++++++++++++++
>  Documentation/merge-config.txt |   38 ++++++++--------
>  3 files changed, 120 insertions(+), 81 deletions(-)
>  create mode 100644 Documentation/diff-config.txt
> 

Thanks for hanging in, looks good (minus the customs which Junio mentioned).

Michael
