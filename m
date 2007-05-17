From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Smart fetch via HTTP?
Date: Wed, 16 May 2007 21:26:03 -0400
Message-ID: <20070517012602.GV3141@spearce.org>
References: <20070515201006.GD3653@efreet.light.src> <46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com> <Pine.LNX.4.64.0705161232120.6410@racer.site> <46a038f90705161426n3b928086t2d3e68749557f866@mail.gmail.com> <Pine.LNX.4.64.0705170152470.6410@racer.site> <20070517010335.GU3141@spearce.org> <Pine.LNX.4.64.0705161803580.1280@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Thu May 17 03:26:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoUlV-0003ZC-9e
	for gcvg-git@gmane.org; Thu, 17 May 2007 03:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755058AbXEQB0O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 21:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756022AbXEQB0O
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 21:26:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43856 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755058AbXEQB0N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 21:26:13 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HoUkc-0005Ka-4H; Wed, 16 May 2007 21:25:54 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DD9D820FBAE; Wed, 16 May 2007 21:26:03 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705161803580.1280@asgard.lang.hm>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47476>

david@lang.hm wrote:
> On Wed, 16 May 2007, Shawn O. Pearce wrote:
> >
> >The other thing is kernel.org should really try to encourage the
> >folks with repositories there to try and share against one master
> >repository, so the poor OS has a better chance at holding the bulk
> >of linux-2.6.git in buffer cache.
> 
> do you mean more precisely share against one object store or do you really 
> mean repository?

Sorry, I did mean "object store".  ;-)

Repository is insanity, as the refs and tags namespaces are suddenly
shared.  What a nightmare that would become.

-- 
Shawn.
