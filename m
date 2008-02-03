From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Documentation/git-reset.txt: Use HEAD~N syntax everywhere (unify examples)
Date: Sun, 3 Feb 2008 22:30:24 +0300
Message-ID: <20080203193024.GV29522@dpotapov.dyndns.org>
References: <3asc6spe.fsf@blue.sea.net> <7v7iho6p2m.fsf@gitster.siamese.dyndns.org> <20080202084406.GA15305@glandium.org> <8x235xa8.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sun Feb 03 20:31:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLkYS-00035y-WF
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 20:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbYBCTad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 14:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbYBCTac
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 14:30:32 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:59489 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbYBCTab (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 14:30:31 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1753905fga.17
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 11:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=qON0n1SWN0MWbpPJH1Fj6o/CyVwEz3UhzTEdRTQ+FSs=;
        b=YPlGbCbnhLt6N7i4QMnxNeKTNN0/d8XqeUUH5mMTNfa1IFrcNk7d7u6WoUkh6AQ6Bu9YAVchXiULBmNx7dZ0eku+KhMdjNxiDlCj2JaVfC4ygIho7jk2C033RWzkxfMEmKWfKAFvX8aX9NrDDVRlntRO/b/dhCCmXGXmMVI0yjU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=g9/GsLFzMjxBPqUT8WVTZMb0vL0HX+cB/lYU8Z3QPYuH0yJG0o06Tk2yrZ/tx8O5C2MuugjctMDp1HnOc6uc8H5/hnM/Rq2mBHo9KxJ0Bee9POgXo+bqDvAV2QKXpqS58fzT5p4fqW+EfPh+47OBNFbUm1HvQvgDAS7h8ZLL5gQ=
Received: by 10.82.172.10 with SMTP id u10mr11390013bue.14.1202067029834;
        Sun, 03 Feb 2008 11:30:29 -0800 (PST)
Received: from localhost ( [85.141.189.132])
        by mx.google.com with ESMTPS id d13sm9851580fka.19.2008.02.03.11.30.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Feb 2008 11:30:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8x235xa8.fsf@blue.sea.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72396>

On Sat, Feb 02, 2008 at 02:59:43PM +0200, Jari Aalto wrote:
> 
> I use HEAD~1 always, because I think the consistency in learning the
> most important factor.

People may have different preferences and there is nothing wrong with
that. However, imposing a single style on everyone is *wrong*. What you
propose is to hide a legitimate syntax on the ground that you do not use
it, and I don't think that is a good enough reason.

> It does not matter what advanced users use. The documentation should
> primarily focus the newcomers.

Wrong... and wrong again. First, this documentation is intended for all
users.  It is not "SVN Crash Course" or something like that intended for
newcomers. Second, there is nothing wrong with having more than one way
to express the same thing, and newcomers should be aware of that even if
they prefer to use HEAD~1 all the time.  If you don't tell them that,
they may be confused when encounter it later, and they will encounter it
sooner or later, because many of us use this ^-syntax.

> Those used to git may prefer ^, but it does not follow that others
> necessarily do so and that that should be the "proper learning path".

It seems to me that your "proper learning path" is based solely on
what you prefer, and not everyone shares your preferences here. In fact,
^-syntax is very natural to specify the _previous_ commit. Have you
notice we usually say "previous", not "one commit before"?

> People usually migrate to git from other VCSs, which have very
> consistent UI - There are no alternatives
> 
>     -r1:10      Subversion
>     -r1..19     Bzr
>     ...etc

First of all, this comparison is incorrect, because SVN uses fixed
numbers, which does not change over time. The true equivalent of that
numbers in Git is SHA-1. ~N-syntax is *alternative*, which is useful
when you think in relative terms, and it is rarely used with for large
N. Second, deficiency of other SCMs is not a good enough reason for Git
to impose the same restriction on its users.

Besides, I don't know about Bzr, but SVN CLI is insane. If you need to
do something simple, like compare your working directory with some tag,
you end up typing:

 $ svn diff --old=A_VERY_LONG_URL/tags/tagname --new=.

with Git you can do that as simple as

 $ git diff tagname

Before SVN 1.4, there was no option to show the change made by some
revision, so you had to type: svn diff -r PREV_REV:REV. One would think
that after they added '-c' in SVN 1.4, no one needs to do that manually,
but this option does not work in one of most common case:

 $ svn diff -c HEAD
 svn: Non-numeric change argument given to -c

so you need to figure out what is the number of the HEAD manually, and
only then you can use 'svn diff -c'.

With git, you can do that easily:
 $ git show


Also, using 'svn switch' to switch between branches is slow and painful
as hell. First, you have to type A_VERY_LONG_URL and if you happen to
forgot to check in some changes, you end up with completely mess in your
working directory. 'git checkout' has much more consistent behavior, and
it does not destroy your work...


So, IMNSHO, recent versions of Git is way easier to use than SVN even
in those cases where SVN provides similar functionality...



Dmitry
