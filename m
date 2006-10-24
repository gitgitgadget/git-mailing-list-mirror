From: "=?ISO-8859-1?Q?Erik_B=E5gfors?=" <zindar@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 24 Oct 2006 09:52:36 +0200
Message-ID: <845b6e870610240052l70ad72f4ma30065f151828dfd@mail.gmail.com>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	 <845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com>
	 <87zmbozau2.wl%cworth@cworth.org>
	 <20061022185350.GW75501@over-yonder.net>
	 <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org>
	 <20061023222131.GB17019@over-yonder.net> <ehjgli$lft$1@sea.gmane.org>
	 <845b6e870610231614y681e64eu33bb0806f530c742@mail.gmail.com>
	 <Pine.LNX.4.64.0610231623340.3962@g5.osdl.org>
	 <46a038f90610231739x5beffc90u33c6a81f461974ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Jakub Narebski" <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 09:52:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcH5W-0007wY-2G
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 09:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbWJXHwj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006 03:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbWJXHwj
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 03:52:39 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:14277 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1752109AbWJXHwh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 03:52:37 -0400
Received: by py-out-1112.google.com with SMTP id z74so123561pyg
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 00:52:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XYRNdvuA5skCefpung5x2NVIvN7NUwD6HF4yH69IIMVz+2jDNEU8CXJzKgzI6YzLypLkzIkziWYMx8YiVBZl7DphPIjL7BiNHIhZPrSazwhYmkipSKtoYDdITvovJP2VANSbXNUfDqmznHqEHPlgngFDXpisBlbayZRD3UHShzM=
Received: by 10.35.66.12 with SMTP id t12mr8366514pyk;
        Tue, 24 Oct 2006 00:52:36 -0700 (PDT)
Received: by 10.35.116.4 with HTTP; Tue, 24 Oct 2006 00:52:36 -0700 (PDT)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90610231739x5beffc90u33c6a81f461974ec@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29941>

On 10/24/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 10/24/06, Linus Torvalds <torvalds@osdl.org> wrote:
> > On Tue, 24 Oct 2006, Erik B=E5gfors wrote:
> > >
> > > I don't see any problem doing a "gitk --all" equivalent in bzr.
> >
> > The problem? How do you show a commit that is _common_ to two branc=
hes,
> > but has different revision names in them?
>
> Eric,

It's Erik :)

> coming from an Arch background, I understand the whole per-branch
> commitids approach. After using GIT for a while, you start realising
> that it tries to pin down things in the wrong place.
>
> This is specially visible if you run `gitk --all` before and after a
> merge. Or on a project with many merges (if you can, get a checkout o=
f
> git itself, and browse its history with gitk).
>
> Before the merge, you see
>
>  --o--o--o--o
>     \
>      \--o--o
>
> and after
>
>  --o--o--o--o
>     \        \
>      \--o--o--o
>
> Now, after it's merged somewhere, both commits are part of its
> history, regardless of where they come from. And it is very clear if
> two branches have been merging and remerging.
>
> Where a commit originated does not matter. And fancy
> repo-and-branch-centric names get in the way. A lot. And they re
> mostly meaningless as soon as you put what matters in the commit
> message. Which means that that bit of metadata that you are hoping
> that the revno keeps "indirectly" isn't lost on cherry picking.

Let's make one thing clear.  Revnos are NOT stored with the revision,
they are not "names" of the revision.  They are basically just
shortcuts to specific revisions, that only makes sence in the context
of a branch.

As human beings this is something we are very used to in everyday
life. I don't always call my friends with firstname and surname, I
just use first name or even "mate".  As long as it's clear who I'm
talking about in that contect.  If there are multiple people with the
same first name, then we might have to use the surname as well.

Same with bzr. In the context of a branch, revnos works as shortcuts
to the revision id.  In the context of multiple branches, they don't.

I think they do serve a good purpose but I don't really think that we
absolutely need them either.

> I guess that's where I used to find revnos useful as they contained
> some basic metadata. With bzr it seems to be author-repo-branch where
> branch is hopefully "line of work" but all of that can be (and should
> be) in the commit message.
>
> You can see similar info in the first part of the commit message for
> most git-hosted projects. It'll say something like
>
>    cvsserver: fix the frobnicator to be sequential
>
> which means that at that point, you could be working in a branch
> called fix-this-fscking-thing-attempt524" and no-one would know ;-)
>
> And in a few years (even months) time, that bit of metadata you were
> hoping to keep is totally irrelevant. What you have in the commit
> message remains relevant and useful.

I'm not even going to try to understand the argument here as they are
about a totally different thing and doesn't make any sense to me.

I think this disussion is getting out of hand.

There are a few things that are being discussed
1. Revnos are bad/good
2. treating "leftmost" parrent special is bad/good
3. plugins are useless/useful
4. And now, storing branch information should be done manually (if
wanted) and not automatically.

1. I don't really care, I haven't seen any confusion based on it, but
I don't have a very strong opinion about it either.
2. This is something I do care about.  For me, this is the only
logical way of doing it. It might be because I am used to it now, but
when I started to look at bzr/hg/git/darcs/etc, I just got a so much
more clear view of the history when running a standard log command,
that it was one of the first things that attracted me to bzr. This is
just a user talking.
There might be technical reasons why it's better to not do it, but for
me it works the way I expect, therefore I'm happy
3. This is just silly
4. No comment.

/Erik
