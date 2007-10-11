From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] cvsserver: added support for update -p
Date: Thu, 11 Oct 2007 19:29:38 +0200
Message-ID: <20071011172938.GN31659@planck.djpig.de>
References: <200710101316.03633.jan@swi-prolog.org> <1192120573-16765-1-git-send-email-frank@lichtenheld.de> <200710111852.32740.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jan Wielemaker <jan@swi-prolog.org>
To: Jan Wielemaker <wielemak@science.uva.nl>
X-From: git-owner@vger.kernel.org Thu Oct 11 19:30:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig1rP-00053D-BN
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 19:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918AbXJKR37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 13:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754305AbXJKR37
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 13:29:59 -0400
Received: from planck.djpig.de ([85.10.192.180]:2418 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753593AbXJKR36 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 13:29:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 5744388231;
	Thu, 11 Oct 2007 19:29:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id isk8SzuRg0ei; Thu, 11 Oct 2007 19:29:39 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 788FF88232; Thu, 11 Oct 2007 19:29:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200710111852.32740.wielemak@science.uva.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60617>

On Thu, Oct 11, 2007 at 06:52:32PM +0200, Jan Wielemaker wrote:
> On Thursday 11 October 2007 18:36, Frank Lichtenheld wrote:
> > Based on a patch by Jan Wielemaker <jan@swi-prolog.org>.
> >
> > Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
> 
> Thanks. You are a bigger Perl programmer than I :-) Are you also
> interested in one that makes "cvs diff -c" work?  It works, but it
> does not handle things like "cvs diff -C 5" and I'm a bit lost in
> Perl-space ...  If someone knowing more about the server wants to
> have a look, I'm happy to post the part I have.

Hmm, the more half-patches you submit the more I'd rather prefer you
learning Perl ;) Or at least write your own testcases.

diff -c doesn't really interest me at all. So I'd really prefer you
doing the bulk of the work...

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
