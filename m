From: Nix <nix@esperi.org.uk>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Tue, 24 Jul 2007 07:56:00 +0100
Message-ID: <87y7h6l27z.fsf@hades.wkstn.nix>
References: <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
	<alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
	<85abttwa7m.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
	<7vbqe93qtv.fsf@assigned-by-dhcp.cox.net>
	<20070719053858.GE32566@spearce.org>
	<20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr>
	<20070719105105.GA4929@moonlight.home>
	<86zm1sbpeh.fsf@lola.quinscape.zz>
	<20070719123214.GB4929@moonlight.home>
	<863azka7d4.fsf@lola.quinscape.zz> <87ps2inab5.fsf@hades.wkstn.nix>
	<85y7h6dewp.fsf@lola.goethe.zz> <87lkd6n62i.fsf@hades.wkstn.nix>
	<85k5sqdavo.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707231527050.3607@woody.linux-foundation.org>
	<86ps2ithyl.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jul 24 08:56:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDEJa-0002W2-PN
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 08:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754514AbXGXG4M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 02:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754473AbXGXG4L
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 02:56:11 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:45107 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143AbXGXG4K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 02:56:10 -0400
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id l6O6u1is003506;
	Tue, 24 Jul 2007 07:56:01 +0100
Received: (from nix@localhost)
	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id l6O6u1Ip028846;
	Tue, 24 Jul 2007 07:56:01 +0100
Emacs: because extension languages should come with the editor built in.
In-Reply-To: <86ps2ithyl.fsf@lola.quinscape.zz> (David Kastrup's message of "Tue, 24 Jul 2007 08:48:50 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
X-DCC-WEiAPG-Metrics: hades 1072; Body=3 Fuz1=3 Fuz2=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53527>

On 24 Jul 2007, David Kastrup spake thusly:
> But merging will become nicer if the permissions actually stay
> associated with the file rather than the file name.  Even in things
> like /etc backups, blobs not infrequently relocate from one place to
> another when the system gets updated.

Even without that we'd need to merge without context, i.e. with totally
independent lines, for such a file. So it's not the standard git file
merge.
