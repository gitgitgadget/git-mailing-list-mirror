From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 11:06:55 -0400
Message-ID: <BAYC1-PASMTP074A2D2B30CAF96E374229AE0E0@CEZ.ICE>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	<45345AEF.6070107@utoronto.ca>
	<200610171030.35854.jnareb@gmail.com>
	<vpqejt76vgz.fsf@ecrins.imag.fr>
	<BAYC1-PASMTP02ADC5BEF688E61583283CAE0E0@CEZ.ICE>
	<vpqbqob5euu.fsf@ecrins.imag.fr>
	<BAYC1-PASMTP10E107E5EB0F7E69167F41AE0E0@CEZ.ICE>
	<vpqejt73vln.fsf@ecrins.imag.fr>
	<BAYC1-PASMTP10F617306F1477E66FA441AE0E0@CEZ.ICE>
	<vpqlknf10u5.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 17:07:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZqWz-0002PP-0U
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 17:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWJQPG6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 11:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWJQPG6
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 11:06:58 -0400
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:33848 "EHLO
	BAYC1-PASMTP07.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1751113AbWJQPG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 11:06:57 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP07.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 17 Oct 2006 08:12:42 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GZpap-00067R-9n; Tue, 17 Oct 2006 10:06:55 -0400
To: Matthieu Moy <Matthieu.Moy@imag.fr>
Message-Id: <20061017110655.f7bcf3f1.seanlkml@sympatico.ca>
In-Reply-To: <vpqlknf10u5.fsf@ecrins.imag.fr>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 17 Oct 2006 15:12:42.0453 (UTC) FILETIME=[B1423050:01C6F1FE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 17 Oct 2006 16:19:46 +0200
Matthieu Moy <Matthieu.Moy@imag.fr> wrote:

> Sure. As I said before, the little add-on of checkouts is that you say
> once "I don't want to do local commit here", and bzr reminds you this
> each time you commit. Well, where it can make a difference is that it
> does it in a transactional way, that is, you don't have that little
> window between the time you pull and the time you push your next
> commit. But this would really be bad luck ;-).

Yeah, it would be bad luck, but Git wouldn't actually let the push
succeed if someone had changed the upstream repo in that small window.
It would complain that your push wasn't a fast forward and ask you
to update before pushing.

> Sure. And at least, if you want to prove that your decentralized SCM
> is the best, you'd better look at features other than the ability to
> commit on a local branch ;-). If you want a _real_ flamewar, better
> talk about rename management or revision identity.
> 
> The thing is that most people migrated from CVS/svn, so they found
> their new SCM to be incredibly better the existing. But it's generally
> not _so_ much better than the other modern alternatives ;-). (and
> don't forget to thank Darcs and Monotone who brought most of the good
> ideas you and I are using)

Heh, true enough.  And the fact is they're all "borrowing" the
best ideas from one another.  All of a sudden the others are all
getting git-like bisect and gitk guis.  And of course Linus has
said that he got quite a bit of inspiration from Monotone
originally.

Beyond the distributed offline nature of using Git, the killer
"feature" for me is its raw speed and flexibility[1].  It's
really nice to be able to branch in under a second and try
out a line of development etc.  Maybe this is just as easy
in Bazaar but it's not true of say Mercurial.  Honestly, I
just can't imagine any other SCM meeting my needs better than
Git.  So I have a hard time taking complaints about rename
management or revision identity seriously.

While they don't affect my usage, IMHO the two biggest failings
of Git are its lack of a shallow clone and its reliance on shell
and other scripting languages so there is no native Windows version.
I'm sure both of these areas are handled better by Bazaar and/or
some of the other new SCMs where they'd be a better choice than
Git.

Sean

[1] As an aside, I don't understand why bazaar pushes the idea
of "plugins".  For instance someone mentioned that bazaar has
a bisect "plugin".  Well Git was able to add a bisect "command"
without needing a plugin architecture.. so i'm at a loss as 
to why plugins are seen as an advantage.
