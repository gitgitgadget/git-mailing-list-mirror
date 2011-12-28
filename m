From: Reza Mostafid <m.r.mostafid@gmail.com>
Subject: Re: GIT and SSH
Date: Wed, 28 Dec 2011 11:01:58 +0000 (UTC)
Message-ID: <loom.20111228T115814-404@post.gmane.org>
References: <loom.20111228T091942-66@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 28 12:02:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfrHQ-0006Bh-OX
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 12:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569Ab1L1LCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Dec 2011 06:02:24 -0500
Received: from lo.gmane.org ([80.91.229.12]:49500 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557Ab1L1LCX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2011 06:02:23 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RfrGu-0003iu-5T
	for git@vger.kernel.org; Wed, 28 Dec 2011 12:02:12 +0100
Received: from 213.207.203.115 ([213.207.203.115])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Dec 2011 12:02:12 +0100
Received: from m.r.mostafid by 213.207.203.115 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Dec 2011 12:02:12 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 213.207.203.115 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.10) Gecko/20100915 Ubuntu/9.04 (jaunty) Firefox/3.6.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187749>

I forgot to mention, I am an embedded developer located in Iran.

The filtering I am talking about is by the government. All ISP's get their
bandwith from centrally allocated trunks. This allows control.

I know that ssh packets get dropped for extended periods frequently.
We have an Ubuntu virtual server outside of Iran which we use as a proxy and
connect to it via 'ssh' sox provxy ( -D 8090 ).

Many times some sort of script or intelligence is operation which severely
throttles the connection as soon as the data rate exceeds certain "benign" 
levels. All this has been confirmed by the network `gurus` and admin people I
work with. This is the best we can tell from what we observe.

As mentioned when we execute the simple GIT clone command from our VPS 
( located outside Iran ) the command works flawlessly.

What I would be interested in is to somehow make git avoid using transport
over ssh. The government censors are interested only in blocking people
accessing illicit sites via S.O.X-5 or VPN. 

To them anything over SSH is suspicious. If we could somehow update using a
plain transport method, they couldn't care less about source code being sent to 
us.

Regards

Reza
