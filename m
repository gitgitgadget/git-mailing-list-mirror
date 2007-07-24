From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/5] Internationalization of git-gui
Date: Tue, 24 Jul 2007 10:57:16 -0400
Message-ID: <20070724145716.GL32566@spearce.org>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com> <200707211433.29318.stimming@tuhh.de> <20070722073806.GW32566@spearce.org> <200707232123.01682.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 16:57:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDLpH-0005IH-TO
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 16:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbXGXO5X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 10:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752397AbXGXO5X
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 10:57:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41977 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbXGXO5W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 10:57:22 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IDLp2-0006Tb-Jq; Tue, 24 Jul 2007 10:57:12 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6E82520FBAE; Tue, 24 Jul 2007 10:57:16 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200707232123.01682.stimming@tuhh.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53605>

Christian Stimming <stimming@tuhh.de> wrote:
> Am Sonntag, 22. Juli 2007 09:38 schrieb Shawn O. Pearce:
> > > +## Internationalization (i18n) through msgcat and gettext. See
> > > +## http://www.gnu.org/software/gettext/manual/html_node/Tcl.html
> > > +package require msgcat
> > > +::msgcat::mcload [file join $oguilib msgs]
> > > +namespace import ::msgcat::mc
> >
> > Thanks.  We'll probably also want to modify the lib/class.tcl to
> > import ::msgcat::mc ...
> 
> As I was adding the markup in all the other files, I didn't have to add 
> another import statement anywhere else. Seems like the global mc procedure 
> works just fine.
> 
> In other words, if you think the mc procedure should be imported in another 
> place as well, please do so because I don't know your future plans with class 
> structure (and I also don't need to know for adding the i18n support right 
> now).

Hmm.  Actually that makes sense.  We probably don't need to make
any changes, other than to make sure we don't override the "mc"
definition in any of the other UI namespaces, since it is currently
being inherited from :: (the global namespace).

Thanks.

-- 
Shawn.
