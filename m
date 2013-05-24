From: Petr Baudis <pasky@ucw.cz>
Subject: Re: git stash deletes/drops changes of
Date: Fri, 24 May 2013 12:14:16 +0200
Message-ID: <20130524101416.GO12252@machine.or.cz>
References: <AANLkTin-BIxgQE5CO2cLhCYJAGHFxiXPquyozKc308DS@mail.gmail.com>
 <loom.20130523T185301-635@post.gmane.org>
 <87sj1d5ous.fsf@linux-k42r.v.cablecom.net>
 <7vd2shcnx7.fsf@alter.siamese.dyndns.org>
 <87obc15mq5.fsf@linux-k42r.v.cablecom.net>
 <20130523235711.GJ12252@machine.or.cz>
 <20130524082253.GY27005@serenity.lan>
 <20130524094006.GM12252@machine.or.cz>
 <20130524100612.GA27005@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jim Greenleaf <james.a.greenleaf@gmail.com>,
	git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri May 24 12:14:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufp0z-0005qw-UX
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 12:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760080Ab3EXKOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 06:14:21 -0400
Received: from pasky.or.cz ([84.242.80.195]:48745 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754604Ab3EXKOU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 06:14:20 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id A75B117000A6; Fri, 24 May 2013 12:14:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130524100612.GA27005@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225340>

On Fri, May 24, 2013 at 11:06:12AM +0100, John Keeping wrote:
> I don't see anything wrong with having a template file documenting the
> parameters, but I think it's important that there are sensible defaults
> in place when the user's configuration file does not specify a value for
> a parameter.  It wasn't clear to me from your definition that there were
> defaults to be overridden by the user's configuration file, as opposed
> to forcing the user to define certain values and causing an error if
> those are not defined.

That's the case in plenty of situations - when specifying usernames and
passwords and server hostnames, paths to cross-compiling environments
that pretty much everyone has at a different place, and so on.

-- 
				Petr "Pasky" Baudis
	For every complex problem there is an answer that is clear,
	simple, and wrong.  -- H. L. Mencken
