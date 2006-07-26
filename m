From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Extend testing git-mv for renaming of subdirectories
Date: Wed, 26 Jul 2006 18:02:33 +0200
Message-ID: <200607261802.33757.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.63.0607260348130.29667@wbgn013.biozentrum.uni-wuerzburg.de> <200607261544.08435.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.63.0607261721460.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Jul 26 18:44:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5mTn-0002BH-Vu
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 18:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbWGZQnB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 12:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWGZQnB
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 12:43:01 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:26858 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1751705AbWGZQnA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 12:43:00 -0400
Received: from dhcp-3s-48.lrr.in.tum.de (dhcp-3s-48.lrr.in.tum.de [131.159.35.48])
	by mail.in.tum.de (Postfix) with ESMTP id 764D22219;
	Wed, 26 Jul 2006 18:02:37 +0200 (MEST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0607261721460.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24224>

On Wednesday 26 July 2006 17:22, Johannes Schindelin wrote:
> > Hmm... Renaming full subtrees worked since the old git-rename days.
> > I just checked it, and it works fine.
> 
> Thanks.
> 
> And thanks again: since there is a test now, I'll have to implement that 
> feature, too, I guess ;-)

Sorry about that, but that was the reason for this patch ;-)
I think it would be too bad for users to have this as regression.

When I first looked at the git-rename script, it wasn't clear to me
that moving dirs actually works. The thing is that PERL's "rename"
can move subdirectories. And on the git side, it does a grep with the
dir name against the list of tracked files, so we catch all tracked
files in the subdirectory.

Josef
