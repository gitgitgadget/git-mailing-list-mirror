From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: branch management
Date: Tue, 9 Jun 2009 21:50:18 +0200
Message-ID: <20090609195018.GA17848@blimp.localdomain>
References: <7vfxe9udln.fsf@alter.siamese.dyndns.org> <4A2E0C88.70805@gmail.com> <20090609080612.GG9993@laphroaig.corp> <7viqj5nzgz.fsf@alter.siamese.dyndns.org> <20090609172302.GH9993@laphroaig.corp> <08614AC584A6ED42BD836DE9286376E12A211FA9CA@spswchi6mail1.peak6.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Harry Duin <hduin@optionshouse.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 07:37:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEGVW-0004ZF-8u
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 07:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811AbZFJFhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 01:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754830AbZFJFha
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 01:37:30 -0400
Received: from mout2.freenet.de ([195.4.92.92]:55658 "EHLO mout2.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752996AbZFJFh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 01:37:29 -0400
Received: from [195.4.92.16] (helo=6.mx.freenet.de)
	by mout2.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #88)
	id 1MEGV6-0006hi-UY; Wed, 10 Jun 2009 07:37:29 +0200
Received: from x5662.x.pppool.de ([89.59.86.98]:36009 helo=tigra.home)
	by 6.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #79)
	id 1MEGV5-0006RJ-UH; Wed, 10 Jun 2009 07:37:28 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 51579277D8;
	Wed, 10 Jun 2009 07:37:24 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id D2B0236D28; Tue,  9 Jun 2009 21:50:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <08614AC584A6ED42BD836DE9286376E12A211FA9CA@spswchi6mail1.peak6.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121250>

Harry Duin, Tue, Jun 09, 2009 19:35:24 +0200:
> My questions are on branch management. 

You seem to think about branches as they are in CVS or SVN (just
directories with in-system metadata). You'll find the Git's branching
different (being more about history, not at all about directory
structure).

> 1. We have different repos for doing the integration merging. In
> addition to that we have a golden repos, containing what is in
> production. The branch history gets pushed by developers to the
> integration repos, but not to the golden repos. Since our integration
> repos are created for each integration, this means I have lost my
> branch history when an integration repos gets deleted..

No. As long as there is something, basing its history on the history
of the integration repos (and I assume that your "golden", aka
"release" or "maintenance" elsewhere, do just that) the history is
there. Forever. As it is on every developers machine with a
distributed VCS.

> 2. What command do I use to display only the list of files updated by/for a
> branch?

Do you mean the files changed since the branch (presumably "development")
diverged from some other branch (presumably "golden")?
What for?

> This means I want to exclude files that were merged in from say
> master - these files are not part of the branch development.

You better not exclude files (and while at it, stop thinking about
files when working with _history_).

Try describing the problem on _change_ (aka "commit", or point in time
or history) level.

P.S. Your (re?)mailer seems to be broken. This mail is not very
correct base64 and gmail does not even decode it.
