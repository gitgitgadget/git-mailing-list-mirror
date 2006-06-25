From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: On boolean configuration variables...
Date: Sun, 25 Jun 2006 16:00:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606251553110.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vy7vmviul.fsf@assigned-by-dhcp.cox.net>  <e7m3b6$eoa$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 16:00:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuVAF-0006f0-Kk
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 16:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWFYOAh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 10:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWFYOAg
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 10:00:36 -0400
Received: from mail.gmx.de ([213.165.64.21]:7345 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932269AbWFYOAg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 10:00:36 -0400
Received: (qmail invoked by alias); 25 Jun 2006 14:00:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 25 Jun 2006 16:00:34 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Anand Kumria <wildfire@progsoc.org>
In-Reply-To: <e7m3b6$eoa$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22626>

Hi,

On Sun, 25 Jun 2006, Anand Kumria wrote:

> Allowing 'yes' and 'no' to equal 'true' and 'false' respectively sounds
> pretty sane and user-friendly.
> 
> Why wouldn't you want to do that?

'Cause you'd have to add "maybe", too ;-)

Seriously, there is a subtle side to booleans, which is the reason that 
they typically take on only "false" and "true": Consider the question "Is 
the box not red?". If the answer is "yes", I do not know if "yes, the box 
is red" or "yes, the box is not red".

"true" and "false" are less ambiguous.

Ciao,
Dscho
