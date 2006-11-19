X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [Fwd: Re: What's in git.git]
Date: Sun, 19 Nov 2006 12:40:06 -0500
Message-ID: <9e4733910611190940y147992b8mbdfac5a51f42e0fe@mail.gmail.com>
References: <20061119171135.GA13054@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 19 Nov 2006 17:42:26 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HsbTPnP+yie5QgShU8lluFIz3oE9khe2hbRn4hjkmZibziVEMmmYSWNuBXeUP7B/IFaOqP7RWO2FF/xANClPUpRWGQx+yHOiBTQhPXwUFFP0MW0fbTqxoPkgGp0Ot3unvQQCVzOy8B1w4zDpv6L+uM2bgcfAnbUhFIPeDFmQ8CY=
In-Reply-To: <20061119171135.GA13054@spearce.org>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.88.6/2203/Sat Nov 18 04:54:38 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31842>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlqgQ-00082P-K4 for gcvg-git@gmane.org; Sun, 19 Nov
 2006 18:42:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756812AbWKSRmS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 12:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756814AbWKSRmS
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 12:42:18 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:3537 "EHLO
 zeus1.kernel.org") by vger.kernel.org with ESMTP id S1756812AbWKSRmR (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 12:42:17 -0500
Received: from py-out-1112.google.com (py-out-1112.google.com
 [64.233.166.183]) by zeus1.kernel.org (8.13.8/8.13.1) with ESMTP id
 kAJHg0kC020294 for <git@vger.kernel.org>; Sun, 19 Nov 2006 17:42:14 GMT
Received: by py-out-1112.google.com with SMTP id a25so894149pyi for
 <git@vger.kernel.org>; Sun, 19 Nov 2006 09:40:27 -0800 (PST)
Received: by 10.35.119.11 with SMTP id w11mr6739671pym.1163958006547; Sun, 19
 Nov 2006 09:40:06 -0800 (PST)
Received: by 10.35.72.13 with HTTP; Sun, 19 Nov 2006 09:40:06 -0800 (PST)
To: "Shawn Pearce" <spearce@spearce.org>, "Git Mailing List"
 <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

On 11/19/06, Shawn Pearce <spearce@spearce.org> wrote:
> Have you been watching the shallow clone threads?

Some friends of mine are doing a start up that is sort of like a Sonos
system but with some major differences. I've been helping them out so
I've been doing chip design and PCB layouts lately. The system also
needs some really complicated real-time, wireless mesh routing
software, I wish the OLPC 802.11s code was ready.

Brendan told me that he would not consider Mozilla moving to git until
a native Windows version is released so I just dropped the whole
thing. It is too much effort and they don't even really want it. They
are probably going to switch to SVN.  I told him that SVN would end up
being a disaster and he got mad at me. That's when I stopped working
on cvs2svn/git.

The shallow clone work is being done in the wrong order to get the
Mozilla people interested.
#1) There needs to be a tool that can accurately import the
repository. cvs2svn does not do this. The good programmers working on
git could probably whip this out in a week or two if they wanted to.
cvs2svn is very close but they refuse to solve the symbol dependency
problem.
#2) git needs native Windows support, this probably includes MSVC
integration. There are a lot of non-technical people working on
Mozilla like accessibility, doc, artwork, translations, they are all
on Windows. Brendan explicitly ruled out cygwIn.
#3) Once #1 and #2 are achieved then they will care about shallow clone.

The only way I can see Mozilla moving to git is if the git community
ports the repository for them and then demonstrates that all of the
needed tools and available and working.

> ---------- Forwarded message ----------
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> To: Junio C Hamano <junkio@cox.net>
> Date: Sun, 19 Nov 2006 16:17:17 +0100 (CET)
> Subject: Re: What's in git.git
> Hi,
>
> On Sat, 18 Nov 2006, Junio C Hamano wrote:
>
> > Junio C Hamano <junkio@cox.net> writes:
> >
> > >  - 'pu' has the shallow clone WIP and a half-finished rewrite of
> > >    git branch in C, both by Johannes.  Both needs a bit more
> > >    polishing and confidence building before going into 'next',
> > >    and given the recent discussion of enhancing branch
> > >    management for pulls/pushes, it might be easier to drop the
> > >    latter for now.
> >
> > OOPS; sorry but the latter half is entirely untrue.  What's
> > there is half-done git-shortlog.  Scratch everything about
> > branch management please.
>
> IMHO -shortlog needs support to read .mailmap, and maybe nods to throw out
> the built-in mailmap which is totally specific to the Linux kernel
> development.
>
> As for shallow clone support: I am a bit underwhelmed by the enthusiasm
> to test this thing by the people I thought would be most interested. It
> really could be the case that it is not needed at all.
>
> Just for the record, though: AFAICT the shallow stuff is lacking support
> for at least pushing from/into shallow repos and it should avoid making a
> commit shallow unnecessarily. And quite likely there are a few thinkos in
> it, so it would not hurt having more test cases (notably of things I did
> not think of), and some bad-ass testing with huge amounts of commits and
> files which were added/modified identically in different commits.
>
> Ciao,
> Dscho
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>


-- 
Jon Smirl
