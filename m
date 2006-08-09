From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Workaround for strange cmp bug
Date: Wed, 9 Aug 2006 13:12:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608091309590.1800@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0608091221550.1800@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v3bc65gk0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 09 13:12:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAlzM-0007zo-1Q
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 13:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030685AbWHILMg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 07:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030686AbWHILMg
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 07:12:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:49085 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030685AbWHILMf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Aug 2006 07:12:35 -0400
Received: (qmail invoked by alias); 09 Aug 2006 11:12:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 09 Aug 2006 13:12:34 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bc65gk0.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25115>

Hi,

On Wed, 9 Aug 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The cmp(1) (cmp (GNU diffutils) 2.8.7) distributed with openSUSE 10.1 has
> > a subtle "shortcoming":

Okay, I will try to fix the distribution. I only thought it was worthwhile 
spreading the workaround for other poor souls.

> It actually is very useful, in the chain of &&, to see that
> these steps in our tests output something when they shouldn't
> when the tests are run under -v; you may have noticed that the
> tests written by me have seemingly useless "echo happy" (which
> always returns true) and such, and they are there for a reason.

Well, I found myself stuck with too many of hard-to-debug cascades, where 
there is no "echo happy". I think that you are lost with most test 
scripts, if you do not use "bash -x".

Ciao,
Dscho
