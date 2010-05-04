From: Eli Barzilay <eli@barzilay.org>
Subject: Shell aliases & paths
Date: Tue, 4 May 2010 16:38:10 -0400
Message-ID: <19424.34226.564684.613674@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 04 22:38:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9Ot3-0005TK-1W
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 22:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933753Ab0EDUiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 16:38:14 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:35400 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933608Ab0EDUiM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 16:38:12 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1O9Osc-00074h-Id
	for git@vger.kernel.org; Tue, 04 May 2010 16:38:10 -0400
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146341>

AFAICT, a shell command alias (one that starts with a "!") is executed
from the repository root, but to make things worse it looks like there
is no way to tell which directory it was executed from.  If this is
correct, then these aliases are useless for anything that need to
accept relative paths.  Is there something obvious that I'm missing?

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
