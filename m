From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Fri, 18 May 2007 10:43:08 +0200
Message-ID: <200705181043.09203.Josef.Weidendorfer@gmx.de>
References: <200705170539.11402.andyparkins@gmail.com> <200705180141.06862.Josef.Weidendorfer@gmx.de> <200705180857.18182.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 18 10:44:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hoy45-00041f-Iq
	for gcvg-git@gmane.org; Fri, 18 May 2007 10:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957AbXERInt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 04:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754488AbXERInt
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 04:43:49 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:51567 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753957AbXERIns (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2007 04:43:48 -0400
Received: from dhcp-3s-44.lrr.in.tum.de (dhcp-3s-44.lrr.in.tum.de [131.159.35.44])
	by mail.in.tum.de (Postfix) with ESMTP id 296A2292F;
	Fri, 18 May 2007 10:43:47 +0200 (MEST)
User-Agent: KMail/1.9.6
In-Reply-To: <200705180857.18182.andyparkins@gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47579>

On Friday 18 May 2007, Andy Parkins wrote:
> Bear in mind that what you're suggesting is no different in implementation 
> >from what Junio is suggesting but with one difference: in Junio's option 
> the "identifier" will act as a default URL if no override is found.

Yes; actually, its exactly the same aside from the name used in .gitmodules
for it, as I proposed a default URL which is derived from the suproject identifier
if no config entry is found.

> > Again, we could have a default URL in the absence of this config entry
> > which is relative to the URL of the superproject, and which allows for the
> > superproject repository to act as proxy.
> 
> This is why Junio's option of URL=Key is better.

It all depends on how we construct the default URL out of the subproject
identifier. Options:
(1) do not try to construct a default URL at all. Error out without a config
(2) use a configurable rewriting scheme like s/(.*)/git://host/\1/
(3) automatically detect a senseful rewriting scheme

Let's start with (1). We can invent convenient default schemes later on.


Josef
