From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: thin packs ending up fat
Date: Fri, 13 Jan 2012 09:28:43 +0100
Message-ID: <CACBZZX567mHKXDtTcb+zFKtr2ZvcssF+O=w-x86PfNh+5tTpRg@mail.gmail.com>
References: <20120112221523.GA3663@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 13 09:29:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlcVr-0006WD-QD
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 09:29:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754003Ab2AMI3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 03:29:09 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:51489 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751936Ab2AMI3H (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jan 2012 03:29:07 -0500
Received: by lago2 with SMTP id o2so129645lag.19
        for <git@vger.kernel.org>; Fri, 13 Jan 2012 00:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Wnh3jud7oKuw5omJC4M4WVbFasVDEaSTxIm/XLhCZQM=;
        b=uHn6toPvTrgoJfCEjRQ7alRlPhLypxWALHjl32xDkmVeKU/FSsfvKz0AVaGvKiIK2D
         dLJ2JeSxbwsYV8ppmhWXfS82KQssilvwbHw6xG/qF7mLsHOCZmTsA8EA6VjMLuQdm9Eu
         10x8OZT4pY3dtIAZdZSu3V+thiNssv2xBkpJ8=
Received: by 10.112.99.65 with SMTP id eo1mr316594lbb.31.1326443344537; Fri,
 13 Jan 2012 00:29:04 -0800 (PST)
Received: by 10.112.82.5 with HTTP; Fri, 13 Jan 2012 00:28:43 -0800 (PST)
In-Reply-To: <20120112221523.GA3663@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188508>

On Thu, Jan 12, 2012 at 23:15, Jeff King <peff@peff.net> wrote:

I'd be interested in testing this on some other repos I have. How
exactly did you get this:

> -- >8 --
> 8b0e15fa95e11965f18c8d2585dc8ffd9bfc9356 ^7f41b6bbe3181dc4d1687db036bf22316997a1bf
> 34c4461ae3b353e8c931565d5527b98ed12e3735 ^8b0e15fa95e11965f18c8d2585dc8ffd9bfc9356
> 463b0ea22b5b9a882e8140d0308433d8cbd0d1fe ^34c4461ae3b353e8c931565d5527b98ed12e3735
> 288396994f077eec7e7db0017838a5afbfbf81e3 ^463b0ea22b5b9a882e8140d0308433d8cbd0d1fe
> 05f6edcd2a418a88eeb953d51408a6aeef312f5c ^288396994f077eec7e7db0017838a5afbfbf81e3
> 08cfdbb88cd6225b4fc4b8a3cecd0e01758c835d ^05f6edcd2a418a88eeb953d51408a6aeef312f5c

>From this:

> In the first, I used the reflog entries from my
> refs/remotes/origin/master ref.

I can't make "git reflog refs/remotes/..." show me anything similar.
