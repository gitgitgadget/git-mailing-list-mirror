From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Cloning from kernel.org, then switching to another repo
Date: Mon, 12 Nov 2007 23:33:55 -0500
Message-ID: <9e4733910711122033t36d6ede7ucc86053f0e17605b@mail.gmail.com>
References: <9e4733910711120557w62a9966bvb61a02a2bf9b99e9@mail.gmail.com>
	 <Pine.LNX.4.64.0711121412410.4362@racer.site>
	 <alpine.LFD.0.9999.0711121229090.3062@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0711122040350.4362@racer.site>
	 <9e4733910711121254j5af5dba6k5acdce939936af66@mail.gmail.com>
	 <20071113042342.GC9745@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 05:34:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrnTY-0006vV-U8
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 05:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724AbXKMEd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 23:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756646AbXKMEd5
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 23:33:57 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:47205 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258AbXKMEd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 23:33:56 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1796387wah
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 20:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ezuGPbxp+Ny8UF0oKr7FLwTJ3GUhb4TguiI+/i6J7Dc=;
        b=PKgK1Wl0CH34QPDje+eS92/hAhtkhGabs6MFuYfQ4mM4Rou+TzRfdBxVodcZ1tIdJbsx4twddY7haDMXKQiZEICgCOe/YdY6W+miPJ1lKVwi9eeqF9llufGrWLN5gbTx0AHBTu0GIocz4gQs/kA5tMFafEdbu46gYWp2ZAFAh9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BFDUcsl0TkWr20CIWJ7SkJW+bdbwjv8Bgp97mZ4Rt7RXDS41He+TvyoHL/Y9Ej+vKUm+yOtvw6fotNSD8KNcXW9AAYmSvJ+5WAFNQ/OoBnQBY9wHMxDwqM34TBABce7RD3Zpn/TBc/abGAkNO0SIhWIg94zaAjjceVFqOPiiEOw=
Received: by 10.115.23.12 with SMTP id a12mr486041waj.1194928435375;
        Mon, 12 Nov 2007 20:33:55 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Mon, 12 Nov 2007 20:33:55 -0800 (PST)
In-Reply-To: <20071113042342.GC9745@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64750>

On 11/12/07, Jeff King <peff@peff.net> wrote:
> On Mon, Nov 12, 2007 at 03:54:59PM -0500, Jon Smirl wrote:
>
> > It is eaiser to put
> >   git config remote.origin.url
> > http://git.digispeaker.com/projects/digispeaker-kernel.git
> > in a cookbook web page sequence than say edit the config file by hand.
>
> I think that falls under "scripting" (it's just that your interpreter is
> a human).
>
> > I added the cookbook sequence to my git project page.
> > http://git.digispeaker.com/
> > Without cloning from kernel.org first it takes an hour to clone from
> > dreamhost, but what do you want for $5/mth. I'll more to a better host
> > when traffic picks up.
>
> It sounds like you are posting commits on top of Linus' kernel tree. Why
> not use repo.or.cz's hosting? It's free, and it _already_ has the
> linus-2.6 tree, so you can start a 'fork' and not even waste any space.

It's the kernel for a larger embedded project. After I get the kernel
going I will add the user space environment at the same web site.

The project is described at www.digispeaker.com. It is an open source
multi-room audio system. Wifi based to allow easy installation. Uses
the MPC5200B PowerPC chip.

-- 
Jon Smirl
jonsmirl@gmail.com
