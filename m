From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] diff-delta.c: rename {a,}{entry,hash} to {,u}{entry,hash}
Date: Sat, 08 Sep 2007 16:52:04 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0709081648281.21186@xanadu.home>
References: <0cd39105dcd57a60eca290db598613aafcc8c577.1189243702.git.dak@gnu.org>
 <f1161c08aeeca60b6c33af34ccea68fd99b9ea4e.1189243702.git.dak@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Sep 08 22:52:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IU7Hq-0007nY-9V
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 22:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbXIHUwJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 16:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752200AbXIHUwJ
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 16:52:09 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23587 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbXIHUwI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 16:52:08 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JO200LZ7HYUFM00@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 08 Sep 2007 16:52:07 -0400 (EDT)
In-reply-to: <f1161c08aeeca60b6c33af34ccea68fd99b9ea4e.1189243702.git.dak@gnu.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58136>

On Sat, 8 Sep 2007, David Kastrup wrote:

> The variables for the packed entries are now called just entry and
> hash rather than aentry+ahash, and those for the unpacked entries have
> been renamed to uentry and uhash from the original entry and hash.
> 
> While this makes the diff to the unchanged code larger, it matches the
> type declarations better.

Since the packed version is used less often, could you rename that one 
instead, and use packed_entry and packed_hash forclarity.

Also please fold this with your other patch (not the culling one).

Then you can add my ACK.


Nicolas
