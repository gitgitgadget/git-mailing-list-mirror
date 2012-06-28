From: Daniel Milde <daniel@milde.cz>
Subject: git submodule return status
Date: Thu, 28 Jun 2012 10:28:00 +0200
Message-ID: <1340872080.2103.92.camel@athena.dnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 28 10:34:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkABF-0000Jv-Dw
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 10:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400Ab2F1IeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jun 2012 04:34:19 -0400
Received: from s1.milde.cz ([77.93.192.212]:36495 "EHLO s1.milde.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932325Ab2F1IeO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2012 04:34:14 -0400
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jun 2012 04:34:14 EDT
Received: from [10.0.0.121] (79-98-72-219.sys-data.com [79.98.72.219])
	by s1.milde.cz (Postfix) with ESMTPSA id 8B0539A80D
	for <git@vger.kernel.org>; Thu, 28 Jun 2012 09:25:49 +0100 (BST)
X-Mailer: Evolution 3.4.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200783>

Hello,
if command git submodule update fails, return status is not set
properly.

Example:
$ git submodule update unknown
error: pathspec 'unknown' did not match any file(s) known to git.
Did you forget to 'git add'?
error: pathspec 'unknown' did not match any file(s) known to git.
Did you forget to 'git add'?
$ echo $?
0

I suppose the exit status should be 1 or something else, but not 0.

Best regards
Daniel Milde
