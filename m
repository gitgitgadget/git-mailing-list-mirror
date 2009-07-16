From: Eric Raible <raible@gmail.com>
Subject: Re: Correct way of making existing remote repository "bare"
Date: Thu, 16 Jul 2009 07:59:01 +0000 (UTC)
Message-ID: <loom.20090716T074910-226@post.gmane.org>
References: <h3khis$3tq$1@ger.gmane.org> <alpine.DEB.1.00.0907151607050.4410@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 09:59:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRLsH-0007uQ-AS
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 09:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049AbZGPH7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 03:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753061AbZGPH7S
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 03:59:18 -0400
Received: from main.gmane.org ([80.91.229.2]:58687 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752948AbZGPH7S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 03:59:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MRLs3-0001lu-OH
	for git@vger.kernel.org; Thu, 16 Jul 2009 07:59:16 +0000
Received: from adsl-63-197-71-184.dsl.snfc21.pacbell.net ([63.197.71.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 07:59:15 +0000
Received: from raible by adsl-63-197-71-184.dsl.snfc21.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 07:59:15 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 63.197.71.184 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/530.5 (KHTML, like Gecko) Chrome/2.0.172.33 Safari/530.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123380>

Johannes Schindelin <Johannes.Schindelin <at> gmx.de> writes:

> That's the easiest.  However, I regularly avoid those steps by doing
> 
> 	mv bla/.git bla.git
> 	git --git-dir=bla.git config core.bare true
> 	rm -rf bla
> 

Is it simpler and more complete to do this?

	git config core.bare true
	git config core.logAllRefUpdates
	mv bla/.git bla.git
	rm -rf bla
