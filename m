From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [RFC] Using gitrevisions :/search style with other operators
Date: Tue, 09 Nov 2010 10:24:28 +0100
Organization: Bertin Technologies
Message-ID: <20101109102428.5ba8dc13@chalon.bertin.fr>
References: <20101109083023.783fad9b@chalon.bertin.fr>
 <13A8F1B3-39B0-4D11-8763-9C458F75487D@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git list <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Nov 09 10:35:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFkbj-0006GT-92
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 10:35:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683Ab0KIJfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 04:35:10 -0500
Received: from blois.bertin.fr ([195.68.26.9]:44658 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752337Ab0KIJfI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 04:35:08 -0500
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 548455432F
	for <git@vger.kernel.org>; Tue,  9 Nov 2010 10:35:06 +0100 (CET)
Received: from YPORT1 (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id EB9435432E
	for <git@vger.kernel.org>; Tue,  9 Nov 2010 10:35:04 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0LBM00J762MGN180@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Tue, 09 Nov 2010 10:35:04 +0100 (CET)
In-reply-to: <13A8F1B3-39B0-4D11-8763-9C458F75487D@sb.org>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8200-6.0.0.1038-17754.005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161025>

On Tue, 09 Nov 2010 00:06:47 -0800
Kevin Ballard <kevin@sb.org> wrote:

> On Nov 8, 2010, at 11:30 PM, Yann Dirson wrote:
> 
> > Kevin wrote:
> >> Junio wrote:
> >>>   $ git log 'HEAD..:( :/Merge branch 'kb/blame-author-email' )^2'
> > [...]
> >> 
> >> Interesting idea. It certainly solves the problem of being able to
> >> embed it within other operations (though you do then have to worry
> >> about escaping any embedded close-parens in the search), though it
> >> does mean my suggestion for being able to select the 2nd (or nth)
> >> match won't work.
> > 
> > Syntax like origin/pu^{/Merge 'kb/blame-author-email'}2 would be
> > somewhat consistent with the commit^2 case, and would seem
> > unambiguous as well - a bit weird, though.
> 
> This violates the idea that once you reach the end of a ^{} structure,
> it resolves to a commit that can then be modified by subsequent
> operations.

OK, that's kinda related to the "looks weird" issue. 

Another idea: origin/pu^{:2/Merge 'kb/blame-author-email'}
Since the foo^{objecttype} syntax would not care for a count, it is not
a problem, and it keeps provision for using a count with future
operators.  OTOH, it could be a problem if we extend foo^{bar} to
accept "bar" for other things than object types.

-- 
Yann Dirson - Bertin Technologies
