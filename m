From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Thu, 23 Jun 2005 10:30:25 +0200
Message-ID: <20050623083025.GA5066@ucw.cz>
References: <42B9FCAE.1000607@pobox.com> <Pine.LNX.4.58.0506221724140.11175@ppc970.osdl.org> <42BA14B8.2020609@pobox.com> <Pine.LNX.4.58.0506221853280.11175@ppc970.osdl.org> <42BA1B68.9040505@pobox.com> <Pine.LNX.4.58.0506221929430.11175@ppc970.osdl.org> <42BA271F.6080505@pobox.com> <Pine.LNX.4.58.0506222014000.11175@ppc970.osdl.org> <42BA45B1.7060207@pobox.com> <Pine.LNX.4.58.0506222225010.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262611AbVFWIsv@vger.kernel.org Thu Jun 23 10:52:47 2005
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262611AbVFWIsv@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlNRC-0000ii-8B
	for glk-linux-kernel@gmane.org; Thu, 23 Jun 2005 10:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbVFWIsv (ORCPT <rfc822;glk-linux-kernel@m.gmane.org>);
	Thu, 23 Jun 2005 04:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVFWIqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:46:07 -0400
Received: from styx.suse.cz ([82.119.242.94]:8898 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S263048AbVFWIa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 04:30:26 -0400
Received: from shadow.suse.cz (shadow.suse.cz [10.20.1.74])
	by mail.suse.cz (SUSE CR ESMTP Mailer) with ESMTP id 4A3BE628321;
	Thu, 23 Jun 2005 10:30:25 +0200 (CEST)
Received: by shadow.suse.cz (Postfix, from userid 10002)
	id 3A71512CC34; Thu, 23 Jun 2005 10:30:25 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506222225010.11175@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 10:58:13PM -0700, Linus Torvalds wrote:

> And thinking that "fetching a tree fetches all the tags from that tree"  
> really _is_ a stupid decision. It's missing the big picture. It's missing
> the fact that tags _should_ be normal every-day things that you just use
> as "book-marks", and that the kind of big "synchronization point for many
> people" tag should actually be the _rare_ case.
> 
> The fact that global tags make that private "bookmark" usage impossible
> should be a big red blinking sign saying "don't do global tags".

Maybe it'd make sense to differentiate between the two types of tags?
To have local tags which don't propagate, and global (version) tags
which do? They could live in different namespaces and thus wouldn't
interfere.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
