From: Russ Dill <Russ.Dill@gmail.com>
Subject: Re: People unaware of the importance of "git gc"?
Date: Thu, 6 Sep 2007 02:44:00 +0000 (UTC)
Message-ID: <loom.20070906T044017-727@post.gmane.org>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix> <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix> <alpine.LFD.0.9999.0709051438460.21186@xanadu.home> <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 04:44:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT7M6-00022v-FJ
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 04:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757438AbXIFCo0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 22:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757346AbXIFCoZ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 22:44:25 -0400
Received: from main.gmane.org ([80.91.229.2]:43959 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757349AbXIFCoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 22:44:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IT7Ls-0005E9-BZ
	for git@vger.kernel.org; Thu, 06 Sep 2007 04:44:17 +0200
Received: from russ-laptop.mobile.asu.edu ([149.169.205.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 06 Sep 2007 04:44:16 +0200
Received: from Russ.Dill by russ-laptop.mobile.asu.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 06 Sep 2007 04:44:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 149.169.205.153 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.6) Gecko/20070827 Galeon/2.0.2 (Ubuntu package 2.0.2-4ubuntu1) (gutsy) Firefox/2.0.0.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57805>


> Ok, how about doing something like this?
> 

git add? merge? rebase? No, I have a sneakier place to invoke gc.

Whenever $EDITOR gets invoked. Heck, whenever git is waiting for any user input,
do some gc in the background, it'd just have to be incremental so that we could
pick up where we left off.

Similarly, you could mix it in with git pull/push so that while we are waiting
on the network, we can do some packing.

Course, this wouldn't work for all repositories.
