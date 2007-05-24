From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 19:38:17 +0200
Message-ID: <20070524173817.GS942MdfPADPa@greensroom.kotnet.org>
References: <20070524073652.GH942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241039200.4648@racer.site>
 <20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241201270.4648@racer.site>
 <20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241230410.4648@racer.site>
 <20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241315290.4648@racer.site>
 <8c5c35580705240541j7f632fc4lbd308c9386c2bde6@mail.gmail.com>
 <7vabvuywix.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Lars Hjemli <hjemli@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 19:38:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrHGd-0003S4-56
	for gcvg-git@gmane.org; Thu, 24 May 2007 19:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbXEXRiW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 13:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbXEXRiW
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 13:38:22 -0400
Received: from smtp15.wxs.nl ([195.121.247.6]:38533 "EHLO smtp15.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774AbXEXRiV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 13:38:21 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp15.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JIK008WL3NVN1@smtp15.wxs.nl> for git@vger.kernel.org; Thu,
 24 May 2007 19:38:20 +0200 (CEST)
Received: (qmail 6247 invoked by uid 500); Thu, 24 May 2007 17:38:17 +0000
In-reply-to: <7vabvuywix.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48280>

On Thu, May 24, 2007 at 10:13:58AM -0700, Junio C Hamano wrote:
> When you are bootstrapping, you will start by a fetch/clone of
> the superproject.  Why can't that tree contain necessary
> information that is relevant to the superproject in question?

Because git is a distributed SCM.

> Isn't the information about which subprojects are used by the
> superproject specific to each superproject, and also specific to
> each version of the superproject (as a superproject can start
> using more projects than it did before)?

Perhaps for some information, but not for the "preferred" URL
to get the subprojects from.  That may change in time (independently
of any changes in the superproject itself) and they
will be different for different copies of the same superproject.

skimo
