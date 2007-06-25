From: "Dan Chokola" <dan@chokola.com>
Subject: Re: Darcs
Date: Mon, 25 Jun 2007 00:44:15 -0400
Message-ID: <61e816970706242144y5dd07464ue6b06478a5920699@mail.gmail.com>
References: <cecbdd220706232232w77a609faxf0e6b2dc37f0d1f4@mail.gmail.com>
	 <alpine.LFD.0.98.0706241030540.3593@woody.linux-foundation.org>
	 <46a038f90706241345m4b5ecb80p9f4ec840993023e0@mail.gmail.com>
	 <7vlke9ouv8.fsf@assigned-by-dhcp.cox.net>
	 <61e816970706241638j60830741p2cd1a102a72ae226@mail.gmail.com>
	 <alpine.LFD.0.98.0706241657540.3593@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Martin Langhoff" <martin.langhoff@gmail.com>,
	"Bu Bacoo" <bubacoo@gmail.com>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 25 06:44:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2gRA-0005qJ-SE
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 06:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbXFYEoS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 00:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbXFYEoR
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 00:44:17 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:52970 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbXFYEoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 00:44:16 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1670962wah
        for <git@vger.kernel.org>; Sun, 24 Jun 2007 21:44:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=m7Bq7/9wy+a/N1MYXsupVvFuEJorFmK4KX9WomJUu9x6iAmFgv5640rtccQ0WUQyexIlS7ZJ42Qdqiyinz7KMl7wDe2LY2QMaA/lLIOIAPRfdDya3BR6IQkzyr8kobuIcIW19bIS0kUlXHV/7JZHEPnsOK3O77U+ihMk9/z0FcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=TYhOO/zO85nsTVXRCaH+Ck3D/7fQbW/A565codimxeRCuyI8UcHK0ws4biPweSxpojaJWDoHrQq7NMxgg1Dbr2yIy/O8/7lsFBC7LcGq3rmWKTHOMpAVOHQfhMXkJ6gdHvOSX3dCmB0RrwY+ezC1HXQngpJavoovRBKmblL7TPo=
Received: by 10.115.89.1 with SMTP id r1mr5080918wal.1182746655182;
        Sun, 24 Jun 2007 21:44:15 -0700 (PDT)
Received: by 10.114.234.7 with HTTP; Sun, 24 Jun 2007 21:44:15 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0706241657540.3593@woody.linux-foundation.org>
Content-Disposition: inline
X-Google-Sender-Auth: 99612187f0c23b79
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50856>

On 6/24/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Sun, 24 Jun 2007, Dan Chokola wrote:
> >
> > What I have noticed is a lot of nitpicking, of which I'm guilty, too. The
> > issue Linus brought up about Darcs and versioning is not one I typically see
> > surface in real life. Users usually complain about some _release_ version
> > or, "I updated last week."
>
> Actually, in the kernel, we are getting quite a lot out of "git bisect",
> and people throw git SHA1's around to describe where they are, or a
> particular commit.
>
> Which never happened with BK.
>
> So I think that the _ability_ to name revisions easily across different
> uses is quite important, because it then drives behaviour.
>

I wholeheartedly agree it's important as far as the big picture of SCM
is concerned. Though I will say that the kernel development is an
extreme case, where there's a huge number of developers and incredibly
fast development where matching features are needed from the SCM. And
I love how Git is born out of this extreme case, as it leads to a lot
of great features that often scale down, too. But some of them matter
less to, say, a small, well-integrated team of 5 or 10 people. And an
idealistic model like the one offered by Darcs might even work better
there since corner cases don't show up often.

I'm spoiled by Git and the fact that it has these great abilities and
features that set it apart, and I'd love everyone to use it. But I'd
like people to know that many attributes of Git and other DSCMs don't
differ all that much. (Please don't call me ugly and stupid. ;) And
actually, this is something of a selling point, because it makes it
Git seem cozy and familiar.

So, relating back to the original post, and extending on Linus'
'academic' analogy, Darcs is like a thesis project from university
that proves how DSCM can be done scientifically. Git is grown-up Darcs
that proves how DSCM can be done practically. The bottom line is the
foundations of DSCM, cheap branching, easy merging, and the like, can
be done very similarly in either Darcs or Git, so moving from one to
the other leaves you with a largely familiar set of commands.

> Without it, you'll never notice you need it. With it, you start wondering
> how others handle it.
>

Git really does have a way of spoiling its users (I don't know how
CVS/SVN users live), no argument here.

-Daniel "Puzzles" Chokola
