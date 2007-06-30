From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-merge-ff: fast-forward only merge
Date: Sat, 30 Jun 2007 20:32:31 +0200
Message-ID: <20070630183231.GA15774@moooo.ath.cx>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz> <11831937823756-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sat Jun 30 20:32:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4hkM-0008NP-DO
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 20:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977AbXF3Sce (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 14:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753928AbXF3Sce
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 14:32:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:56477 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753796AbXF3Sce (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 14:32:34 -0400
Received: (qmail invoked by alias); 30 Jun 2007 18:32:32 -0000
Received: from pD9EB8ACF.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.138.207]
  by mail.gmx.net (mp053) with SMTP; 30 Jun 2007 20:32:32 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1+9hbdxn4S9XRSTM4FeAvA13HlX/2KbQWuywaBCTt
	VcR3rN8N0pSrp9
Content-Disposition: inline
In-Reply-To: <11831937823756-git-send-email-sam.vilain@catalyst.net.nz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51240>

Sam Vilain <sam.vilain@catalyst.net.nz> wrote:
> This is primarily so that there is an easy switch to 'git-pull' to
> be sure to fast forward only.

Is this still broken or am I just doing something totally wrong?

    % git reset --hard origin/master~15
    HEAD is now at e1341ab... Merge branch 'master' of git://git.kernel.org/pub/scm/gitk/gitk into pm/gitk
    % git merge -s ff origin/master
    Automatic merge failed; fix conflicts and then commit the result.
    [1]    19368 exit 1     git merge -s ff origin/master
    % git merge origin/master   
    Updating e1341ab..7c85173              
    Fast forward
    [..]
     23 files changed, 236 insertions(+), 79 deletions(-)
