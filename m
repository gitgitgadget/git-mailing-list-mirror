From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] diff --stat: allow custom diffstat output width.
Date: Fri, 29 Sep 2006 00:26:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609290025030.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vr6xyjal0.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0609281349110.3952@g5.osdl.org> <20060928222402.GC3469@stusta.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 00:26:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT4L8-0005MK-0K
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 00:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161337AbWI1W0n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 18:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161338AbWI1W0n
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 18:26:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:13448 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161337AbWI1W0m (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Sep 2006 18:26:42 -0400
Received: (qmail invoked by alias); 28 Sep 2006 22:26:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 29 Sep 2006 00:26:41 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Adrian Bunk <bunk@stusta.de>
In-Reply-To: <20060928222402.GC3469@stusta.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28059>

Hi,

On Fri, 29 Sep 2006, Adrian Bunk wrote:

> IOW, change --stat-width=72 to -w72, or at least allow it alternatively?

With diff options, -w is identical to --ignore-all-space. (Yes, I know, it 
is not in Documentation/diff-options.txt, but it is in "man diff".)

Ciao,
Dscho
