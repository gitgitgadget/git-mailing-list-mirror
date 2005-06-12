From: Petr Baudis <pasky@ucw.cz>
Subject: [zooko@zooko.com: [Revctrl] colliding md5 hashes of human-meaningful documents]
Date: Sun, 12 Jun 2005 10:25:55 +0200
Message-ID: <20050612082555.GB6620@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sun Jun 12 10:21:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhNim-0007fT-3M
	for gcvg-git@gmane.org; Sun, 12 Jun 2005 10:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVFLI0C (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Jun 2005 04:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVFLI0C
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jun 2005 04:26:02 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45240 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261845AbVFLIZ5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jun 2005 04:25:57 -0400
Received: (qmail 10843 invoked by uid 2001); 12 Jun 2005 08:25:55 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

----- Forwarded message from zooko@zooko.com -----

There is nothing theoretically surprising about this, but hopefully its
concreteness and the accompanying scenario will make an impression on people
on people.  The same technique should work to generate two documents with
identical SHA1 hashes.

http://www.cits.rub.de/MD5Collisions/

----- End forwarded message -----

I expected the two postscript files differing in some huge binary blob,
but it turns out the binary part is very small (about 256 bytes) and
only few (about nine) bytes are different, contrary to how people have
predicted the collisions. This is much more close to finding a collision
between similar pure C files, I think. Rather unsettling.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
