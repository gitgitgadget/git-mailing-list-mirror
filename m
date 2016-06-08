From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: `man 1 git`: Invalid link to online documentation
Date: Wed, 8 Jun 2016 14:43:57 +0200
Message-ID: <eeb75a91-17d6-bb49-e4d6-34bf4fb3defe@drmicha.warpmail.net>
References: <ed8f000f-b8a2-ca92-e0f2-e26ff9928bbe@gentoo.org>
 <20160606231936.GB22756@sigill.intra.peff.net>
 <20160606232536.GA23537@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Daniel Campbell <zlg@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 14:44:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAcqH-0004Ie-Hr
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 14:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422908AbcFHMoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 08:44:03 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52039 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422659AbcFHMoA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2016 08:44:00 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 3260120A4C;
	Wed,  8 Jun 2016 08:43:59 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Wed, 08 Jun 2016 08:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=MVQDmAj0uzh7wasd8Wu5w14f3cs=; b=M+Uu8m
	8OWUZhu9gEZHtwh0oFSmJ2c2EhxUsNVlR9Udk2dIWrfdn0tNo7AddgzeXwiLWsiG
	WGKtSRqllFAj8dOku64U6ymwdLUaewkZDZYqexl+Hb92xJQWyPxPaIKpPmSzZ/AU
	4adOId2Iym0EuzvVmTxRsnhRLNIVwRicX7HfE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=MVQDmAj0uzh7was
	d8Wu5w14f3cs=; b=BrvSVLc3JIDwuDzVrIEt2LJb4wJEMyDLxu4mBrHoQutEK5+
	m1xmvRIUM8SG6ADL0tBehsqincO3S8MB/w5EBHuGrjncPj1HIpRoKLLi6myq3Mo0
	qlGXAjboZOa1WmBjX+VwfXMFCKh1SCw3ze2XOSwFyBh3/2pCRhJDVcE7lpr8=
X-Sasl-enc: IEsfq/g/P1c1wmzGwtuv6Oy3ld4+gr6jYLQxxo9uzEEo 1465389838
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 636BACCDB2;
	Wed,  8 Jun 2016 08:43:58 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <20160606232536.GA23537@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296787>

Jeff King venit, vidit, dixit 07.06.2016 01:25:
> On Mon, Jun 06, 2016 at 07:19:36PM -0400, Jeff King wrote:
> 
>>   2. Make git-htmldocs a real site on GitHub. I think this should be as
>>      simple as pushing to the `gh-pages` branch of the repository, which
>>      would make it available as https://gitster.github.io/git-htmldocs.
>>      You can do a bunch of Jekyll magic, but you don't have to; it should
>>      serve arbitrary html files (though I think we'd maybe want to add
>>      an "index.html"; we may also want to host it under a git/htmldocs
>>      project just to make the repo more official looking).
> 
> Just to make sure I wasn't spewing nonsense, I tried pushing the tip of
> gitster/git-htmldocs to the "gh-pages" branch of git/htmldocs, and
> indeed:
> 
>   https://git.github.io/htmldocs/git.html
> 
> now works. If we like that solution, Junio, you should already have
> access to just push there (instead of gitster/git-htmldocs, or in
> addition to if you prefer).
> 
> If not, I'll delete the repository (I don't plan on doing further
> pushes, so leaving it will just confuse people).
> 
> I see that we _do_ have an index.html symlink in the built tree, but it
> does not seem to actually work via GitHub Pages.
> 
> -Peff
> 

I like that a lot. It makes good use of the existing infrastructure at
github, and the rendering uses screen real estate much better than the
version on git-scm.com.

If Junio integrates it into his usual workflow then we don't have the
update issues that we have over there. Rendered documentation in-sync
with the code, hooray :)

Michael
