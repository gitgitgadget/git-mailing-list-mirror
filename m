From: Jan Hudec <bulb@ucw.cz>
Subject: Re: GIT and SCC
Date: Sun, 16 Nov 2008 22:51:34 +0100
Message-ID: <20081116215134.GA4719@efreet.light.src>
References: <1225909527.8578.10.camel@terrenisrv1.terrenis.net> <20081105182506.GO15463@spearce.org> <e2b179460811051111y2d6e4c5eq19c8b58b93f942a9@mail.gmail.com> <1225913035.8578.18.camel@terrenisrv1.terrenis.net> <20081105193824.GA9266@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Terreni <martin@terrenis.net>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Nov 16 22:53:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1pYT-0003t4-H4
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 22:53:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595AbYKPVvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 16:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752499AbYKPVvo
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 16:51:44 -0500
Received: from mail4customers.bluetone.cz ([212.158.128.5]:45537 "EHLO
	mail.bluetone.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752595AbYKPVvn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 16:51:43 -0500
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by mail.bluetone.cz (Spam Firewall) with ESMTP
	id E0736280194; Sun, 16 Nov 2008 22:51:39 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145]) by mail.bluetone.cz with ESMTP id jWucoj4iwOXP4Ecf; Sun, 16 Nov 2008 22:51:39 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1L1pWo-0001b1-Cf; Sun, 16 Nov 2008 22:51:34 +0100
Content-Disposition: inline
In-Reply-To: <20081105193824.GA9266@mit.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101164>

On Wed, Nov 05, 2008 at 14:38:25 -0500, Theodore Tso wrote:
> On Wed, Nov 05, 2008 at 09:23:55PM +0200, Martin Terreni wrote:
> > 
> > http://en.wikipedia.org/wiki/SCC_compliant
> > 
> > It is probably not much, but this is what I could find in a minute. many
> > VC system have a SCC complaint API (apart of the native). This protocol
> > was created by M$ is used by many systems so they are not bound to a
> > specific VC tool.
> 
> It's a closed-source, undocumented API that you can only get access to
> by signing a Microsoft NDA.   From the WinMerge API:
> 
> 	SCC API is closed API (no public documentation available) some
> 	IDE's (e.g. Visual Studio) use. There apparently have couple
> 	of reverse-engineered free implementations for SCC API. Status
> 	of those are unknown.
> 
> 	WARNING: Be very sure you are not submitting any code behing
> 	NDA for WinMerge. WinMerge is Open Source so it is not legal
> 	to do. And what is worse it would prevent anybody reading that
> 	code working with SCC (and perhaps also VCS) support.
> 

I don't really know what this interface is about, but:
 - For VS6 and newer, source control plugin can be implemented by creating
   a dll exporting particular set of controls. This is documented in help
   files that come with VS2005 SDK which is freely downloadable from M$ web,
   so I don't think that would be under NDA.
 - For VS2003 and newer (ie. the .NET based versions), plugins can be
   implemented for almost anything, including source control, by creating
   .net assembly exporting classes that implement some particular interfaces.
   These interfaces are documented in the abovementioned SDK, so again no NDA
   needed.
I actually started writing such plugin some months back, but since I can only
work on it at $work (don't have Windooze at ~, not to mention VS2005 license
-- the SDK is free to download, but requires full, non-express, studio) and
since it does not look like I could get them use Git at $work anytime soon,
I didn't work on it too much. Still I could share the basic skeleton and
the knowledge I have if somebody wanted to move that somewhere.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
