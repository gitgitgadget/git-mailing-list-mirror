From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] completion: --set-upstream option for git-branch
Date: Thu, 15 Apr 2010 12:56:01 +0200
Message-ID: <4BC6F0C1.9050104@drmicha.warpmail.net>
References: <72c4f4098dea94e21d44b8f76965ff1cb26eab72.1269617202.git.git@drmicha.warpmail.net> <72c4f4098dea94e21d44b8f76965ff1cb26eab72.1270516663.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Apr 15 12:59:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Mmu-0002j2-5Y
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 12:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170Ab0DOK7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 06:59:06 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:33068 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752038Ab0DOK7F (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Apr 2010 06:59:05 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B55BDEB905;
	Thu, 15 Apr 2010 06:59:02 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 15 Apr 2010 06:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=CoAt7dapOzx5CloZAqRZG8c0nPc=; b=RO1qHald+lQelr1ZV93WRWpB5KlVlX1DHXmxZ1b3Gd/xmvabH8wSfdeNnsF0/qXJGUQ/pzBe9BsldXtBPqh/MsyvppQywMrWQQBLNM8nfrX13FRykr0bN6yF/5dyAm5Ck/wI9vArbsSG7lDNStrPec5b6jZudlUqqnq6zULgQAU=
X-Sasl-enc: R24zd2sR+X9bQZUbQg1XcZAoFu/GTUE4WAXFhX3+RYVD 1271329142
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 137092798D;
	Thu, 15 Apr 2010 06:59:01 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100414 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <72c4f4098dea94e21d44b8f76965ff1cb26eab72.1270516663.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144971>

Michael J Gruber venit, vidit, dixit 06.04.2010 03:20:
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> Bump...
> 
>  contrib/completion/git-completion.bash |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 545bd4b..57245a8 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -797,6 +797,7 @@ _git_branch ()
>  		__gitcomp "
>  			--color --no-color --verbose --abbrev= --no-abbrev
>  			--track --no-track --contains --merged --no-merged
> +			--set-upstream
>  			"
>  		;;
>  	*)

I don't mind if this is not used, but I'd at least like to get a "no".
Would someone please comment on this? Thanks!

Michael
