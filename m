From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Tue, 10 Apr 2007 21:29:04 +0200
Message-ID: <200704102129.04548.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <200704101828.37453.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0704101122510.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 00:56:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbM1i-0000he-TD
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 21:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284AbXDJT3M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 15:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753312AbXDJT3L
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 15:29:11 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:48935 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753284AbXDJT3L (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Apr 2007 15:29:11 -0400
Received: from dhcp-3s-51.lrr.in.tum.de (dhcp-3s-51.lrr.in.tum.de [131.159.35.51])
	by mail.in.tum.de (Postfix) with ESMTP id 453B628FF;
	Tue, 10 Apr 2007 21:29:09 +0200 (MEST)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0704101122510.6730@woody.linux-foundation.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44145>

On Tuesday 10 April 2007, Linus Torvalds wrote:
> 	[module "kdelibs"]
> 		dir = kdelibs
> 		url = git://git.kde.org/kdelibs
> 		description = "Basic KDE libraries module"
> 
> 	[module "base"]
> 		alias = "kdelibs", "kdebase", "kdenetwork"

So when moving the kdelibs submodule around, you would
have to update the .gitmodules file.

I like it.

Josef
