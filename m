From: David Kastrup <dak@gnu.org>
Subject: Re: Empty directories...
Date: Wed, 18 Jul 2007 23:37:30 +0200
Message-ID: <85644hxujp.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz>
	<Pine.LNX.4.64.0707180135200.14781@racer.site>
	<858x9ez1li.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
	<vpq4pk1vf7q.fsf@bauges.imag.fr>
	<alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 23:37:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBHDG-0007m7-Nt
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 23:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759657AbXGRVhf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 17:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757977AbXGRVhf
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 17:37:35 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:40265 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758058AbXGRVhe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 17:37:34 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id C4A4D1FD018;
	Wed, 18 Jul 2007 23:37:32 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 9449A12D747;
	Wed, 18 Jul 2007 23:37:32 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-086-214.pools.arcor-ip.net [84.61.86.214])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 5080F30A7AE;
	Wed, 18 Jul 2007 23:37:32 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id BF08F1C3ACCF; Wed, 18 Jul 2007 23:37:30 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org> (Linus Torvalds's message of "Wed\, 18 Jul 2007 10\:06\:13 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3696/Wed Jul 18 14:56:36 2007 on mail-in-03.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52901>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 18 Jul 2007, Matthieu Moy wrote:
>> 
>> If you checkout a branch, create an empty directory in this branch
>> (probably a placeholder, either for future versionned files, or for
>> generated files), you cannot tell git "this empty directory is in this
>> branch, but not in other ones" without adding a file in it.
>
> Right. Which is the suggested setup: add an empty ".gitignore" file
> to the directory, and you're done.

That implies that every directory in a versioned tree will exclusively
be created under manual and conscious control.  Not by running some
installer or script, unpacking some archive and so on.  But if every
content on a disk was created and put there under manual control of
the disk owner, we could still get along with floppy disks quite fine.
In practice, much more content gets sent around and juggled than what
is under immediate supervision of the user.

This is getting silly: you don't need to pull out rabbits out of your
head.  You said that you are not inclined to do any work in that area
since it does not touch _your_ use cases (well, at least not to a
degree that you consider worth bothering about) but that is no reason
to get into ridiculous arguments about other usage.  No code will come
of that.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
