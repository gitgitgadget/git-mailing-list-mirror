From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Now What?
Date: Thu, 3 Nov 2005 23:17:15 +0100
Message-ID: <200511032317.15393.Josef.Weidendorfer@gmx.de>
References: <E1EXTw5-00063o-Gt@jdl.com> <7vll05e9j3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Nov 03 23:18:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXnOf-0005Pj-2u
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 23:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbVKCWRV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 17:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbVKCWRV
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 17:17:21 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:38083 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1751401AbVKCWRU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 17:17:20 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id EE16B22FF
	for <git@vger.kernel.org>; Thu,  3 Nov 2005 23:17:16 +0100 (MET)
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <7vll05e9j3.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11102>

On Thursday 03 November 2005 21:55, Junio C Hamano wrote:
> be better suited to Wiki.  I wonder if there is a Wiki whose
> document storage format is in asciidoc, and uses git as its
> revision control backend.

I wonder if Git is the best SCM for a Wiki, as you want per-file
revisions in a Wiki: when reverting a page to a previous version,
this should not modify other pages.
So you have an index and a HEAD for every file.
To snapshot a state of such a multihead repository, it would be
nice to have tag objects able to hold multiple SHAs of commits.
Or can we use tree objects for this?

Josef
