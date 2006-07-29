From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Licensing and the library version of git
Date: Fri, 28 Jul 2006 23:56:32 -0400
Message-ID: <20060729035632.GC28128@spearce.org>
References: <9e4733910607270554p5622ee20ida8c264cf3122500@mail.gmail.com> <20060727195614.7EDAE353B04@atlas.denx.de> <20060728050444.GA30783@spearce.org> <Pine.LNX.4.63.0607281041420.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wolfgang Denk <wd@denx.de>, Jon Smirl <jonsmirl@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 29 05:57:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6fwh-0002EO-Vk
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 05:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161428AbWG2D45 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 23:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161433AbWG2D45
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 23:56:57 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43482 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1161428AbWG2D44 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jul 2006 23:56:56 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G6fwA-0003e3-5D; Fri, 28 Jul 2006 23:56:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5CAA720E433; Fri, 28 Jul 2006 23:56:33 -0400 (EDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607281041420.29667@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24412>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Fri, 28 Jul 2006, Shawn Pearce wrote:
> 
> > [...] as the GPL is incompatible with the Sun JRE runtime lirbary.
> 
> This is not true. You can legally write and run GPLed software on the JRE 
> runtime library.
> 
> BTW I found an Eclipse plugin which is GPLed:
> 
> http://www.eclipseplugincentral.com/Web_Links-index-req-viewlink-cid-651.html

Thanks.  I did a little research on it myself after reading your
email. I turned up the following two pages from the FSF:

  http://www.gnu.org/licenses/gpl-faq.html#InterpreterIncompat
  http://www.gnu.org/licenses/lgpl-java.html

Both suggest that I can license everything under the GPL but provide
exclusions to allow users to run the code against its dependencies
which aren't GPL'd:

  - the end-user may 'link' the code against any Java runtime library
    of their choice;

  - the end-user may 'link' the code against any Eclipse platform
    or derivative of their choice;

So given that I'm seriously considering changing the license to
GPLv2 for the next version.

-- 
Shawn.
