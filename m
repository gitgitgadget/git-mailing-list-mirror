From: Eric Blake <ebb9@byu.net>
Subject: Re: [PATCH 11/17] Fully activate the sliding window pack access.
Date: Sat, 23 Dec 2006 12:34:18 -0700
Message-ID: <458D84BA.5040301@byu.net>
References: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org> <20061223073428.GL9837@spearce.org> <Pine.LNX.4.64.0612231038410.3671@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 20:49:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyCry-0005kM-Ga
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 20:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724AbWLWTtT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 14:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753730AbWLWTtT
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 14:49:19 -0500
Received: from alnrmhc13.comcast.net ([204.127.225.93]:59626 "EHLO
	alnrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712AbWLWTtS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 14:49:18 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Dec 2006 14:49:18 EST
Received: from [192.168.0.103] (c-67-186-254-72.hsd1.co.comcast.net[67.186.254.72])
          by comcast.net (alnrmhc13) with ESMTP
          id <20061223193419b1300q7m3ve>; Sat, 23 Dec 2006 19:34:19 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.9) Gecko/20061207 Thunderbird/1.5.0.9 Mnenhy/0.7.4.666
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612231038410.3671@woody.osdl.org>
X-Enigmail-Version: 0.94.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35328>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Linus Torvalds on 12/23/2006 11:44 AM:
> 
> In particular, in any setup that doesn't like mmap() at all (eg Cygwin), 
...
> So maybe you should make the default depend on NO_MMAP (although it would 
> seem that the default Makefile makes Cygwin actually default to using mmap 
> these days, so maybe it's not a big deal).

Indeed, on cygwin, using the 1.4.4.3 Makefile setting where NO_MMAP is
commented out, I have not seemed to have any mmap problems.

- --
Life is short - so eat dessert first!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFjYS684KuGfSFAYARAu4hAKDFfGVrgH0dnxkPHiUdrkAxz8waDQCgwGTo
jbUOvu8uI372BYxK2zHftjs=
=5Rwv
-----END PGP SIGNATURE-----
