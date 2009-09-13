From: Tomas Carnecky <tom@dbservice.com>
Subject: merge ignores --no-commit in fast-forward case
Date: Sun, 13 Sep 2009 08:40:05 +0200
Message-ID: <A754ACF1-77C2-4036-A15C-8949E76BD2D5@dbservice.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 13 09:11:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmjFN-00068W-K1
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 09:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647AbZIMHKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 03:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753506AbZIMHKj
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 03:10:39 -0400
Received: from office.neopsis.com ([78.46.209.98]:60953 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971AbZIMHKj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 03:10:39 -0400
X-Greylist: delayed 1809 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Sep 2009 03:10:39 EDT
Received: from calvin.emmen.dbservice.com ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	for git@vger.kernel.org;
	Sun, 13 Sep 2009 08:40:31 +0200
X-Mailer: Apple Mail (2.1076)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128341>

Bug or feature?

Three possible solutions that I see:

  2) Refuse to do anything if user gives --no-commit and merge is fast- 
forward
  3) Document this behavior in the manpage
  4) Quietly set deny_non_fast_forward when --no-commit was given

A fourth solution would be to not change anything, but users usually  
have a reason for using --no-commit, and if git commits behind their  
backs anyway that's just not nice.

tom
