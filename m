From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Wed, 27 Apr 2005 22:47:32 +0200
Message-ID: <87br8054m3.fsf@deneb.enyo.de>
References: <aec7e5c305042608095731d571@mail.gmail.com>
	<200504261138.46339.mason@suse.com>
	<aec7e5c305042609231a5d3f0@mail.gmail.com>
	<20050426135606.7b21a2e2.akpm@osdl.org>
	<Pine.LNX.4.58.0504261405050.18901@ppc970.osdl.org>
	<20050426155609.06e3ddcf.akpm@osdl.org> <426ED20B.9070706@zytor.com>
	<871x8wb6w4.fsf@deneb.enyo.de>
	<20050427151357.GH1087@cip.informatik.uni-erlangen.de>
	<426FDFCD.6000309@zytor.com>
	<20050427190144.GA28848@cip.informatik.uni-erlangen.de>
	<426FF799.4000501@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, magnus.damm@gmail.com,
	mason@suse.com, mike.taht@timesys.com, mpm@selenic.com,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 22:43:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQtMg-0007VC-BN
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 22:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVD0Ury (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 16:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVD0Ury
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 16:47:54 -0400
Received: from mail.enyo.de ([212.9.189.167]:64917 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S262004AbVD0Urv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 16:47:51 -0400
Received: from deneb.enyo.de ([212.9.189.171])
	by albireo.enyo.de with esmtp id 1DQtRW-0001F3-SI; Wed, 27 Apr 2005 22:47:34 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.50)
	id 1DQtRU-00052Q-T7; Wed, 27 Apr 2005 22:47:32 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <426FF799.4000501@zytor.com> (H. Peter Anvin's message of "Wed,
	27 Apr 2005 13:35:37 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* H. Peter Anvin:

> Only if you read every single file in each directory every time.  I 
> thought mutt did header indexing and thus didn't need to do that.

There was a patch for Mutt which implemented header indexing, but it
was buggy and had to be removed (from Debian).  After that, directory
sorting (actually, it's a merge sort 8-) practically became mandatory
on ext3 with directory hashing.

I think that in the meantime, the has been integrated into upstream
CVS (I don't know if it's been released as a developer snapshot,
though).  The header indexing patch may have been revived for Debian,
I think it was fixed recently.
