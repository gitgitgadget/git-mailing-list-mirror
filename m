From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: How git affects kernel.org performance
Date: Sun, 07 Jan 2007 16:06:50 +0100
Message-ID: <m3odpazxit.fsf@defiant.localdomain>
References: <20061214223718.GA3816@elf.ucw.cz>
	<20061216094421.416a271e.randy.dunlap@oracle.com>
	<20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com>
	<1166297434.26330.34.camel@localhost.localdomain>
	<1166304080.13548.8.camel@nigel.suspend2.net>
	<459152B1.9040106@zytor.com>
	<1168140954.2153.1.camel@nigel.suspend2.net>
	<45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, nigel@nigel.suspend2.net,
	"J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932557AbXAGPG4@vger.kernel.org Sun Jan 07 16:07:26 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932557AbXAGPG4@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3ZcM-0002Ue-GN
	for glk-linux-kernel-3@gmane.org; Sun, 07 Jan 2007 16:07:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbXAGPG4 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 7 Jan 2007 10:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbXAGPG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 10:06:56 -0500
Received: from khc.piap.pl ([195.187.100.11]:41093 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932557AbXAGPGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 10:06:55 -0500
Received: by khc.piap.pl (Postfix, from userid 500)
	id B7EEFCA82; Sun,  7 Jan 2007 16:06:50 +0100 (CET)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <45A083F2.5000000@zytor.com> (H. Peter Anvin's message of "Sat, 06 Jan 2007 21:24:02 -0800")
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36172>

"H. Peter Anvin" <hpa@zytor.com> writes:

> During extremely high load, it appears that what slows kernel.org down
> more than anything else is the time that each individual getdents()
> call takes.  When I've looked this I've observed times from 200 ms to
> almost 2 seconds!  Since an unpacked *OR* unpruned git tree adds 256
> directories to a cleanly packed tree, you can do the math yourself.

Hmm... Perhaps it should be possible to push git updates as a pack
file only? I mean, the pack file would stay packed = never individual
files and never 256 directories?

People aren't doing commit/etc. activity there, right?
-- 
Krzysztof Halasa
