From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: git-reset man page
Date: Sat, 10 Nov 2012 21:46:33 +0100
Message-ID: <20121110204633.GA29363@shrek.podlesie.net>
References: <CAB9Jk9AdTBJotrB0fndZawMWH6hS4PW_5bHwecwY5Vz7=TnYAA@mail.gmail.com>
 <20121110155718.GA29321@shrek.podlesie.net>
 <7v8va9p6pn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 21:46:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXHx4-000245-1y
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 21:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622Ab2KJUqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 15:46:36 -0500
Received: from shrek-modem1.podlesie.net ([83.18.25.171]:54114 "EHLO
	shrek.podlesie.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752322Ab2KJUqf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 15:46:35 -0500
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id D4F665C5; Sat, 10 Nov 2012 21:46:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v8va9p6pn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209305>

On Sat, Nov 10, 2012 at 12:02:12PM -0800, Junio C Hamano wrote:
> Krzysztof Mazur <krzysiek@podlesie.net> writes:
> 
> > Maybe we should just add that <paths> is an shortcut for <pathspec>
> > and fix places where paths and pathspec are mixed or <path> is used as
> > <pathspec>.
> 
> We should unify uses of <paths> and <path> (the former should be
> <path>... or something).

Currently in most cases "<paths>..." is used ;)

> 
> Some places you need to give exact path (iow, these places you
> cannot use pathspec), while most other places pathspec
> (i.e. matching pattern) is accepted.

I know, thats why I added a note that "<path> is not always used for pathspec".

> 
> The manual correctly updated will most likely to use both <path> and
> <pathspec> appropriately.

So we should always use "<path>" for exact path, and "<pathspec>" for
pathspecs patterns as defined in gitglossary. I think it's better
to avoid "<paths>" and always use "<path>..." or "<pathspec>...".

Krzysiek
