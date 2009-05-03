From: Miles Bader <miles@gnu.org>
Subject: Re: [JGIT PATCH 8/6] Fix zero context insert and delete hunk headers to match CGit
Date: Sun, 03 May 2009 09:50:36 +0900
Message-ID: <8763gjdn6r.fsf@catnip.gol.com>
References: <20090503000540.GN23604@spearce.org>
	<20090503001423.GO23604@spearce.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun May 03 02:51:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0PvF-0000Kx-0O
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 02:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753202AbZECAuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2009 20:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753039AbZECAux
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 20:50:53 -0400
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:47035 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719AbZECAux (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 20:50:53 -0400
Received: from 218.231.174.23.eo.eaccess.ne.jp ([218.231.174.23] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	id 1M0Puf-0002Xb-TH; Sun, 03 May 2009 09:50:37 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id DA0F2DFA9; Sun,  3 May 2009 09:50:36 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <20090503001423.GO23604@spearce.org> (Shawn O. Pearce's message
	of "Sat, 2 May 2009 17:14:23 -0700")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118156>

"Shawn O. Pearce" <spearce@spearce.org> writes:
>   And here is that hack.  It just feels wrong to me that I need
>   to subtract 1 from the Edit region's line numbers, *only* when
>   context is 0, in order to get the same output as CGit.

A big comment saying "this may look a bit funny, but it's the standard's
fault: [text from std...]" might help salve the wound...

-Miles

-- 
.Numeric stability is probably not all that important when you're guessing.
