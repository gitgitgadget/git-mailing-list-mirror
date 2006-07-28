From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach git-apply about '-R'
Date: Fri, 28 Jul 2006 17:50:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607281748390.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607261940090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <200607262039.25155.Josef.Weidendorfer@gmx.de> <20060728013038.GH13776@pasky.or.cz>
 <Pine.LNX.4.63.0607281213250.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v3bcln3m5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 28 17:51:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6Ubk-0000W4-3Q
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 17:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbWG1Pud (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 11:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbWG1Pud
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 11:50:33 -0400
Received: from mail.gmx.net ([213.165.64.21]:24241 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751999AbWG1Puc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 11:50:32 -0400
Received: (qmail invoked by alias); 28 Jul 2006 15:50:27 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 28 Jul 2006 17:50:27 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bcln3m5.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24395>

Hi,

On Fri, 28 Jul 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> A quick comment without looking much at the code.  Do you sanely
> bail out when asked to reverse-apply a binary patch?

Nope. I swap old_sha1_prefix and new_sha1_prefix in that case, I hoped 
that is enough?

> Also what was the reason to change an existing test vector in
> 4102?  That does not look like related to -R flag.

I changed "copy" to "rename", so that I could reuse that patch to test -R, 
too. Note that in the end, the original test vector is written, and 
tested.

Ciao,
Dscho
