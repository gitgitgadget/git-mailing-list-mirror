From: Petr Baudis <pasky@ucw.cz>
Subject: Re: git stash deletes/drops changes of
Date: Fri, 24 May 2013 13:03:22 +0200
Message-ID: <20130524110322.GP12252@machine.or.cz>
References: <loom.20130523T185301-635@post.gmane.org>
 <87sj1d5ous.fsf@linux-k42r.v.cablecom.net>
 <7vd2shcnx7.fsf@alter.siamese.dyndns.org>
 <87obc15mq5.fsf@linux-k42r.v.cablecom.net>
 <20130523235711.GJ12252@machine.or.cz>
 <20130524082253.GY27005@serenity.lan>
 <20130524094006.GM12252@machine.or.cz>
 <20130524100612.GA27005@serenity.lan>
 <20130524101416.GO12252@machine.or.cz>
 <20130524104018.GB27005@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jim Greenleaf <james.a.greenleaf@gmail.com>,
	git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri May 24 13:04:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufpmz-0007bB-I2
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 13:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973Ab3EXLD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 07:03:27 -0400
Received: from pasky.or.cz ([84.242.80.195]:49514 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951Ab3EXLD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 07:03:26 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 61D6F17000B6; Fri, 24 May 2013 13:03:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130524104018.GB27005@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225346>

On Fri, May 24, 2013 at 11:40:18AM +0100, John Keeping wrote:
> So that it continues to Just Work for people using buildroot but you can
> create Makefile.config to override those defaults.

  Indeed, that doesn't cover some corner cases of (c), but that's not a
big deal in practice I guess.

  My point still stands - this is extra hassle, done just for the sake
of the tool; I think the tool should not get in the way. Moreover, it's
not the default solution for your typical original author and therefore
you will still often find yourself in a situation where you have to deal
with a setup that's broken already.

-- 
				Petr "Pasky" Baudis
	For every complex problem there is an answer that is clear,
	simple, and wrong.  -- H. L. Mencken
