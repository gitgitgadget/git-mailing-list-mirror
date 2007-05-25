From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Fri, 25 May 2007 18:28:38 +0200
Message-ID: <20070525162838.GI942MdfPADPa@greensroom.kotnet.org>
References: <Pine.LNX.4.64.0705241230410.4648@racer.site>
 <20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241315290.4648@racer.site>
 <8c5c35580705240541j7f632fc4lbd308c9386c2bde6@mail.gmail.com>
 <7vabvuywix.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0705241030440.26602@woody.linux-foundation.org>
 <20070524175519.GU942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241908040.4648@racer.site>
 <20070525100030.GB942MdfPADPa@greensroom.kotnet.org>
 <7vabvsswtd.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Hjemli <hjemli@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 25 18:34:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrcjq-0001ZF-9W
	for gcvg-git@gmane.org; Fri, 25 May 2007 18:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbXEYQdb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 12:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbXEYQdb
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 12:33:31 -0400
Received: from smtp16.wxs.nl ([195.121.247.7]:56332 "EHLO smtp16.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789AbXEYQda (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 12:33:30 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp16.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JIL00IKHV3QJY@smtp16.wxs.nl> for git@vger.kernel.org; Fri,
 25 May 2007 18:28:39 +0200 (CEST)
Received: (qmail 18825 invoked by uid 500); Fri, 25 May 2007 16:28:38 +0000
In-reply-to: <7vabvsswtd.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48393>

On Fri, May 25, 2007 at 09:16:30AM -0700, Junio C Hamano wrote:
> Sven Verdoolaege <skimo@kotnet.org> writes:
> > So, I think it would still be useful to have an optional additional
> > out-of-tree mechanism of getting usable URLs if the URLs in .gitmodules
> > or your local config don't work.
> 
> I thought that was already solved in my original two-level
> strawman and can naturally be extended to the three-level
> strawman.  What am I missing?

Maybe I'm missing something but you only seem to talk about .gitmodules
and local config there, while this would be a way of automatically getting
URLs that are either not available in .gitmodules or the local config
or are outdated or should be overridden.

skimo
