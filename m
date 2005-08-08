From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Teach git push .git/branches shorthand
Date: Mon, 8 Aug 2005 12:25:59 +0200
Message-ID: <200508081225.59949.Josef.Weidendorfer@gmx.de>
References: <7viryhgdo5.fsf@assigned-by-dhcp.cox.net> <200508081141.23242.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.63.0508081154190.32406@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 08 12:27:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E24q6-00023f-Mv
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 12:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbVHHK0f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 06:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVHHK0f
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 06:26:35 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:18913 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1750811AbVHHK0f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 06:26:35 -0400
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <Pine.LNX.4.63.0508081154190.32406@wgmdd8.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Monday 08 August 2005 11:55, Johannes Schindelin wrote:
> Hi,
>
> On Mon, 8 Aug 2005, Josef Weidendorfer wrote:
> > IMHO, $GIT_DIR/branches/ is really confusing.
> > Hmmm... in $GIT_DIR/branches/ there are named references to remote
> > (named) references.
>
> Not necessarily. The following is perfectly valid:
>
> echo "rsync://rsync.kernel.org/pub/scm/git/git.git > .git/branches/x
>
> It does not contain a named reference, just a host.

Not really.
Your example defaults to the master head. It is perfectly valid (at least 
cogito usage), to have the reference appended as an anchor:

echo "rsync://rsync.kernel.org/pub/scm/git/git.git#pu" > .git/branches/pu

For lightweight remote tag, even a SHA1 as anchor should be possible.

Josef

> Ciao,
> Dscho
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
