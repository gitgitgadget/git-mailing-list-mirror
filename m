From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Branches & directories
Date: Mon, 3 Oct 2011 00:15:33 -0700
Message-ID: <CAE1pOi2xmVHrVJcC85wvCv=anhn_kYizyUMpUVZF4EE33RoGmg@mail.gmail.com>
References: <CAMOZ1Bu5pPeviyZD-e6aHbv-+tSaBDyyKb5vHA132K_3=1gD-g@mail.gmail.com>
	<CAE1pOi0dL2qNMksuY_=gyGSRsfr6e9AmzgJUNB=jEz85sjuiUw@mail.gmail.com>
	<CAGZ=bqK7H3zc8LK7EP8+uV8DpWW+czK2POfceGtcBF8Vmkhkow@mail.gmail.com>
	<CAE1pOi1J5DKtnyUQzu1K7G1+HLsWWCN7thCf6W8MwSzt4_vtOw@mail.gmail.com>
	<CAGZ=bqLZoLoyMcvnppg6SyFtJU8phSquQeBZ7uhwP=+ZL3DADw@mail.gmail.com>
	<CAE1pOi0Er1ZgftpNeCr85Zu27xR2127V_KdAtvKc1NOKmDUvzQ@mail.gmail.com>
	<CAGZ=bqLyS9tcpqztwGWFOXtDJRhugu+JYvz7wTnc0PTmECWX2g@mail.gmail.com>
	<CAE1pOi1axNmGaPVXqBH02x0N=Z6tgO9R00RTokuJm50eY-OoNg@mail.gmail.com>
	<4E889813.8070205@gmail.com>
	<CAE1pOi3bm72Rk+UYygS_bC9eh0VTPr-VQSdtBGqjgDpEzkutZw@mail.gmail.com>
	<20111003030723.GA24523@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Robin Rosenberg <robin.rosenberg@gmail.com>,
	Kyle Moffett <kyle@moffetthome.net>,
	Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 03 09:15:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAckV-00037t-KE
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 09:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298Ab1JCHPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 03:15:35 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:42368 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab1JCHPe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 03:15:34 -0400
Received: by qyk30 with SMTP id 30so1771520qyk.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 00:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2/UGJFfBWFCCj1G/+axPFLblA6+yELURD86sxNUCZZM=;
        b=YssgtCPPdXaVds4D9XujAsIUh8N93VCi9RmvCaiLQfr7fXNlNyjDVfbXsBAu4pn9g4
         FGjBXJ13+gFi3CIHM3fkG11lGrvD3MQJy3uR10Df9iKwkKgMVSRI5TQ003Z37wXW7G5W
         1FV8Y1dsnqejGWpqhcP4dT1qvWCzOlrGe7YOU=
Received: by 10.229.63.20 with SMTP id z20mr1295987qch.201.1317626133709; Mon,
 03 Oct 2011 00:15:33 -0700 (PDT)
Received: by 10.229.87.134 with HTTP; Mon, 3 Oct 2011 00:15:33 -0700 (PDT)
In-Reply-To: <20111003030723.GA24523@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182628>

On 2 October 2011 20:07, Jeff King <peff@peff.net> wrote:
<snip/>
> Or did you really mean your example literally, as in you run two
> checkouts back to back, without running anything in between, and the
> second checkout restores the state before the first one. In that case,
> yes, it would be correct to keep the old timestamps. But this is an
> optimization that can only apply in a few very specific cases. And
> moreoever, how can git know when it is OK to apply that optimization? It
> has no idea what commands you might have run since the last time we were
> at "master".

Yes, I meant it literally. And, no, Git could not possibly know so it
would have to be optional behaviour. But it's probably a lot of work
for (for most people) little gain.
