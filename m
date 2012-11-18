From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: git-reset man page
Date: Sun, 18 Nov 2012 18:48:59 +0100
Message-ID: <20121118174859.GA29052@shrek.podlesie.net>
References: <CAB9Jk9AdTBJotrB0fndZawMWH6hS4PW_5bHwecwY5Vz7=TnYAA@mail.gmail.com>
 <20121110155718.GA29321@shrek.podlesie.net>
 <7v8va9p6pn.fsf@alter.siamese.dyndns.org>
 <20121110204633.GA29363@shrek.podlesie.net>
 <CAM9Z-nkon5ZtPuqxL0HZPr1es9DSpLA+70++hYpTR4D7WTxbUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, peff@peff.net
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 18:49:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta8zj-0007CD-1m
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 18:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063Ab2KRRtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 12:49:04 -0500
Received: from [93.179.225.50] ([93.179.225.50]:44912 "EHLO shrek.podlesie.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752003Ab2KRRtD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 12:49:03 -0500
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id C63D8F75; Sun, 18 Nov 2012 18:48:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAM9Z-nkon5ZtPuqxL0HZPr1es9DSpLA+70++hYpTR4D7WTxbUA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210036>

On Sun, Nov 18, 2012 at 11:55:09AM -0500, Drew Northup wrote:
> 
> > So we should always use "<path>" for exact path, and "<pathspec>" for
> > pathspecs patterns as defined in gitglossary. I think it's better
> > to avoid "<paths>" and always use "<path>..." or "<pathspec>..."
> 
> I suspect that the only reason why the differentiation between
> "<path>" and "<paths>" happened is because there may be some places
> where it was seen that a _list of paths_ was acceptable (which isn't a
> pathspec, as it isn't a search expression) and other places where

<paths> is usually used for a list of <pathspec>, not just a list of <path>.

> _only_ a single path was acceptable. Should that fail to be the case
> then there would be a good argument for changing the affected
> instances of "<paths>" to "<path>" in the documentation. (I know of no
> other good way to pluralize "<path>" myself.)
> 

I think it's best to just add "...":

<path> for single exact path,
<path>... for a list of exact paths,
<pathspec> for single pathspec,
<pathspec>... for a list of pathspecs.

Krzysiek
