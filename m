From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Add an alias for --abort option
Date: Fri, 21 Nov 2014 16:44:41 +0100
Message-ID: <546F5DE9.1050700@drmicha.warpmail.net>
References: <ae79db289351bca031a4a5adafb9615b@office.etersoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Vitaly Lipatov <lav@etersoft.ru>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 21 16:44:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrqO7-0000Kr-PM
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 16:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758662AbaKUPoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 10:44:44 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42589 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758177AbaKUPon (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Nov 2014 10:44:43 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id E8C28200D3
	for <git@vger.kernel.org>; Fri, 21 Nov 2014 10:44:42 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 21 Nov 2014 10:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=fNh1cZr1xKSYPrIpndKUrm
	w7pTg=; b=ncRWCNBpWlwJpp5K4T+D78ngS8rmlY8i4m6iNX7o3gVEudH3qPywqX
	h718hpyL5AK2sPwa/N1Lf38pCbm1gKgVgHTLUKSSoO8v1GPJwttv4d4TmOBZ9F+J
	QyBAhzChC+u40fOYujdemhrJAa+K+E6ABxsAu3L30Afxwe67a7zSg=
X-Sasl-enc: mT5RzGo7153Spx2qbn+zcVc2VyZTwjbW2SkPVNGt0lrP 1416584682
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 43C246800BA;
	Fri, 21 Nov 2014 10:44:42 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <ae79db289351bca031a4a5adafb9615b@office.etersoft.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vitaly Lipatov schrieb am 21.11.2014 um 13:41:
> Hello,
> 
> is it allowed add alias '--abandone' for --abort option in git commands 
> (git am, git rebase, etc.)?
> The word 'abort' have too negative meaning in the russian language.

But that is the english localisation. We do have git in other languages
- maybe not Russian yet, but it would be great and welcome to change that!

('abort' is negative in german, too).

> For example, for git am we have three option names for continue 
> operation:
> --continue, -r, --resolved

I think it's a bad precedence. We should rather fight option bloat.

Michael
