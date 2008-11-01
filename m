From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git/Mercurial interoperability (and what about bzr?)
Date: Sat, 01 Nov 2008 03:33:43 -0700 (PDT)
Message-ID: <m3prlffzk2.fsf@localhost.localdomain>
References: <ge0rla$mce$1@ger.gmane.org> <ge70nl$l6t$1@ger.gmane.org>
	<alpine.DEB.1.00.0810281445190.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	<Pine.LNX.4.64.0810281536360.27029@ds9.cixit.se>
	<E026EBDF-F402-49AB-A7A8-0A0EFB513907@ai.rug.nl>
	<20081028191234.GS24201@genesis.frugalware.org>
	<20081028213144.GC10862@mit.edu> <87ljw3zx8i.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Sat Nov 01 11:35:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwDor-0005t4-Ec
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 11:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbYKAKdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 06:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbYKAKdr
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 06:33:47 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:14837 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbYKAKdq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 06:33:46 -0400
Received: by ey-out-2122.google.com with SMTP id 6so603888eyi.37
        for <git@vger.kernel.org>; Sat, 01 Nov 2008 03:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=1+o8TID//bSOkG+3u/901t83th/+MYD6/kJSN1tS7MQ=;
        b=bqW+bOUhAX4tkDYfNyhoJGfpfGK/Ml9gi7CcRkbL9P/5dakIYpz1m+KI5q1gsdoSVt
         qKHHiaeC7q1pWiuQfvNL26CoFdxuNmYtSsSfXL8cCPLGS89G0o/Jor6LGNzM2QRcqUKy
         bWslc50+3qNWV+8+/+qyJFsnamGlcEDQ55jaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=MMH8c/oZVEU5ZSdk7788y0pPN5r7vbzeOh6cfxzGdGJ0b3EFIeH2dF1A8Z6sY5bgmu
         lvRtHvsFMZwwJJyh8xpC9Kw5nrQeEvcjnQN9Tr5deLAEmVSYKIA8GmiyANIjMRPhBvhM
         B3qKGFszMxYcTr7D08pUYJMAUKR+dB0aAcUoE=
Received: by 10.210.45.14 with SMTP id s14mr14764588ebs.72.1225535624519;
        Sat, 01 Nov 2008 03:33:44 -0700 (PDT)
Received: from localhost.localdomain (abvc198.neoplus.adsl.tpnet.pl [83.8.200.198])
        by mx.google.com with ESMTPS id 33sm3183679nfu.7.2008.11.01.03.33.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 Nov 2008 03:33:43 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mA1Baf4u002676;
	Sat, 1 Nov 2008 12:36:51 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mA1BaU3P002673;
	Sat, 1 Nov 2008 12:36:30 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <87ljw3zx8i.fsf@mid.deneb.enyo.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99726>

Florian Weimer <fw@deneb.enyo.de> writes:
> * Theodore Tso:
> 
> > In the past I've looked at the possibility of creating a
> > bi-directional, incremental gateway between hg and git repositories.
> > The main thing which makes this difficult is that hg stores tags
> > in-band inside the change-controlled .hgtags file.  This means that if
> > you cut a release, tag it, and then create a commit to further modify
> > the repository, the new commit is descended from the tag commit,
> > whereas in git, the tag is a "bookmark" --- perhaps signed via GPG,
> > but not part of the revision history.
> 
> Couldn't you just keep the .hgtags file and have everyone interested
> in the tags use special scripts?
> 
> (Admittedly, I'm horribly totally by Git's behavior in this area.  I
> haven't figured out yet under what circumstances tags are pushed and
> pulled, so I'm not totally opposed to the Mercurial model. 8-/)

I think you don't understand the issue here.

First, I think that we all agree here that by definition tags should
named reference (for example 'v1.0' or '1.0') to some immutable
snapshot of a state of repository, so for example when somebody says
'v1.0' everybody knows what it is.  In Git tags are immutable (you
can't checkout a tag, you can only checkout state pointed by tag)
external pointers to commits in the DAG (graph) of revisions.

Global tags (tags used to mark releases like 'v1.0') have to _not
versioned_ and _transferable_.  Transferable (global) because we want
to know for example what 'v1.0' version was in each clone / each
repository.  Non-versioned because we want to have the same set of
tags independent on what branch we are (when we are on 'master', we
want to be able to know about 'v1.0.1' which is on 'maint'), and what
revision we have checked out (for example during bisection, we want to
be able to compare to 'v1.0' even if we have checked out revision
which is earlier than 'v1.0').

Do you agree that global tags should be both non-versioned and
trasferable?

Now Mercurial has chosen to use in-tree '.hgtags' file to have global
tags transferable.  Never mind the fact that it had to treat this file
in special way to have it non-versioned (as opposed to for example
.*ignore file, which should be both transferable and versioned); the
fact that in-tree file is used means that tag is visible to outside
(transferable) only after you commit changes in .hgtags file.

In Git tags are external to object database; they reside in
refs/tags/* namespace.  They are of course non-versioned, as not being
in-tree.  In default configuration however (from what I understand) if
you transfer (get) some tagged commit, you also get a tag that points
to transferred commit.  You don't need to create "PROJECT 1.0" (or
"Tagged v1.0") commit to make tag visible to outside.


In short, if you want to have bi-directional gateway between Mercurial
and Git, Git has to be limited:
 * no octopus merges (with more than two parents)
 * always create 'tagging commits' (bump version number for example)
   for tagging purposes on Mercurial side.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
