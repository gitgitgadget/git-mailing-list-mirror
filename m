From: Geoff Richards <qef@ungwe.org>
Subject: Mistake in manpage for git-commit-tree?
Date: Sat, 14 Jul 2007 23:47:54 +0100
Message-ID: <20070714224752.GD9011@ungwe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 15 00:57:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9qYa-0007vZ-Qf
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 00:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819AbXGNW5l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 18:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753219AbXGNW5l
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 18:57:41 -0400
Received: from queueout02-winn.ispmail.ntl.com ([81.103.221.56]:5247 "EHLO
	queueout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753187AbXGNW5k (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jul 2007 18:57:40 -0400
X-Greylist: delayed 582 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Jul 2007 18:57:40 EDT
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com with ESMTP
          id <20070714224757.CLBZ13.mtaout03-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>
          for <git@vger.kernel.org>; Sat, 14 Jul 2007 23:47:57 +0100
Received: from blacktooth.laxan.com ([82.3.192.247])
          by aamtaout01-winn.ispmail.ntl.com with ESMTP
          id <20070714224757.RNLL219.aamtaout01-winn.ispmail.ntl.com@blacktooth.laxan.com>
          for <git@vger.kernel.org>; Sat, 14 Jul 2007 23:47:57 +0100
Received: from qef by blacktooth.laxan.com with local (Exim 4.67)
	(envelope-from <qef@laxan.com>)
	id 1I9qP4-0000mt-Lu
	for git@vger.kernel.org; Sat, 14 Jul 2007 23:47:55 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52516>

Hi,

Just saw this in Documentation/git-commit-tree.txt at line 75:

    A commit comment is read from stdin (max 999 chars). If a changelog

But from looking at the code it appears there is no such limit.  That's
the size of the buffer used to read the commit message in, but it should
read multiple chunks of that size if you give it more than that.

If I'm not missing something, I'd suggest removing that bit in parens.

hth,
    Geoff
