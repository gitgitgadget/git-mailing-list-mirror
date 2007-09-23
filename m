From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [OT] Re: C++ *for Git*
Date: Sun, 23 Sep 2007 15:42:05 +0200
Message-ID: <e5bfff550709230642v7fa5e837s7a5b9082b043672d@mail.gmail.com>
References: <ABE0ABE82AE84593A2B71B0281F4C814@ntdev.corp.microsoft.com>
	 <46F5318A.4030103@krose.org> <877imishdp.fsf@catnip.gol.com>
	 <46F55E03.2040404@krose.org>
	 <5e4707340709221550o6d0a6062qd51c16a278727c29@mail.gmail.com>
	 <20070923020951.GF24423@planck.djpig.de>
	 <20070923062527.GA8979@old.davidb.org> <851wcpsv4z.fsf@lola.goethe.zz>
	 <e5bfff550709230229t79004ce2j5ce8c2ae7744a7f2@mail.gmail.com>
	 <20070923104525.GC7118@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Pierre Habouzit" <madcoder@debian.org>,
	"Marco Costalba" <mcostalba@gmail.com>,
	"David Kastrup" <dak@gnu.org>,
	"Frank Lichtenheld" <frank@lichtenheld.de>,
	"Alex Unleashed" <alex@fla
X-From: git-owner@vger.kernel.org Sun Sep 23 15:44:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZRkx-00008u-CA
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 15:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbXIWNmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 09:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbXIWNmH
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 09:42:07 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:8217 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbXIWNmG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 09:42:06 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1178685rvb
        for <git@vger.kernel.org>; Sun, 23 Sep 2007 06:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=mWcmI5Bg4+e19glk07IfcnH0l5eg11c1/GDBI9A6KE4=;
        b=M1UIZowt87NvP1UpiempXCBcseRzdhfqsgFhGzBTD1EYakAso5DJepU3D9KrI2o/ZUIFNolQMkUvjA4Wg6/3uIp2jNtjz6rtx3UaWQFna2HUav38Ey/NwBIobNGCxm1G+L3Mc0eOE3nuGxETfBKkj78Wpqo86FsOeLpGV6GwcqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uiZblGn1FTTWx7wALZxEO00dnzaIzTOQXOu2RVkYDPPLSu4PH72LoI2DHaMf93LsZ4D+GG6fVx6dRmMc34nrZLVW67CwHxdxICwCKy2iX36ou4bspwLLLu0D36Suh/s1Fht60S1ujxyzzEPmS2taTeZhRg9oLKv/V4jFA00jnI0=
Received: by 10.141.98.6 with SMTP id a6mr1378448rvm.1190554925717;
        Sun, 23 Sep 2007 06:42:05 -0700 (PDT)
Received: by 10.140.185.19 with HTTP; Sun, 23 Sep 2007 06:42:05 -0700 (PDT)
In-Reply-To: <20070923104525.GC7118@artemis.corp>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58963>

On 9/23/07, Pierre Habouzit <madcoder@debian.org> wrote:
> >
> > Object oriented languages creates black boxes: that's the reason why
> > object oriented exsists and also the reason why Linus hates it ;-)
>
>   This is just nonsense. This has been proved, though I can't find the
> paper about this anymore, than modules (or packages whichever name you
> give them) plus abstract types are as good as OO languages at creating
> black boxes. I mean it has been proved that it gives the exact same
> amount of expressiveness. So please stop with this myth. And don't speak
> for people, I would be very surprised that Linus would dislike "black
> boxes". Abstractions are good, when used wisely, and I would be much
> surprised to see Linus pretend otherwise.
>

>From a Linus recent thread:

> - inefficient abstracted programming models where two years down the road
>  you notice that some abstraction wasn't very efficient, but now all
>   your code depends on all the nice object models around it, and you
>   cannot fix it without rewriting your app.
>
>In other words, the only way to do good, efficient, and system-level and
>portable C++ ends up to limit yourself to all the things that are
>basically available in C. And limiting your project to C means that people
>don't screw that up, and also means that you get a lot of programmers that
>do actually understand low-level issues and don't screw things up with any
>idiotic "object model" crap.

Perhaps I have misunderstood, but the idea I got is that for Linus OO
brings in more problems than what it tries to fix.


>   The real problem with big applications, is not that they are written
> with C, C++, D, APL or Perl, but that they are big.

I have said exactly this, I don't understand where's your point in
repeating the same concept.

> C has many many quirks, I don't discuss that, but OO programming
> solves none of them, and the problems OO addresses are not the one that
> may interfere in the git development.

I really don't get how you made up your mind I'm advocating OO ? The
only comment I made on OO until now was to highlight one of its
downsides.


> I mean, the two really interesting
> things in OO (that haven't a tremendous cost in return) are member
> overloading and inheritance.

You have listed two things that are a world apart one from each other.

member overload is just syntactic sugar for name mangling, while
inheritance and the _strictly_ related virtual member functions (AKA
polymorphism) is what opens the gates to all the stuff you have deeply
blamed in your post.

>I see very few places where git would
> benefit from that

Instead I see none. But probably you have looked at git code better then me.


>   Can we go back to git now ?
>

You are not forced to follow this thread if this bores you.

Thanks
Marco
