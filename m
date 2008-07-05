From: Alex Riesen <fork0@users.sourceforge.net>
Subject: Re: git sequencer prototype
Date: Sat, 5 Jul 2008 10:13:21 +0200
Message-ID: <20080705081321.GA4935@blimp.local>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <20080704210052.GA6984@steel.home> <7vwsk1ti6y.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 05 10:26:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KF35q-0000Xt-KQ
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 10:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbYGEIZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 04:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbYGEIZJ
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 04:25:09 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:34563 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbYGEIZH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 04:25:07 -0400
X-Greylist: delayed 661 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Jul 2008 04:25:07 EDT
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20lf4ETTSQ==
Received: from tigra.home (Faba5.f.strato-dslnet.de [195.4.171.165])
	by post.webmailer.de (mrclete mo62) (RZmta 16.47)
	with ESMTP id v00d6dk657v2aC ; Sat, 5 Jul 2008 10:14:04 +0200 (MEST)
	(envelope-from: <fork0@users.sourceforge.net>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id E9AB7277BD;
	Sat,  5 Jul 2008 10:14:03 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id ADEF036D18; Sat,  5 Jul 2008 10:13:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vwsk1ti6y.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87437>

Junio C Hamano, Sat, Jul 05, 2008 00:09:41 +0200:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > Stephan Beyer, Tue, Jul 01, 2008 04:38:30 +0200:
> >> Hi,
> >> 
> >> here is the patchset for the git-sequencer prototype, documentation,
> >> test suite and a first git-am and git-rebase-i migration.
> >> Indeed, monster patches. ;)
> >
> > BTW, how about renaming it in something short: git seq. There is
> > already a seq(1) in GNU coreutils, which does roughly the same (prints
> > a sequence of numbers), why not reuse the name?
> 
> Is it advantageous to use shorter but less descriptive name for this
> command?  It will be a backend to am/rebase and not something the users
> will type from the command line, won't it?

There is not a huge lot of possible meanings of "seq" in the given
context. Somehow I find it hard to believe someone will be confused by
a backend command with a short name "seq" (seq-uence-something?)

It'll make the lines shorter, less need to wrap them.

BTW, what does "am" (git am) mean?
