From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Teach git push .git/branches shorthand
Date: Mon, 8 Aug 2005 11:41:22 +0200
Message-ID: <200508081141.23242.Josef.Weidendorfer@gmx.de>
References: <7viryhgdo5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0508081106580.26210@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 08 11:43:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2492-00068i-AP
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 11:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbVHHJl7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 05:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbVHHJl7
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 05:41:59 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:53716 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1750771AbVHHJl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 05:41:59 -0400
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <Pine.LNX.4.63.0508081106580.26210@wgmdd8.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Monday 08 August 2005 11:10, Johannes Schindelin wrote:
> Hi,
>
> On Sun, 7 Aug 2005, Junio C Hamano wrote:
> > I hear a lot of people mention $GIT_DIR/branches/ is confusing.
> > Maybe we should rename it to $GIT_DIR/remote/ directory?
>
> I'd prefer $GIT_DIR/remotes/.

IMHO, $GIT_DIR/branches/ is really confusing.
Hmmm... in $GIT_DIR/branches/ there are named references to remote (named) 
references.
Perhaps we should call it "remoterefs/" instead?

Josef
