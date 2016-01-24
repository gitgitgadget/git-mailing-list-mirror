From: fuz@fuz.su
Subject: git archive should use vendor extension in pax header
Date: Sun, 24 Jan 2016 16:59:09 +0100
Message-ID: <20160124155909.GA16847@fuz.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 24 17:01:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNN6X-0001Ya-Bv
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 17:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510AbcAXQAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 11:00:55 -0500
Received: from fuz.su ([5.135.162.8]:59384 "EHLO fuz.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752084AbcAXQAx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 11:00:53 -0500
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Jan 2016 11:00:53 EST
Received: by fuz.su (Postfix, from userid 1000)
	id 23DC120227; Sun, 24 Jan 2016 16:59:09 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284684>

Right now, git archive creates a pax global header of the form

    comment=57ca140635bf157354124e4e4b3c8e1bde2832f1

in tar archives it creates. This is suboptimal as as comments are
specified to be ignored by extraction software. It is impossible to
find out in an automatic way (short of guessing) that this is supposed
to be a commit hash. It would be much more useful if git created a
custom key. As per POSIX suggestions, something like this would be
appropriate:

    GIT.commit=57ca140635bf157354124e4e4b3c8e1bde2832f1

Please consider this suggestion.

Yours sincerely,
Robert Clausecker

-- 
()  ascii ribbon campaign - for an 8-bit clean world 
/\  - against html email  - against proprietary attachments
