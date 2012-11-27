From: David Aguilar <davvid@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Mon, 26 Nov 2012 23:54:34 -0800
Message-ID: <CAJDDKr4cr3VXqx=CXgXSQrVTSjE=f=55HZns-xfNziJOXb3Vsw@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CACsJy8BbUjrJtfpEvbcK==Y2gFNsFhFBN93CL36J5uVe=Ca4wQ@mail.gmail.com>
	<20121125051809.GA3670@thyrsus.com>
	<CAMP44s0r1J=aOuEpKQ1+ew9FzODwLX-w5z9rG-WN6AjU0o97yw@mail.gmail.com>
	<20121125095429.GB22279@thyrsus.com>
	<CAMP44s1cG=5D9DppHmB9CpgkgdEzM72KhQ1Q-kWrrDo8ST+r_g@mail.gmail.com>
	<20121125175051.GD32394@thyrsus.com>
	<CAMP44s3QNG-sxcZsWmL3RYjXkzOwerj2774t7Abh04A7QR6TCA@mail.gmail.com>
	<20121125215635.GA6937@thyrsus.com>
	<CAMP44s2FcrjDhNzond=Rzmn5QOBnZbQC1d73ZmKNeyCRvJNvyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: esr@thyrsus.com, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 08:54:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdG0J-0000fu-M7
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 08:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758137Ab2K0Hyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 02:54:36 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:45770 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757618Ab2K0Hyf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 02:54:35 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so8624005vcm.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 23:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=L+QWmIqaBFUF5k4xqJBqd9m1ldN/RVwBAnFPas/vUlc=;
        b=ODDThqTxcrjko97S5aL+ERfT0R8y68W0B2keBMEW+ymdBpBSAPi5WPWZPWyCbt0gb7
         emNbSTgxF4fc/lPL7yYGlJ7CwVBcXuuxmcbmNL8jf7vXAnAaEPxBCktdOT2q6N9XJmgo
         auzaVv5JiW+Q4MNjyHvZ2xEm6oxGaVa4WW+D9RW2IPgCV3fs8Ovh3IP3/CRMWgigC5aE
         JDtzJt7s41BJB3Tq6o6oiPf2M8pwFvQlB3JWAzp83xxn6smGtjTIvcTzyIBjZyxwha+s
         B2hGDGdjdJHqIj7fY91h2XVCBs+j2OiCZsY+zDFf0CWHoIuDI4Im8y7SkEMGvRsh0p04
         1Dbw==
Received: by 10.220.226.67 with SMTP id iv3mr22774239vcb.57.1354002874603;
 Mon, 26 Nov 2012 23:54:34 -0800 (PST)
Received: by 10.58.182.10 with HTTP; Mon, 26 Nov 2012 23:54:34 -0800 (PST)
In-Reply-To: <CAMP44s2FcrjDhNzond=Rzmn5QOBnZbQC1d73ZmKNeyCRvJNvyA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210539>

On Mon, Nov 26, 2012 at 5:11 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> And I don't agree that the project would be better off with something
> else, if it was, somebody would have proposed an alternative by now,
> but there aren't any. I have tried gitg, and giggle, and I have even
> contributed to them, but they are just not as good and useful as plain
> old gitk, I always keep coming back.
>
> gitk:
>  * is blazing fast to start
>  * doesn't have a lot of dependencies: just tcl/tk
>  * works on Windows without a major fuzz
>  * is actively maintained
>  * shows a proper graph (unlike gitg or giggle)
>
> Now, show me an alternative that fulfills all these points. And I'm
> pretty sure you won't find one, because if you did, it would have been
> already proposed for mainline git... there isn't any. And if you did,
> we would start with oh, but it's GTK+, or it's Qt, and how do you make
> it work on Windows. No, gitk is just fine, and works great.
>
> Tcl/Tk might not be your cup of tea, and indeed it's rather unmodern,
> but that only tells you how an awful job the modern toolkits have done
> with regards to portability and flexibility.
>
> You were arguing for portability, well, Tcl/Tk works on all platforms,
> here, have a look, there's no other tool that fulfills this:
>
> http://www.mediawiki.org/wiki/Git/Graphical_User_Interfaces

*cough* git-cola *cough*

it runs everywhere.  Yes, windows too. It's written in python.
It's been actively maintained since 2007.

It's "modern" and has features that don't exist anywhere else.

It even has tests.  It even comes with a building full of willing
guinea-pigs^Wtesters that let me know right away when
anything goes wrong.

It uses Qt but that's really the whole point of Qt -> cross-platform.
(not sure how that wiki page ended up saying Gnome/GTK?)

The DAG aka git-dag (in its master branch, about to be released)
is nicer looking then gitk IMO.  gitk still has some features
that are better too--there's no silver bullet, but the delta
is pretty small.

The only point this doesn't fulfill is dependency-free-ness.
With that requirement the answer can *only* be tcl/tk.
So saying, "go look for one you won't find it" is really
a tautology.  It's not even an entertaining one.

http://xkcd.com/703/

When the requirement is, "what is the best user experience
possible", then you use a mature GUI library.  These are different
requirements and probably different use cases.  For the gitk use
case, gitk is the perfect tool.

Anyways, just sayin', you make it sound like this stuff doesn't
exist, but it does.  I've never proposed it for mainline
git because I'm very aware of the dependency requirements.

But, if git "recommended" it I would very much appreciate the
extra eyes and contributions.  Being in mainline git could
possibly help with that.  A submodule under contrib/
would be an interesting experiment.

In any case, I think documenting the python standards
(even if within contrib/ only) is a good thing.

We'd be increasing the overall portability by documenting
what we support and sticking to it, just
like what is done for shell scripts and perl versions.
Eric is helping make that happen, let's not  throw
out the baby with the bathwater.  FWIW, I would also make
my python expertise available.

This thread has gotten into meta-meta territory --
it's discussing code that has not yet even been written,
and going off on all sorts of tangents.

Let's stay on target.  I think bringing up python
as an extension language would help in a these key areas:

- There are a few python modules floating around that
  are similar to the ruby grit library.  Having an official
  python module would be good.

- Commands on the edges of the git experience (GUIs,
  import/export/etc) can benefit from python.  git-p4
  is one example.  git-weave is another.

Are there any arguments against it for these use cases?


BTW, Felipe, if you're going to be rewriting python code to ruby,
please, pretty please rewrite that darn GUI ;-)

You can call it "git-new-cola: project kansas"

http://en.wikipedia.org/wiki/New_Coke

I expect a patch by the morning ;-p

I kid, of course, but if you do pull it off I WILL buy you a soda-pop!
-- 
David
