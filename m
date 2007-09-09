From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] diff-delta.c: rename {a,}{entry,hash} to {,u}{entry,hash}
Date: Sat, 08 Sep 2007 20:38:03 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0709082036040.21186@xanadu.home>
References: <0cd39105dcd57a60eca290db598613aafcc8c577.1189243702.git.dak@gnu.org>
 <f1161c08aeeca60b6c33af34ccea68fd99b9ea4e.1189243702.git.dak@gnu.org>
 <alpine.LFD.0.9999.0709081648281.21186@xanadu.home>
 <85abrwuas8.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Sep 09 10:57:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IUIOE-0003oI-Jd
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 10:43:34 +0200
Received: from mail-mx9.uio.no ([129.240.10.39])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUAtY-0002LN-VC
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 02:43:24 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx9.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUAtS-000380-Ed
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 02:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755451AbXIIAiI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 20:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755431AbXIIAiH
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 20:38:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:53737 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443AbXIIAiG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 20:38:06 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JO20068XSFHA230@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 08 Sep 2007 20:38:05 -0400 (EDT)
In-reply-to: <85abrwuas8.fsf@lola.goethe.zz>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.6, required=12.0, autolearn=disabled, AWL=0.357,UIO_VGER=-3)
X-UiO-Scanned: F399D5FC4C0E97EF76F5468822C1F582C4EE4391
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -25 maxlevel 200 minaction 2 bait 0 mail/h: 31 total 517817 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58159>

On Sat, 8 Sep 2007, David Kastrup wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Sat, 8 Sep 2007, David Kastrup wrote:
> >
> >> The variables for the packed entries are now called just entry and
> >> hash rather than aentry+ahash, and those for the unpacked entries have
> >> been renamed to uentry and uhash from the original entry and hash.
> >> 
> >> While this makes the diff to the unchanged code larger, it matches the
> >> type declarations better.
> >
> > Since the packed version is used less often, could you rename that one 
> > instead, and use packed_entry and packed_hash forclarity.
> >
> > Also please fold this with your other patch (not the culling one).
> 
> Uh, what other patch?  If I don't do the renames in the second patch,
> then only the first patch remains.  Which I'll change to use the
> proposed names.  Hope that's what you meant.

Yes, that's what I meant.

> > Then you can add my ACK.
> 
> I'll do that, and rework the culling patch on top of that (unacked for
> now).

I'm looking at it atm.


Nicolas
