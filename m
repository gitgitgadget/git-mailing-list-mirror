From: John Keeping <john@keeping.me.uk>
Subject: Re: git stash deletes/drops changes of
Date: Fri, 24 May 2013 13:42:42 +0100
Message-ID: <20130524124242.GD27005@serenity.lan>
References: <87sj1d5ous.fsf@linux-k42r.v.cablecom.net>
 <7vd2shcnx7.fsf@alter.siamese.dyndns.org>
 <87obc15mq5.fsf@linux-k42r.v.cablecom.net>
 <20130523235711.GJ12252@machine.or.cz>
 <20130524082253.GY27005@serenity.lan>
 <20130524094006.GM12252@machine.or.cz>
 <20130524100612.GA27005@serenity.lan>
 <20130524101416.GO12252@machine.or.cz>
 <20130524104018.GB27005@serenity.lan>
 <20130524110322.GP12252@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jim Greenleaf <james.a.greenleaf@gmail.com>,
	git@vger.kernel.org
To: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Fri May 24 14:43:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfrKl-0007F0-Ey
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 14:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130Ab3EXMmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 08:42:55 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:34504 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341Ab3EXMmy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 08:42:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 46468198036;
	Fri, 24 May 2013 13:42:54 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3hbGMBCt6qVG; Fri, 24 May 2013 13:42:52 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 1B46019803E;
	Fri, 24 May 2013 13:42:44 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130524110322.GP12252@machine.or.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225349>

On Fri, May 24, 2013 at 01:03:22PM +0200, Petr Baudis wrote:
> On Fri, May 24, 2013 at 11:40:18AM +0100, John Keeping wrote:
> > So that it continues to Just Work for people using buildroot but you can
> > create Makefile.config to override those defaults.
> 
>   Indeed, that doesn't cover some corner cases of (c), but that's not a
> big deal in practice I guess.
> 
>   My point still stands - this is extra hassle, done just for the sake
> of the tool; I think the tool should not get in the way. Moreover, it's
> not the default solution for your typical original author and therefore
> you will still often find yourself in a situation where you have to deal
> with a setup that's broken already.

I think we're in violent agreement here.

I can see that there are cases where an --ignore-changes option that
behaves like --assume-unchanged but without ever overwriting the local
file is a useful feature.  I was simply trying to point at what I
consider best practices for makefiles, which was relevant for the
example you gave.  Sorry if that was unclear.
