From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Fri, 18 May 2007 11:18:17 +0200
Message-ID: <200705181118.17307.Josef.Weidendorfer@gmx.de>
References: <200705170539.11402.andyparkins@gmail.com> <464CF435.1010405@midwinter.com> <20070518045025.GT4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Steven Grimm <koreth@midwinter.com>,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@cam.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri May 18 11:19:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hoyc7-0002ER-TS
	for gcvg-git@gmane.org; Fri, 18 May 2007 11:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbXERJS5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 05:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754776AbXERJS5
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 05:18:57 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:51933 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752330AbXERJS4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2007 05:18:56 -0400
Received: from dhcp-3s-44.lrr.in.tum.de (dhcp-3s-44.lrr.in.tum.de [131.159.35.44])
	by mail.in.tum.de (Postfix) with ESMTP id 38E0A27D5;
	Fri, 18 May 2007 11:18:55 +0200 (MEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070518045025.GT4489@pasky.or.cz>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47584>

On Friday 18 May 2007, Petr Baudis wrote:
> The problem is ugly too, though - suddenly, you have created a SINGLE
> UNIVERSE-WIDE NAMESPACE INSIDE A DISTRIBUTED VCS. And that's not going
> to work well.

Actually, tags are already such a namespace. If you want to merge
two projects which have the same tag names, of course you still
preserve the different tag objects, but only one will appear in the
refs/tags namespace.

So what is the best identifier for a subprobject? It is one that
probably never clashes with any subproject identifier of another
superproject. At least, it should not clash between any superprojects
which ever could be a candidate for merging the two into one.

Junios proposal using an URL as identifier actually is quite good in
this regard, similar to JAVA package names.

However, I wonder whether the possible merge of two superprojects
into one is a real issue. When they use the same subprojects identifiers,
there is a workaround: instead of merging, make one superproject the
subproject of the other.

Josef
