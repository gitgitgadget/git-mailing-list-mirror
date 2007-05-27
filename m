From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Sun, 27 May 2007 22:40:20 +0200
Message-ID: <20070527204020.GI955MdfPADPa@greensroom.kotnet.org>
References: <11799589913153-git-send-email-skimo@liacs.nl>
 <Pine.LNX.4.64.0705240039370.4113@racer.site>
 <7vtzu3yrh9.fsf@assigned-by-dhcp.cox.net>
 <20070524072216.GE942MdfPADPa@greensroom.kotnet.org>
 <20070524072945.GO28023@spearce.org>
 <20070524073652.GH942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241039200.4648@racer.site>
 <20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241201270.4648@racer.site>
 <20070527203442.GC8361@admingilde.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Sun May 27 22:40:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsPXQ-0004hb-UY
	for gcvg-git@gmane.org; Sun, 27 May 2007 22:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629AbXE0UkX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 16:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753616AbXE0UkX
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 16:40:23 -0400
Received: from smtp14.wxs.nl ([195.121.247.5]:58196 "EHLO smtp14.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808AbXE0UkW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 16:40:22 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp14.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JIP00MLHW388M@smtp14.wxs.nl> for git@vger.kernel.org; Sun,
 27 May 2007 22:40:21 +0200 (CEST)
Received: (qmail 15077 invoked by uid 500); Sun, 27 May 2007 20:40:20 +0000
In-reply-to: <20070527203442.GC8361@admingilde.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48578>

On Sun, May 27, 2007 at 10:34:42PM +0200, Martin Waitz wrote:
> On Thu, May 24, 2007 at 12:02:41PM +0100, Johannes Schindelin wrote:
> > As we do for the refs: put it into .git/info/refs. This file is already 
> > meant to "cache" the output of ls-remote for dumb protocols.
> 
> why on earth do you want to store a subproject SHA1 in the
> superproject.git?

Did you read that sentence after writing it?

Anyway, we already concluded further down the thread that
it wouldn't make sense to put any particular subproject SHA-1
in the superproject's info/refs.

skimo
