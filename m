From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] diff-delta.c: rename {a,}{entry,hash} to {,u}{entry,hash}
Date: Sat, 08 Sep 2007 23:06:47 +0200
Message-ID: <85abrwuas8.fsf@lola.goethe.zz>
References: <0cd39105dcd57a60eca290db598613aafcc8c577.1189243702.git.dak@gnu.org>
	<f1161c08aeeca60b6c33af34ccea68fd99b9ea4e.1189243702.git.dak@gnu.org>
	<alpine.LFD.0.9999.0709081648281.21186@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Sep 08 23:07:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IU7WB-00029x-Vk
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 23:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286AbXIHVG4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 17:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752271AbXIHVGz
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 17:06:55 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:33499 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752285AbXIHVGz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Sep 2007 17:06:55 -0400
Received: from mail-in-13-z2.arcor-online.net (mail-in-13-z2.arcor-online.net [151.189.8.30])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 21F241F54A2;
	Sat,  8 Sep 2007 23:06:54 +0200 (CEST)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-13-z2.arcor-online.net (Postfix) with ESMTP id 096671B8E42;
	Sat,  8 Sep 2007 23:06:54 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-020-082.pools.arcor-ip.net [84.61.20.82])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id DA5C412F10;
	Sat,  8 Sep 2007 23:06:49 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 5DE591CAD71D; Sat,  8 Sep 2007 23:06:47 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.9999.0709081648281.21186@xanadu.home> (Nicolas Pitre's message of "Sat\, 08 Sep 2007 16\:52\:04 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4200/Sat Sep  8 21:00:15 2007 on mail-in-11.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58137>

Nicolas Pitre <nico@cam.org> writes:

> On Sat, 8 Sep 2007, David Kastrup wrote:
>
>> The variables for the packed entries are now called just entry and
>> hash rather than aentry+ahash, and those for the unpacked entries have
>> been renamed to uentry and uhash from the original entry and hash.
>> 
>> While this makes the diff to the unchanged code larger, it matches the
>> type declarations better.
>
> Since the packed version is used less often, could you rename that one 
> instead, and use packed_entry and packed_hash forclarity.
>
> Also please fold this with your other patch (not the culling one).

Uh, what other patch?  If I don't do the renames in the second patch,
then only the first patch remains.  Which I'll change to use the
proposed names.  Hope that's what you meant.

> Then you can add my ACK.

I'll do that, and rework the culling patch on top of that (unacked for
now).

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
