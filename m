From: Jeff King <peff@peff.net>
Subject: Re: default aliases (ci, di, st, co)
Date: Mon, 13 Jul 2009 02:43:09 -0400
Message-ID: <20090713064309.GB10300@coredump.intra.peff.net>
References: <85b5c3130907081649s37f726f7id1a64f2fdbe609f@mail.gmail.com>
 <m3my7evhky.fsf@localhost.localdomain>
 <7vskh53iyt.fsf@alter.siamese.dyndns.org>
 <4A56786B.7040904@gnu.org>
 <20090713064027.GA10300@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Ondrej Certik <ondrej@certik.cz>,
	Git Mailing List <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 13 08:43:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQFFv-0000wV-Nr
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 08:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbZGMGnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 02:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752242AbZGMGnM
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 02:43:12 -0400
Received: from peff.net ([208.65.91.99]:49767 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbZGMGnL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 02:43:11 -0400
Received: (qmail 31505 invoked by uid 107); 13 Jul 2009 06:45:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 13 Jul 2009 02:45:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Jul 2009 02:43:09 -0400
Content-Disposition: inline
In-Reply-To: <20090713064027.GA10300@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123172>

On Mon, Jul 13, 2009 at 02:40:27AM -0400, Jeff King wrote:

> On Fri, Jul 10, 2009 at 01:08:27AM +0200, Paolo Bonzini wrote:
> 
> > Yes, it's in the wiki and in my .gitconfig:
> > 
> >         whatis = "!sh -c 'git show -s --pretty=\"format:%h (%s, %ai\"
> > \"$@\" | sed -e \"s/ [012][0-9]:[0-5][0-9]:[0-5][0-9]
> > [-+][0-9][0-9][0-9][0-9]$/)\\n/\"' -"
> 
> Is there a reason not to simply use:
> 
>   whatis = "show -s --pretty='format:%h (%s, %ad)' --date=short"
> 
> these days?
> 
> -Peff
> 
> P.S. Actually, I use --no-pager in my version, so I use 'tformat' to
> explicitly end it with a newline, which is nicer for actually showing
> the output on the terminal.

Er, actually, I see yours adds the newline explicitly in the sed
invocation, so it would definitely be 'tformat' to match what yours
does.

-Peff
