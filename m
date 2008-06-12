From: Eric Raible <raible@gmail.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Thu, 12 Jun 2008 04:32:40 +0000 (UTC)
Message-ID: <loom.20080612T042942-698@post.gmane.org>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 06:34:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6eVc-0006gS-9D
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 06:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbYFLEdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 00:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbYFLEdA
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 00:33:00 -0400
Received: from main.gmane.org ([80.91.229.2]:37309 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045AbYFLEc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 00:32:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K6eUV-0007Qp-A8
	for git@vger.kernel.org; Thu, 12 Jun 2008 04:32:51 +0000
Received: from adsl-67-121-115-243.dsl.pltn13.pacbell.net ([67.121.115.243])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Jun 2008 04:32:51 +0000
Received: from raible by adsl-67-121-115-243.dsl.pltn13.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Jun 2008 04:32:51 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 67.121.115.243 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.14) Gecko/20080404 Firefox/2.0.0.14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84697>

Nicolas Pitre <nico <at> cam.org> writes:

> As you say, branches are there just for that: keeping changes for 
> months.  Stashes are not meant to be used like that nor should we 
> encourage it.

This unfortunately goes against the recommended usage in John Wiegley's
otherwise excellent "Git From the Bottom Up".  I've contacted him separately to
make him aware of the collective wisdom of not relying on stashes for long-term
storage.

- Eric
