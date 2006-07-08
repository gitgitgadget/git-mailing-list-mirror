From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: comparing file contents in is_exact_match?
Date: Sat, 8 Jul 2006 04:50:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607080450100.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060706055729.GA12512@admingilde.org> <87k66p8jee.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 08 04:51:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fz2uP-0002DI-ST
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 04:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbWGHCvC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 22:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWGHCvB
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 22:51:01 -0400
Received: from mail.gmx.net ([213.165.64.21]:8170 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932492AbWGHCvA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 22:51:00 -0400
Received: (qmail invoked by alias); 08 Jul 2006 02:50:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 08 Jul 2006 04:50:59 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Florian Weimer <fw@deneb.enyo.de>
In-Reply-To: <87k66p8jee.fsf@mid.deneb.enyo.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23476>

Hi,

On Fri, 7 Jul 2006, Florian Weimer wrote:

> -               s->data = mmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
> +               s->data = mmap(NULL, s->size, PROT_READ, MAP_SHARED, fd, 0);

Be advised that this breaks setups with NO_MMAP, in particular most (all) 
cygwin setups I know of.

Hth,
Dscho
