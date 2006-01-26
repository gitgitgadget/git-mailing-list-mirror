From: Junio C Hamano <junkio@cox.net>
Subject: Re: What is "-u" supposed to mean in git-fetch?
Date: Thu, 26 Jan 2006 03:50:33 -0800
Message-ID: <7voe1zfbsm.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0601261148510.32499@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Jan 26 12:51:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F25em-0006cc-SS
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 12:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWAZLuh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jan 2006 06:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWAZLuh
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 06:50:37 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:27835 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932135AbWAZLug (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2006 06:50:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060126114747.KONK17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 Jan 2006 06:47:47 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0601261148510.32499@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 26 Jan 2006 11:57:27 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15161>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 96b086d6 introduced "-u" to mean "--upload-pack" taking one argument. But 
> long ago, b10ac50f1 from Aug 10 already introduced "-u" to mean 
> "--update-head-ok" (without argument). This broke my scripts badly.
>
> So, what is it?

Ah, I was not careful enough when reviewing.

You are right.  The newcomer --upload-pack should drop its
abbreviation shorter than "--upl".

> Also, in the course of researching this, I tried
>
> 	git-whatchanged git-fetch-script

As in Linus' message, "git whatchanged -- git-fetch-script" is
supposed to be the kosher way now, but it does *not* work.

I started to suspect that flag/option parsing with rev-parse has
outlived its usefulness, at least in whatchanged.

It is getting late, so won't have updates from me tonight.
Sorry.
