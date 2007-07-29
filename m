From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui.git: Wording suggestions, 2nd try
Date: Sun, 29 Jul 2007 03:08:20 -0400
Message-ID: <20070729070820.GK20052@spearce.org>
References: <20070726111902.xqkxcdlsbo8w4c8k@webmail.tu-harburg.de> <861wevqz7d.fsf@lola.quinscape.zz> <200707282217.10772.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>,
	Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Sun Jul 29 09:08:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF2tJ-00080V-LK
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 09:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757436AbXG2HI2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 03:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757307AbXG2HI2
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 03:08:28 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33330 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756738AbXG2HI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 03:08:27 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IF2t3-0002qK-GE; Sun, 29 Jul 2007 03:08:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2762E20FBAE; Sun, 29 Jul 2007 03:08:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200707282217.10772.stimming@tuhh.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54085>

Christian Stimming <stimming@tuhh.de> wrote:
> Unify wording to say "to stage" instead of "to add" always.
> 
> Also, the warning message when clicking "Reset" is adapted to
> the wording "Reset" rather than a confusion "Cancel commit?".
> 
> Signed-off-by: Christian Stimming <stimming@tuhh.de>
> ---
> This time, this patch is actually based on git-gui.git's master. If
> you want to, you can directly apply this regardless of i18n work that
> was deferred until later.  The last hunk in lib/merge.tcl looks a
> bit confusing; in preparation of i18n work, the previous message
> that inserted a single word into the long english sentence was
> already replaced by the i18n'able form of two completely different
> messages. But nevertheless the main point is that when clicking
> "Reset", the upcoming question should use the wording "reset",
> which it will do after this patch.

Thanks, I'm including this in 0.8.0 as I think it makes things
a lot clearer, at least for English speakers.  ;-)

As soon as git 1.5.3 ships I'll start work on 0.9.0, and I'm
looking to bringing the i18n work in as the first series of
changes for the 0.9.x series...
 
-- 
Shawn.
