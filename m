From: Mark Blakeney <markb@berlios.de>
Subject: Re: git rebase stops on empty commits
Date: Wed, 22 Jul 2009 23:01:32 +0000 (UTC)
Message-ID: <loom.20090722T224408-68@post.gmane.org>
References: <33e2b2760907220022rbad30d7x255bcb63c5b8cc2f@mail.gmail.com> <loom.20090722T073645-17@post.gmane.org> <alpine.DEB.2.00.0907220907550.9220@ds9.cixit.se> <loom.20090722T120617-839@post.gmane.org> <20090723070812.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 23 01:02:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTkp0-0008Kx-Kt
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 01:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672AbZGVXBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 19:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754485AbZGVXBt
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 19:01:49 -0400
Received: from main.gmane.org ([80.91.229.2]:55203 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557AbZGVXBt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 19:01:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MTkoh-0008Kv-ME
	for git@vger.kernel.org; Wed, 22 Jul 2009 23:01:43 +0000
Received: from 124-171-150-213.dyn.iinet.net.au ([124.171.150.213])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 23:01:43 +0000
Received: from markb by 124-171-150-213.dyn.iinet.net.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 23:01:43 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 124.171.150.213 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.12) Gecko/2009070811 Ubuntu/9.04 (jaunty) Firefox/3.0.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123811>

Because these particular original commits were real commits ported from our
previous archaic system which for technical reasons have lost the actual file
changes (although they are trivial for each of these particular cases). But all
our commit comments are very verbose and valuable, specifically in these cases,
so it would be a shame to lose them from the linear change history.

Anyway, the question of why anybody would want empty commits is beside the main
point. The fact is that git provides this option so my bug sugestion here is
that git rebase does not cater for this existing git commit option very well. My
contention is that "git commit" supports --allow-empty so "git rebase" should as
well.
