From: Eli Barzilay <eli@barzilay.org>
Subject: gitweb.css
Date: Wed, 7 Jul 2010 22:43:15 -0400
Message-ID: <19509.15171.909921.769184@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 08 04:43:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWh58-000447-Uw
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 04:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448Ab0GHCnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 22:43:17 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:56945 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465Ab0GHCnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 22:43:16 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1OWh51-0006yb-Tm
	for git@vger.kernel.org; Wed, 07 Jul 2010 22:43:15 -0400
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150528>

I've been customizing a gitweb server to fit with the rest of our
project pages (the result is http://git.racket-lang.org/).  This was
relatively easy to do except for a few places where gitweb.css
specifies formatting for generic tags like `body', `table', and `td',
which messed up our header.

Maybe it makes sense to localize these styles to to gitweb specific
classes?  (I know that I can just use my own css, but the file is big
enough that I prefer avoiding manually merging in updates.)

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
