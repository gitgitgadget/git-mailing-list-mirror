From: Ralf Baechle <ralf@linux-mips.org>
Subject: Confusing error message
Date: Thu, 21 Oct 2010 09:57:42 +0100
Message-ID: <20101021085742.GA28533@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 21 10:57:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8qy8-00040M-CB
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 10:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694Ab0JUI5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 04:57:47 -0400
Received: from h5.dl5rb.org.uk ([81.2.74.5]:39229 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975Ab0JUI5q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 04:57:46 -0400
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o9L8vhTE028839
	for <git@vger.kernel.org>; Thu, 21 Oct 2010 09:57:44 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o9L8vhfr028837
	for git@vger.kernel.org; Thu, 21 Oct 2010 09:57:43 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159490>

$ git checkout master
$ git branch linux-2.6.36-stable
error: Not tracking: ambiguous information for ref refs/heads/master
$

Error suggests the command did fail but the branch was created as expected.
I suggest to turn this into a warning - if at all. I just don't care about
the tracking stuff.

  Ralf
