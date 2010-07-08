From: Eli Barzilay <eli@barzilay.org>
Subject: Re: gitweb.perl suggestion
Date: Thu, 8 Jul 2010 15:05:06 -0400
Message-ID: <19510.8546.716887.192752@winooski.ccs.neu.edu>
References: <19509.14862.368282.470934@winooski.ccs.neu.edu>
	<m339vum1od.fsf@localhost.localdomain>
	<19510.3108.337932.666012@winooski.ccs.neu.edu>
	<201007082101.41286.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 21:05:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWwPL-0002VW-PH
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 21:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758437Ab0GHTFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 15:05:08 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:42555 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755604Ab0GHTFH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 15:05:07 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1OWwPC-0000ff-Na; Thu, 08 Jul 2010 15:05:06 -0400
In-Reply-To: <201007082101.41286.jnareb@gmail.com>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150597>

On Jul  8, Jakub Narebski wrote:
> Eli Barzilay wrote:
> > On Jul  8, Jakub Narebski wrote:
> > > 
> > > So your proposed solution is good enough, but perhaps better would
> > > be to leave 'action' unset if there is no parent info?  Then
> > > dispatch would guess action, instead of doing it in less
> > > sophisticated way in evaluate_path_info().
> > 
> > Ah, looking at the dispatch point, I see what you're talking about.
> > But that sounds like a larger change to the code -- since it would
> > probably lead to more default actions that get determined in dispatch
> > instead of earlier.
> 
> I don't remember if it was the real reson why
> http://gitweb/project/<object> defaults to 'shortlog' action, but
> <object> can be commit, but can be also tag.  The 'shortlog' action
> makes sense for both... assuming that tag points to a commit object,
> that is.

Ah, so it has to check the type of the object anyway...


> P.S. As usual, patches welcome...

(I can turn that one-line change into a patch, but for anything more
substantial I'll actually need to deal with perl...)

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
