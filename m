From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git-submodule getting submodules from the parent repository
Date: Mon, 31 Mar 2008 08:22:59 +0200
Message-ID: <47F08343.20209@viscovery.net>
References: <32541b130803291535m317e84e6p321ebccd5dedaab3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 08:23:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgDQn-000603-S2
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 08:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752409AbYCaGXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 02:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbYCaGXD
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 02:23:03 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:34449 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbYCaGXC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 02:23:02 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JgDP8-0000jU-Pd; Mon, 31 Mar 2008 08:22:03 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DCC716B7; Mon, 31 Mar 2008 08:22:59 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <32541b130803291535m317e84e6p321ebccd5dedaab3@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78560>

Avery Pennarun schrieb:
> It's a  pain to check out / mirror / check in / push.  git-submodule
> doesn't even init automatically when you check out A, so you have to
> run it yourself.  The relative paths of A, B, and C on your mirror
> have to be the same as upstream.  You can't make a local mirror of A
> without mirroring B and C.  B and C start out with a disconnected
> HEAD, so if you check in, it goes nowhere, and then when you push,
> nothing happens, and if you're unlucky enough to pull someone else's
> update to A and then "git-submodule update", it forgets your changes
> entirely.  When you check in to C, you then have to check in to B, and
> then to A, all by hand; and when you git-pull, you'd better to C, then
> B, then A, or risk having A try to check out a revision from B that
> you haven't pulled, etc.

Would a "recurse" sub-command help your workflow?

http://thread.gmane.org/gmane.comp.version-control.git/69834

-- Hannes
