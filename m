From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] transport-helper: mention helper name when it dies
Date: Wed, 10 Apr 2013 14:35:41 -0700
Message-ID: <CAGdFq_ju7d59jm+d+cmM2T8zR7WjLEVf=HDGa-3Uo3GLbnqh6w@mail.gmail.com>
References: <20130410211311.GA24277@sigill.intra.peff.net> <20130410211603.GB3256@sigill.intra.peff.net>
 <CAGdFq_j5vB+OJAkuk-EMLjyrbiY7QrBiwWPraPA7SWTtuUqgZA@mail.gmail.com> <20130410212833.GA5909@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 10 23:36:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ2gt-0006W3-4K
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 23:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731Ab3DJVgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 17:36:22 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:50356 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985Ab3DJVgV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 17:36:21 -0400
Received: by mail-ie0-f170.google.com with SMTP id c11so1216045ieb.15
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 14:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=GBYH1D9KWh+hugHB37j9a642ZYLpYd0kZhLG1LHkWfc=;
        b=iy/XHLAgUpniUO3qUu8dY0Kj1F/03JOwXu7atqTYD9PJHYHuSJhxsgQ1GWdNQc3tp1
         lISzYycim0sDZSNOULk1BcBwTRCTzTCjA5k7QE8lP/2CmcmSG8ayoX0ZqJHZ1YsohM6j
         PGGkd5DPZYnZOC8u5NctyHKo5pomT8Psh/1WJKPF6pgx+quQIDa6HJFIlWnO0DBmKOLk
         B3YIHaVKh+5TTSa9H9WGgEpjr5sg+8LBvQP1+Ng3eoZ2XXHCmrn53Y03EZbFsrCRKo+z
         wAmES/thvqabvwXQ2MCVqBnHVyLrBqYPyBx2CxwiZkrkkq7L1es+jp/TWPQELpVc/AFZ
         I1BA==
X-Received: by 10.50.57.5 with SMTP id e5mr2678906igq.57.1365629781215; Wed,
 10 Apr 2013 14:36:21 -0700 (PDT)
Received: by 10.50.157.229 with HTTP; Wed, 10 Apr 2013 14:35:41 -0700 (PDT)
In-Reply-To: <20130410212833.GA5909@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220778>

On Wed, Apr 10, 2013 at 2:28 PM, Jeff King <peff@peff.net> wrote:
> Now that's the kind of whole-hearted endorsement I strive for. :)

It's nothing wrong with your patch, the main problem is that there's
not really a good place to point users at.

> If you have better wording, I'm open to it. I do note that we don't
> actually have a manpage for "git-remote-https", though we do for others.
> Probably "man git-remote-helpers" is the most sensible thing to point
> the user to. But I don't even think this is worthy of a big advice
> message. It's a bug in the helper, it shouldn't really happen, and
> giving the user a token they can use to report or google for the error
> is probably good enough.

Yeah, exactly. man git-remote-helpers is more a place for developers
to read how to implement a git-remote-helper, not so much a place for
users to read what they are, and/or how to use them.

--
Cheers,

Sverre Rabbelier
