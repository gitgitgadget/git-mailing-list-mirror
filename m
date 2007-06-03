From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add git-filter-branch
Date: Sun, 03 Jun 2007 02:46:15 +0200
Organization: At home
Message-ID: <f3t2mm$f0$1@sea.gmane.org>
References: <Pine.LNX.4.64.0706030129110.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 02:41:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hue9x-0002pp-5k
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 02:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760064AbXFCAlW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 20:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762995AbXFCAlW
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 20:41:22 -0400
Received: from main.gmane.org ([80.91.229.2]:50920 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760064AbXFCAlV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 20:41:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hue9W-0001Io-Ra
	for git@vger.kernel.org; Sun, 03 Jun 2007 02:41:03 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Jun 2007 02:41:02 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Jun 2007 02:41:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48965>

Johannes Schindelin wrote:

> This script is derived from Pasky's cg-admin-rewritehist.
> 
> In fact, it _is_ the same script, minimally adapted to work without cogito.
> It _should_ be able to perform the same tasks, even if only relying on
> core-git programs.
> 
> All the work is Pasky's, just the adaption is mine.

I was thinking about rewriting cg-adin-rewritehist as git-rewritehist
using Perl (IIRC it needs bash, not only POSIX shell), and make it
use git-fast-import.

But that was in planning (read: it would be nice...) phase...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
