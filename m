From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Figured out how to get Mozilla into git
Date: Sun, 18 Jun 2006 12:26:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606181223580.5498@g5.osdl.org>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
 <46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com>
 <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606111747110.2703@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 18 21:26:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fs2uw-00014S-4K
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 21:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWFRT0j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 15:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWFRT0j
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 15:26:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12949 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932299AbWFRT0i (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 15:26:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5IJQPgt029858
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Jun 2006 12:26:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5IJQOkX001983;
	Sun, 18 Jun 2006 12:26:25 -0700
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0606111747110.2703@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22098>



On Sun, 11 Jun 2006, Nicolas Pitre wrote:
> 
> Then I used git-repack -a -f --window=20 --depth=20 which produced a 
> nice 468MB pack file along with the invariant 45MB index file for a 
> grand total of 535MB for the whole repo (the .git/refs/ directory alone 
> still occupies 17MB on disk).

Btw, can others with that mozilla repo confirm that a mozilla repository 
that has been repacked seems to be entirely fine, but git-fsck-objects 
(with "--full", of course) will report

	error: Packfile .git/objects/pack/pack-06389c21fc3c4312cbc9a4ddde087c907c1a840b.pack SHA1 mismatch with itself

for me (the fsck then completes with no other errors what-so-ever, so the 
contents are actually fine).

Or is it just me?

		Linus
