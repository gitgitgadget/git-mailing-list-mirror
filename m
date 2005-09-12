From: Peter Eriksen <s022018@student.dtu.dk>
Subject: Re: [PATCH] Redirect cd output to /dev/null, was: git-clone seems dead
Date: 12 Sep 2005 11:22:09 +0200
Message-ID: <vhpvf167i9q.fsf@erlang.gbar.dtu.dk>
References: <vhp64t7v5ff.fsf@ebar091.ebar.dtu.dk> <7vd5nfs9y0.fsf@assigned-by-dhcp.cox.net> <20050911220421.GA14593@athame.dynamicro.on.ca> <20050911230136.GA15224@athame.dynamicro.on.ca> <7vwtlnm4zx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 12 11:28:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEkZv-0008Cn-LP
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 11:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbVILJ0R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 05:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVILJ0R
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 05:26:17 -0400
Received: from main.gmane.org ([80.91.229.2]:28374 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751252AbVILJ0Q (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 05:26:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EEkXw-0007Bw-1L
	for git@vger.kernel.org; Mon, 12 Sep 2005 11:24:16 +0200
Received: from erlang.gbar.dtu.dk ([192.38.95.25])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Sep 2005 11:24:16 +0200
Received: from s022018 by erlang.gbar.dtu.dk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Sep 2005 11:24:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: erlang.gbar.dtu.dk
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8373>

Junio C Hamano <junkio@cox.net> writes:
...
> I do not have any problem with people who have CDPATH defined as
> a plain shell variable (not exported) in their interactive
> shells, but I really do not see a point of having CDPATH as an
> environment variable, exported to be honored by any unsuspecting
> shell scripts.

Point taken.  I fixed my environment by making CDPATH non-exporting,
and now git-clone seems to work.  Thanks Greg and Junio!

Regards,

Peter
