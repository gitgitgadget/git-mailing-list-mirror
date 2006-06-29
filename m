From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] move get_merge_bases() to core lib; use it in merge-recursive
Date: Thu, 29 Jun 2006 21:06:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606292050380.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com>
 <Pine.LNX.4.63.0606271830210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060627223249.GA8177@steel.home> <Pine.LNX.4.63.0606291517010.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0606290714v66a32976j531e2077ce6c1d77@mail.gmail.com>
 <Pine.LNX.4.63.0606291814200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmzbvrela.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 21:08:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw1r3-00079K-C3
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 21:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWF2THF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 15:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWF2THE
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 15:07:04 -0400
Received: from mail.gmx.de ([213.165.64.21]:61146 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932250AbWF2THB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 15:07:01 -0400
Received: (qmail invoked by alias); 29 Jun 2006 19:06:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp043) with SMTP; 29 Jun 2006 21:06:57 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzbvrela.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22893>

Hi Linus, Hi Junio

[this is a response to both of your responses; mail threads cannot yet be 
merged a la git ;-)]

On Thu, 29 Jun 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > My point being: it makes no sense to split off get_merge_bases() if nobody 
> > uses it except for git-merge-base.
> 
> I do not think that is a good reasoning.  If something is
> reusable (or you made it reusable) and you are planning to reuse
> it later, splitting it out without changing anything else to
> make sure the split is correct is a seemingly small but a very
> important step.

Okay. Convinced.

I tested my patch again, and like Alex said, a test fails. But I tested on 
top of Alex's latest merge-recursive patch, which has that nasty 
update-index bug, and that is the reason for the test to fail.

So, a few tests later, I am pretty sure that my patches do not break 
git-merge-base. I'll prepare another patch series which builds-in 
merge-base.

Ciao,
Dscho
