From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Fwd: git clone does not respect command line options
Date: Fri, 26 Feb 2016 00:15:46 -0800
Message-ID: <CA+P7+xpuiUQgWYRgVrwKkv27KiJGQ0COrR93cFzQzn2uVA6ypQ@mail.gmail.com>
References: <CAMDzUtzoiJWzckTX818HJV=su0eEP35gsNDJ=+k_me08EDvxRg@mail.gmail.com>
 <CAMDzUtxQPMty0Nncr7Yj3up6Zb6F-E0QudOMOZO_jG-Goq0YBg@mail.gmail.com>
 <20160226073444.GA26340@sigill.intra.peff.net> <CAMDzUty5oWjS=4kvvYL7XNCY=xHm3N=+kaeT_zTtpkaMakMrmA@mail.gmail.com>
 <20160226075948.GA26994@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Guilherme <guibufolo@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 09:16:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZDZM-0003fu-FH
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 09:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753799AbcBZIQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 03:16:08 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34949 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802AbcBZIQH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 03:16:07 -0500
Received: by mail-ig0-f180.google.com with SMTP id hb3so30116604igb.0
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 00:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Sq1V7pX3RljdiIf0gBj2fp2K+yd4R2q8lxHeAK3DgmU=;
        b=xtOsBzRRA04likabxPg727+v60J1jN3kTf6VPOK5GN0ZsW76sW52UAwRoObDf2AZN+
         Ohw2yZl4UzcujlknS+DvoUaEAwMy02B3JPXgxXlFKUR7D2qQCHG7IV/tY/Bp0PiIOB9J
         JplTBqnj6kRWBTNPnTD0LlaFrtzYRCaGcBxQriWbD9PuLeKr+Fs9oGxXUMlhzA89jaQV
         TQXz6R1j9lDWHkkKjWx7EErwVzjA2Se7WF7jfY228lJQc4s/zhPY2AsSGP9yzzH+J5ze
         vhmDRwzfrNAjMY0JGMPJl5d7qYu8uq4kIw7roq5hyyFziA2mdfc+NzZaR0MmBzQJumxO
         F8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Sq1V7pX3RljdiIf0gBj2fp2K+yd4R2q8lxHeAK3DgmU=;
        b=NTmA+yQs1sr0GJsRO5cORfPpPe6bdmQFl5fgX+DqOSyrkV3GpsIRf/BbbkuEQvuORi
         eNquqY/C2UbOFJZjO3RrErY7NxiFsvNEeFajSXUqkXcF+MDw6Wa1Y7Qa+pnT4M2FMhg4
         0mxcVhfhDRyKXufNFWCJellMCioMU15At1s2CchqgY62r94iEHf+JYYu8Fx0dec30Yj0
         Ejqh/6ptXVTL/VuTabiM87voW0SoI+zBWS3O+xnaIbOs4ZU6pnkh4SrlOzVMmH9hyjm0
         d55nBdGm2cw3VhwNGvY69pRbfFu6VRTBQ8Zcl6IBTNed5kf64zakKXW3R3BrJ7+hNcT/
         yByw==
X-Gm-Message-State: AD7BkJIJWFnhpZPvAE5OY/olGGoH7zY1IAnB4M5COrsO4fWxhgZGAK04hZRf2EhepbKorWa7Lxgeu8YvwKQRTQ==
X-Received: by 10.50.43.168 with SMTP id x8mr1625597igl.92.1456474566302; Fri,
 26 Feb 2016 00:16:06 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Fri, 26 Feb 2016 00:15:46 -0800 (PST)
In-Reply-To: <20160226075948.GA26994@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287549>

On Thu, Feb 25, 2016 at 11:59 PM, Jeff King <peff@peff.net> wrote:
> Right. The "git-config" program doesn't know about the semantics of
> particular values (remember that in the early days, there were many
> porcelains which built on top of git, and they could all store their own
> config). Using "--get" implements "last one wins" semantics, which
> is what most config variables want. You can use "--get-all" to see all
> instances of a multi-valued variable.
>

And note that several libraries of hooks and git extensions store
configuration there as well, not just traditional porcelain. (Though
maybe that is considered porcelain? Not really sure on the term here).
I do this myself for several custom git hooks.

Thanks,
Jake
