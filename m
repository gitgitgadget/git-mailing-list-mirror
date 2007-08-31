From: Petr Baudis <pasky@suse.cz>
Subject: Re: [BUG] (minor) Cloning an empty repository
Date: Fri, 31 Aug 2007 12:10:52 +0200
Message-ID: <20070831101052.GO1219@pasky.or.cz>
References: <vpqk5rc10mx.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Aug 31 12:11:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR3Sr-0002d6-BT
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 12:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756830AbXHaKKy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 06:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756350AbXHaKKy
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 06:10:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45485 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756774AbXHaKKx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 06:10:53 -0400
Received: (qmail 28003 invoked by uid 2001); 31 Aug 2007 12:10:52 +0200
Content-Disposition: inline
In-Reply-To: <vpqk5rc10mx.fsf@bauges.imag.fr>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57147>

  Hi,

On Fri, Aug 31, 2007 at 12:03:50PM CEST, Matthieu Moy wrote:
> That's a detail, but it would be better if either git could actually
> do the clone, or give me a clean error message like "Can not clone
> empty repository".

FWIW, I would like git to clone empty repositories too. With the current
smart remotes handling, it will pick up the first branches as they
appear in the other repository automagically. And with e.g. repo.or.cz,
if you are starting a project from scratch this would be useful. Sure,
you can instead git init && git remote add origin git+ssh://.../, but
this fact seems to be confusing not-so-git-well-versed people.

Now, I guess you'd like a patch... ;-)

-- 
				Petr "Pasky" Baudis
Early to rise and early to bed makes a male healthy and wealthy and dead.
                -- James Thurber
