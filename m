From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Inconsistencies with git log
Date: Thu, 8 Nov 2007 22:21:23 +0100
Message-ID: <20071108212123.GA4899@steel.home>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com> <Pine.LNX.4.64.0711072242230.4362@racer.site> <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com> <Pine.LNX.4.64.0711072255420.4362@racer.site> <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com> <243E1E6E-4723-42D3-933C-D2A0D1ACE287@silverinsanity.com> <ee77f5c20711071531q5acc4d06u264f5daad7c04cc4@mail.gmail.com> <47325415.1070205@op5.se> <ee77f5c20711080516n4f207ba3pccc8efffa2a6ad4c@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 22:22:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqEop-0001QW-W7
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 22:21:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761114AbXKHVV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 16:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761013AbXKHVV1
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 16:21:27 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:49428 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759927AbXKHVV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 16:21:26 -0500
Received: from tigra.home (Fc819.f.strato-dslnet.de [195.4.200.25])
	by post.webmailer.de (klopstock mo5) (RZmta 14.0)
	with ESMTP id Y047adjA8I8i9a ; Thu, 8 Nov 2007 22:21:23 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id A7E31277AE;
	Thu,  8 Nov 2007 22:21:23 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 3E40C56D22; Thu,  8 Nov 2007 22:21:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ee77f5c20711080516n4f207ba3pccc8efffa2a6ad4c@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWowxOg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64073>

David Symonds, Thu, Nov 08, 2007 14:16:59 +0100:
> I never suggested path *limited*, only path *relative*. git-status
> would still show all the same files, but their paths would be relative
> to your current directory, so there'd be no confusion like you
> mentioned. This is how Johannes' patch works.

Relative? Like this?

$ cd project/foo/bar
$ git status
...
    M file1.c
    M file2.c
    M ../baz/file3.c
    R ../bax/file4 => file4.c
