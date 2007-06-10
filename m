From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/7] Softrefs: Add softrefs header file with API documentation
Date: Sun, 10 Jun 2007 16:27:41 +0200
Organization: At home
Message-ID: <f4h1ot$83m$1@sea.gmane.org>
References: <200706040251.05286.johan@herland.net> <200706092019.13185.johan@herland.net> <200706092021.43314.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 10 16:28:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxOOs-00016z-4g
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 16:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755554AbXFJO2N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 10:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755294AbXFJO2N
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 10:28:13 -0400
Received: from main.gmane.org ([80.91.229.2]:59194 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754636AbXFJO2M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 10:28:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HxOOa-000580-4B
	for git@vger.kernel.org; Sun, 10 Jun 2007 16:27:56 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 16:27:56 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 16:27:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49741>

Johan Herland wrote:

> + * When softrefs are created (by calling add_softref()/add_softrefs()), they
> + * are appended to .git/softrefs.unsorted. When .git/softrefs.unsorted reach a
> + * certain number of entries (determined by MAX_UNSORTED_ENTRIES), all the
> + * entries in .git/softrefs.unsorted are merged into .git/softrefs.sorted.

Perhaps git-gc should also sort softrefs (if it doesn't do it yet)?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
