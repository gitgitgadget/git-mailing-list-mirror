From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Makefile: add check-docs exception for gitrevisions
Date: Mon, 26 Jul 2010 13:11:14 +0200
Message-ID: <4C4D6D52.4060709@drmicha.warpmail.net>
References: <d494791b6e69140e2a94ec3262f55b939cdf5062.1280133654.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jul 26 13:11:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdLaS-0006Wi-Ch
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 13:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174Ab0GZLLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 07:11:06 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58261 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754046Ab0GZLLF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jul 2010 07:11:05 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4ECC3131A87;
	Mon, 26 Jul 2010 07:11:03 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 26 Jul 2010 07:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=V8xJihVA1sPUFTrJ9tIJlx+FxMk=; b=NbifUuNrn5n4EKh0dok0xLItm+ZGoabZDpM4a5ALcRlyheIyzqeMDDvOiI/Rnci8zpxaiZvynNiD6Sf/kv64RFen5y2iBETPZ9rzp06Qxd9yxBn4KzRaTSX23Ag6TpnOYdoTKgk7BKulD305qHdAmzPBbSBJyRS5QGz6Y7vFzbw=
X-Sasl-enc: mSCMsPPlUvGhWIWJQOiwIL+clIgnU3H1F8WdLXiFjP9+ 1280142662
Received: from localhost.localdomain (p54859EA9.dip0.t-ipconnect.de [84.133.158.169])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 403554D8451;
	Mon, 26 Jul 2010 07:11:02 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8pre) Gecko/20100714 Lightning/1.0b2pre Lanikai/3.1.2pre
In-Reply-To: <d494791b6e69140e2a94ec3262f55b939cdf5062.1280133654.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151830>

Thomas Rast venit, vidit, dixit 26.07.2010 10:40:
> The manpage was added in 1ed6f2c (Documentation: gitrevisions,
> 2010-07-05), but since it does not have a corresponding git command,
> it needs an exception for check-docs.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>  Makefile |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 60a846e..74005dd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2259,6 +2259,7 @@ check-docs::
>  		documented,gitglossary | \
>  		documented,githooks | \
>  		documented,gitrepository-layout | \
> +		documented,gitrevisions | \
>  		documented,gittutorial | \
>  		documented,gittutorial-2 | \
>  		documented,git-bisect-lk2009 | \

I didn't even know we have that target... Thanks!

Acked-by: Michael J Gruber <git@drmicha.warpmail.net>
