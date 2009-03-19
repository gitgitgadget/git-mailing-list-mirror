From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Gnome chose Git
Date: Thu, 19 Mar 2009 14:44:32 -0700
Message-ID: <20090319214432.GV23521@spearce.org>
References: <877i2lbvt7.fsf@iki.fi> <49C249B9.7010001@drmicha.warpmail.net> <1cd1989b0903190643p19a40718yc4fd2730aab0a9a0@mail.gmail.com> <49C24D9B.1060301@drmicha.warpmail.net> <1cd1989b0903190701uac4602dl1d2c3cace45a9938@mail.gmail.com> <20090319151610.GO23521@spearce.org> <1cd1989b0903190850p1a08991y754904e7799c7879@mail.gmail.com> <20090319201405.GD17028@coredump.intra.peff.net> <9b18b3110903191440w20ca9801pfb218cc4b10ea769@mail.gmail.com> <20090319214317.GU23521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 22:46:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkQ3w-0004rG-53
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 22:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757645AbZCSVoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 17:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757504AbZCSVoe
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 17:44:34 -0400
Received: from george.spearce.org ([209.20.77.23]:54833 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757263AbZCSVod (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 17:44:33 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1FF9238221; Thu, 19 Mar 2009 21:44:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090319214317.GU23521@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113836>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> demerphq <demerphq@gmail.com> wrote:
> > Outside of parsing the reflog directly, (which feels wrong and dirty
> > to me), how does one find out the times that a reflog entry was
> > created?
> > 
> > The closest thing i could find was git log -g, but that shows the time
> 
>   git reflog -g branch@{now}

Arrgh, I of course actually meant

    git log -g branch@{now}
 
> the @{now} suffix is the magic to make it show the time.

-- 
Shawn.
