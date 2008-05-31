From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 31 May 2008 03:25:11 +0200
Message-ID: <20080531012511.GA5907@leksak.fem-net>
References: <7vr6d8apjx.fsf@gitster.siamese.dyndns.org> <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org> <7vr6crj0jk.fsf@gitster.siamese.dyndns.org> <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org> <7vabijxhk4.fsf@gitster.siamese.dyndns.org> <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <48406D5C.4000703@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Loeliger <jdl@freescale.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 31 03:26:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2FrO-0002Yn-HV
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 03:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbYEaBZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 21:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752385AbYEaBZS
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 21:25:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:56127 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752219AbYEaBZR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 21:25:17 -0400
Received: (qmail invoked by alias); 31 May 2008 01:25:15 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp009) with SMTP; 31 May 2008 03:25:15 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19ie2NCVvViO4bwiiVVk/Kjqwg1Lq9oHY7B4xuJwl
	ZvLg+Q9lN5VDJZ
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K2FqJ-0001Xl-AF; Sat, 31 May 2008 03:25:11 +0200
Content-Disposition: inline
In-Reply-To: <48406D5C.4000703@freescale.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83362>

Hi,

> One suggestion was to make a procedural model out of
> the commit graph and allow something like this:
>
>    b :- pick(B)
>    x :- merge(pick(A), b)
>    y :- merge(pick(C), b)
>    z :- merge(x, y)

Nice idea.  But imho too hard for casual users.
Someone who has to learn a new language won't use the tool.

> My second and semi-equivallent suggestion was to
> allow a lisp-like notation:
>
>    (merge (merge (pick A)
>                  (pick B)
>           (merge (pick B)
>                  (pick C)

You forgot some right parenthesis here ;-)
...which shows, that it is also not easy enough for users.

Or is it intentional?

:)
Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
