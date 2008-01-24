From: Nicolas Pitre <nico@cam.org>
Subject: Re: On pathnames
Date: Thu, 24 Jan 2008 17:31:27 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0801241722130.22568@xanadu.home>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org>
 <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org>
 <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org> <20080122133427.GB17804@mit.edu>
 <20080123000841.GA22704@mit.edu>
 <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org>
 <20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org>
 <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org>
 <20080123094052.GB6969@glandium.org> <20080123133802.GC7415@mit.edu>
 <alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org>
 <98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org>
 <alpine.LFD.1.00.0801230930390.1741@woody.linux-foundation.org>
 <7vprvr7x8h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>, Theodore Tso <tytso@MIT.EDU>,
	Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 23:32:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIAcB-0005qA-Ey
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 23:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbYAXWbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 17:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753368AbYAXWbf
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 17:31:35 -0500
Received: from relais.videotron.ca ([24.201.245.36]:26972 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149AbYAXWbe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 17:31:34 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JV600DWF6KFK350@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 24 Jan 2008 17:31:29 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vprvr7x8h.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71667>

On Thu, 24 Jan 2008, Junio C Hamano wrote:

> If it is a new file, we won't find any name that is equivalent
> to $A in the index, and we use the name $A obtained from
> readdir(3).
> 
> BUT with a twist.
> 
> If the filesystem is known to be inconveniently case folding, we
> are better off registering $B instead of $A (assuming we can
> convert from $A to $B).

Why?

If you have no other representation for the file name than $A already, 
then I don't see why Git would have to play similar evil games and 
corru^H^H^Hnvert $A into $B.  Just store $A in the index and tree 
objects and be done with it.


Nicolas
