From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: Re: gitk - ewww
Date: Sun, 4 Dec 2005 18:12:06 +0100
Message-ID: <20051204171206.GA8819@puritan.petwork>
References: <6CC092B0-101F-4D98-9761-B4E24A7CA35A@hawaga.org.uk> <Pine.LNX.4.64.0512032040240.3099@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Dec 04 18:14:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EixPo-0004Vu-2h
	for gcvg-git@gmane.org; Sun, 04 Dec 2005 18:12:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbVLDRMO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Dec 2005 12:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbVLDRMO
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Dec 2005 12:12:14 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:39920 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932303AbVLDRMM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Dec 2005 12:12:12 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep02.bredband.com with ESMTP
          id <20051204171206.ZJMJ17186.mxfep02.bredband.com@ironport.bredband.com>
          for <git@vger.kernel.org>; Sun, 4 Dec 2005 18:12:06 +0100
Received: from c-fa2b70d5.018-10-67626713.cust.bredbandsbolaget.se (HELO puritan.petwork) ([213.112.43.250])
  by ironport.bredband.com with ESMTP; 04 Dec 2005 18:12:35 +0100
X-BrightmailFiltered: true
X-IronPort-AV: i="3.99,212,1131318000"; 
   d="scan'208"; a="15353062:sNHT30191238"
Received: by puritan.petwork (Postfix, from userid 1000)
	id F19AAADFE5; Sun,  4 Dec 2005 18:12:06 +0100 (CET)
To: Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512032040240.3099@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13187>

Linus Torvalds wrote:

> On Sun, 4 Dec 2005, Ben Clifford wrote:

> > Screen shot is at:
> > http://www/hawaga.org.uk/ben/tech/gitk-eww-1.png

> What makes _me_ go "eww" in that screenshot is that tcl/tk doesn't do
> anti-aliased fonts, but maybe that's just me, and that's apparently
> 8.5 has that fixed (at a horrible performance impact, I'm sure, but
> hey, one look at your screenshot and I'm saying "bring it on").

Just use a slightly larger font and it should be fine.  The lower-right
field, whatever that lists (changed files?) - I have never used gitk,
uses anti-aliasing, and the only problem I see is that the
commit-message listing uses a font that is way too small (or is badly
designed).  The top pane is easily readable, although it could use a
slightly larger point-size.

Anti-aliasing is only a hack for displaying text on a screen.  It's not
a substitute for choosing your fonts and point sizes with care.  A
bitmapped font designed for small point-sizes will always look more
crisp than a generic TTF at small point-sizes.

        nikolai

-- 
Nikolai Weibull: now available free of charge at http://bitwi.se/!
Born in Chicago, IL USA; currently residing in Gothenburg, Sweden.
main(){printf(&linux["\021%six\012\0"],(linux)["have"]+"fun"-97);}
