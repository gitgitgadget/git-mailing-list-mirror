From: Dylan Alex Simon <dylan@dylex.net>
Subject: windows Git.pm setting GIT_DIR?
Date: Tue, 5 Apr 2011 14:00:43 -0400
Message-ID: <20110405180043.GA10878@datura.dylex.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 20:45:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7BFt-0001U0-K5
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 20:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402Ab1DESp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 14:45:28 -0400
Received: from datura.dylex.net ([216.27.141.80]:51040 "EHLO datura.dylex.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278Ab1DESp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 14:45:27 -0400
X-Greylist: delayed 2683 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Apr 2011 14:45:27 EDT
Received: from dylan by datura.dylex.net with local (Exim 4.74)
	(envelope-from <dylan@dylex.net>)
	id 1Q7AYV-0002pp-20
	for git@vger.kernel.org; Tue, 05 Apr 2011 14:00:43 -0400
Content-Disposition: inline
Jabber-ID: dylan@dylex.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170901>

We are attempting to make a perl application using Git.pm run on windows.  One
of the things we do is initialize 

        Git->repository(Directory => $some_other_directory);

This works fine on unix, but on windows the $some_other_directory seems to be
ignored.  This seems to be because _cmd_exec or its equivalent to set GIT_DIR
and chdir does not exist in the windows code-path in _command_common_pipe.  Am
I missing something that should make this work, or is this just not supported?
(Sorry, I know little about windows and trying to interpret problems others
are having.)
