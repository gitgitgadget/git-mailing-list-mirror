From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 06:28:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707260614500.14781@racer.site>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
 <fcaeb9bf0707250513v587d7a92lb688b52da3c28bb7@mail.gmail.com>
 <a1bbc6950707251926t11e1d0f7p8e8cd8c936f7ff72@mail.gmail.com>
 <7vps2fc196.fsf@assigned-by-dhcp.cox.net> <20070726031838.GO32566@spearce.org>
 <7v6447bxc1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 07:28:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDvu0-0005oD-V9
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 07:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbXGZF2m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 01:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbXGZF2m
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 01:28:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:54749 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751163AbXGZF2k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 01:28:40 -0400
Received: (qmail invoked by alias); 26 Jul 2007 05:28:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 26 Jul 2007 07:28:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19aEHNv0vVakAq9shEMjOnh2XJ3p/WPpzkLAANk+9
	a4eZs+yxt03Ln7
X-X-Sender: gene099@racer.site
In-Reply-To: <7v6447bxc1.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53767>

Hi,

On Wed, 25 Jul 2007, Junio C Hamano wrote:

> If that is the case, "Git for Windows" probably should package MSYS as 
> part of it, I would think, to match the expectation of the users there.  
> I know two Johannes'es and Han-Wen spent quite a lot of effort on 
> Windows port and packaging, but perhaps that little (well, I should not 
> be judging if that is a little or huge, as I do not do Windows) 
> finishing touch would make Windows users much happier?

Windows users are only happy when they can bug developers.

Seriously again, the biggest problem with Han-Wen's installer was that it 
insists on cross-compiling _all_ the packages.  This makes it easy for 
Han-Wen to upgrade packages and compile the thing on Linux in one go.  
However, it never worked with bash, and I could not fix it: I can read 
Python, but not _that_ Python.

So my plan was to wrap everything needed from an existing MinGW/MSYS 
installation, with a minimal installer (NullSoft or whatever) to setup the 
exec dir, perl lib path etc...

However, my time is scarce, and it does not exactly help that all I can 
expect from those who should be thankful is even more complaining.

I mean, I understand Linus' point.  I don't even expect a Windows user to 
compile C.  It's long time since I was silly enough to believe that.  But 
just wrapping it up in an installer, and a little testing, seems to be too 
much to ask.  When I don't need the darned thing to begin with.

Ciao,
Dscho
