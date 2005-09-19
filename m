From: Patrick Mauritz <oxygene@studentenbude.ath.cx>
Subject: Re: [PATCHES] CURLDIR support, more usable cmd-rename.sh
Date: Mon, 19 Sep 2005 19:40:42 +0200
Message-ID: <1127151642.781.15.camel@divert>
References: <1127128475.781.6.camel@divert>
	 <20050919133731.GB2903@pasky.or.cz> <1127139079.781.9.camel@divert>
	 <7vhdchqan8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 19:42:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHPcO-0003Wk-9C
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 19:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbVISRju (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 13:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbVISRju
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 13:39:50 -0400
Received: from khepri.openbios.org ([80.190.231.112]:62085 "EHLO
	khepri.openbios.org") by vger.kernel.org with ESMTP id S932518AbVISRjt
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 13:39:49 -0400
Received: from dsl-082-083-077-252.arcor-ip.net ([82.83.77.252] helo=t-stueck.streichelzoo)
	by khepri.openbios.org with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.50)
	id 1EHPcJ-0007Yc-Oi; Mon, 19 Sep 2005 19:39:48 +0200
Received: from 192.168.1.201 (divert.studentenbude.ath.cx [192.168.1.201])
	by t-stueck.streichelzoo (8.13.4+Sun/8.13.3) with ESMTP id j8JHdfnR007507;
	Mon, 19 Sep 2005 19:39:46 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhdchqan8.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6.316 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0 (t-stueck.streichelzoo [192.168.1.200]); Mon, 19 Sep 2005 19:39:46 +0200 (CEST)
X-Spam-Score: -1.3 (-)
X-Duff: Orig. Duff, Duff Lite, Duff Dry, Duff Dark,
	Raspberry Duff, Lady Duff, Red Duff, Tartar Control Duff
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8892>

On Mon, 2005-09-19 at 18:34, Junio C Hamano wrote:
> Why not a patch from either git or cogito or stgit ;-)?
because my only use for git is with monotone's git import.

> Not relevant to the current topic as far as I can tell (unless
> your non-standard curl include files trip under -Wall).
the only issue with this is that sunpro's cc doesn't like -Wall

> Installations without ld.so.conf need -R, but
> is it safe to always force -R like this?
the only case that comes to mind is where you want to link git against
a library which is at a different location now than it is later, eg. in
conjunction with DESTDIR or similar means.
as long as git doesn't build any shared libraries by itself and links to
them, this shouldn't be an issue.


patrick mauritz
