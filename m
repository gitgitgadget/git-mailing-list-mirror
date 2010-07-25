From: Eli Barzilay <eli@barzilay.org>
Subject: Possible bug with `export-subst' attribute
Date: Sun, 25 Jul 2010 05:08:12 -0400
Message-ID: <19531.65276.394443.190317@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 11:08:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcxC9-0006yc-Av
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 11:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377Ab0GYJIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 05:08:15 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:52323 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751041Ab0GYJIO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 05:08:14 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1OcxBs-0004j7-DH
	for git@vger.kernel.org; Sun, 25 Jul 2010 05:08:12 -0400
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151716>

I have a file with:

  (define archive-id "$Format:%ct|%h|a$")

and an `export-subst' attribute -- and it looks like the "%h" results
in a full sha1 instead of the abbreviated one when used with `git
archive'.  This is with 1.7..2 -- I'm not sure, but I think that it
worked fine with 1.7.1.

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
