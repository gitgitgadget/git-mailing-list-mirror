From: Eli Barzilay <eli@barzilay.org>
Subject: Re: gitweb.perl suggestion
Date: Thu, 8 Jul 2010 13:34:28 -0400
Message-ID: <19510.3108.337932.666012@winooski.ccs.neu.edu>
References: <19509.14862.368282.470934@winooski.ccs.neu.edu>
	<m339vum1od.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 19:34:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWuzb-0005Sj-BI
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 19:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757906Ab0GHRea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 13:34:30 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:59752 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756333Ab0GHRe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 13:34:29 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1OWuzU-000626-BH; Thu, 08 Jul 2010 13:34:28 -0400
In-Reply-To: <m339vum1od.fsf@localhost.localdomain>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150588>

On Jul  8, Jakub Narebski wrote:
> 
> So your proposed solution is good enough, but perhaps better would
> be to leave 'action' unset if there is no parent info?  Then
> dispatch would guess action, instead of doing it in less
> sophisticated way in evaluate_path_info().

Ah, looking at the dispatch point, I see what you're talking about.
But that sounds like a larger change to the code -- since it would
probably lead to more default actions that get determined in dispatch
instead of earlier.

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
