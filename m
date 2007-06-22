From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Make list of features auto-managed.
Date: Fri, 22 Jun 2007 11:59:20 +0200
Message-ID: <200706221159.20395.Josef.Weidendorfer@gmx.de>
References: <20070621045903.GA14047@spearce.org> <alpine.LFD.0.99.0706212337030.20596@xanadu.home> <20070622043329.GE17393@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 22 11:59:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1fvQ-0005Le-Qh
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 11:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbXFVJ7a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 05:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbXFVJ7a
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 05:59:30 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:45184 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751202AbXFVJ73 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jun 2007 05:59:29 -0400
Received: from dhcp-3s-51.lrr.in.tum.de (dhcp-3s-51.lrr.in.tum.de [131.159.35.51])
	by mail.in.tum.de (Postfix) with ESMTP id 260A9F4C;
	Fri, 22 Jun 2007 11:59:28 +0200 (MEST)
User-Agent: KMail/1.9.7
In-Reply-To: <20070622043329.GE17393@spearce.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50685>

On Friday 22 June 2007, Shawn O. Pearce wrote:
> > Now you say that you don't want to wait for the release to happen before 
> > using this cool new feature.  Well, I'd reply that life is tough.  
> 
> In comparsion to other things we all must deal with in life, this
> is a cakewalk.  ;-) But yes, your point is well made.

Hmm... Perhaps I am missing something.

IMHO this discussion is about how to cope with different versions of two
programs depending on each other, but being released in a loosely coupled way
(this is a problem Xorg now has with their independent releases of Xorg modules).

However, git-gui is released together with git (also in the foreseeable
future, even if we use submodules some day).
And therefore, a git user always will get installations of matching versions
of git and git-gui; this is even true for developers who run "make install"
in git source.

So IMHO there is no version check needed at all in this case. Anybody who
is installing git in strange partial ways should expect to be screwed.

Josef
