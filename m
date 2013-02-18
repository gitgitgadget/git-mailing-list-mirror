From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Tue, 19 Feb 2013 02:14:54 +0530
Message-ID: <CALkWK0mKZLotuu7pEM_3Of3i6JzU12QV_pHxOZTUr22TOq3PeQ@mail.gmail.com>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch> <20130218174239.GB22832@sigill.intra.peff.net>
 <20130218193424.GC3234@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Barr <b@rr-dav.id.au>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 21:45:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Xat-0007fR-UU
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 21:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757317Ab3BRUpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 15:45:19 -0500
Received: from mail-bk0-f52.google.com ([209.85.214.52]:48113 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494Ab3BRUpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 15:45:16 -0500
Received: by mail-bk0-f52.google.com with SMTP id jk13so2678477bkc.25
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 12:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=IRQyvFF4nW4ZfQ0nwcFlOzgv6zuwYeneBYriPOep/Uc=;
        b=Gb3CKO9tx/ZHE0Ajnnjlx+q2kVxikGbKQvuK+gQtFN2f1sFxeYBnSix4CaAH4jnxzv
         xgAo2L+TcXc9FZZYnUexKZMegi53nCJOIJ1UN+yDDqyKv8UpUYDgMaNG6TNh4i90vUAB
         Z+08onbimItTMa7Mpsw/NAyEJTtAHrLimZl+QKAQQE4y0wgzX1TT978pXyCVmuCeTgum
         VJ4BTimxaHDyP3vrNt0aixocThNki17Z5NNMjlc13i724EdxwxELm1jEIA8nGjXId82j
         INkOqcAO6eMK86dmWsu+4PxRP2uhjwzhvyhqviIdT5Y85HicxbOtoTHQj7gAUdhWOCPy
         PDAw==
X-Received: by 10.204.150.134 with SMTP id y6mr5365392bkv.15.1361220314442;
 Mon, 18 Feb 2013 12:45:14 -0800 (PST)
Received: by 10.205.81.202 with HTTP; Mon, 18 Feb 2013 12:44:54 -0800 (PST)
In-Reply-To: <20130218193424.GC3234@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216517>

Jonathan Nieder wrote:
> Hi,
>
> Jeff King wrote:
>
>> I will do it again, if people feel strongly about Git being a part of
>> it. However, I have gotten a little soured on the GSoC experience. Not
>> because of anything Google has done; it's a good idea, and I think they
>> do a fine of administering the program. But I have noticed that the work
>> that comes out of GSoC the last few years has quite often not been
>> merged, or not made a big impact in the codebase, and nor have the
>> participants necessarily stuck around.
>
> I think that if we can commit enough time to mentor well it's
> worthwhile.  Even such a negative result is useful, since it can teach
> us how good or poor we are at bringing new contributors in and what
> parts of that process need more work.

The point is that we must be willing to spend time learning what went
wrong the previous summer, and how to improve upon it.  There's no
point in doing a lather-rinse-repeat after many consecutive failures.

> Some potential projects (unfiltered --- please take them with a grain
> of salt):
>
>  - cross-compilable git

Why, exactly?  Git for embedded devices?

>  - incorporation of the cgit web interface, or formalizing a subset of
>    libgit.a to export as a stable library to it

I didn't understand this: you want cgit in-tree?

>  - moving forward on a project that was the subject of a previous
>    gsoc project: line-level logging, "rebase --interactive" on top of
>    sequencer, usable svn remote helper

I can't see a roadmap for gradually phasing out `rebase -i` as more
and more of its functionality is built into the sequencer.  Would you
start by using `cherry-pick --continue` in the special case of
consecutive `pick` or `revert` operations (yuck)?  The sequencer
currently has a continuation logic that we can leverage, but how will
it call out to shell functions to do specific tasks (like `fixup`,
which is not yet implemented)?  Really, the only way I see is to
duplicate the functionality of `rebase -i` in C, and throw away the
shell script when we're sure we're done.

For usable svn remote helper, the major TODO is a git -> svn bridge.
My previous effort (which was a long time) was stalled because we
needed a way to persist blobs of text referenced by marks, and
retrieve them on demand.  Building this bridge is hard enough already,
and I think we should just focus on an independent git -> svn bridge
to put into contrib/svn-fi as a deliverable.  It doesn't have to have
anything to do with remote helpers at all.

>  - drag-and-drop cherry-pick in gitk

You expect someone to write Tcl/Tk today?  Do a `git log gitk-git/`
and tell me how many people are writing it.

>  - a sub-library of code shared with libgit2 (might be hard because
>    our notions of strings are different :().
>
>  - assimilating the distro builds: "make deb-pkg", "make rpm-pkg",
>    etc along the same lines as the linux kernel's script/package/,
>    to help people get recent git installed when they want it

Overkill.  I just symlink to bin-wrapper/git from a place high up in
my $PATH.  If anything, we should be making it easier for ourselves to
run different versions of git right from $HOME, much like rbenv.
System-wide installs are taken care of by the distribution package
managers, and I doubt they need any help from us.

>  - collaborative notes editing: fix the default notes refspec,
>    make sure the "notes pull" workflow works well and is documented
>    well, offer an easy way to hide private notes after the fact
>    without disrupting public history

I personally don't care for notes much, because I can't see practical
usecases.  I'd much rather fix something that's much more widely used
and broken: submodules.
