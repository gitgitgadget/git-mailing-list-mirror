From: Marc Van Olmen <marc@sky4studios.be>
Subject: Problems with git-svn and space in the URL
Date: Sun, 30 May 2010 23:05:47 -0400
Message-ID: <13CB2F6C-49BB-44CB-84A7-2264CAF76766@sky4studios.be>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 31 05:05:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIvK7-00021y-SB
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 05:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755729Ab0EaDFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 May 2010 23:05:49 -0400
Received: from elasmtp-galgo.atl.sa.earthlink.net ([209.86.89.61]:44366 "EHLO
	elasmtp-galgo.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755711Ab0EaDFt convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 23:05:49 -0400
Received: from [208.120.208.90] (helo=[192.168.15.16])
	by elasmtp-galgo.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <marc@sky4studios.be>)
	id 1OIvK0-0007dE-13
	for git@vger.kernel.org; Sun, 30 May 2010 23:05:48 -0400
X-Mailer: Apple Mail (2.1078)
X-ELNK-Trace: aadfff9530346fbe1a6815bbddd658034d2b10475b5711201031bb1e3592e9266aeab546836d300b81181dcc93da7bcd350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 208.120.208.90
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148030>

Hi,

First time user.

Was trying to do a commit back to the svn repository: The svn repo has a space in the main project name:

When I try to commit, got this:

Quad-Raid-2:OnTheAir%20Video copy marcvano$ git svn dcommit
Committing to http://ns1.softronmedia.com/svn/OnTheAir Video/branches/ticket_0004_multiple_playback_buffers ...
Filesystem has no item: '/svn/!svn/bc/2643/OnTheAir' path not found at /usr/local/git/libexec/git-core/git-svn line 572

When I run:

Quad-Raid-2:OnTheAir%20Video copy marcvano$ git svn info
Path: .
URL: http://ns1.softronmedia.com/svn/OnTheAir%20Video/branches/ticket_0004_multiple_playback_buffers
Repository Root: http://ns1.softronmedia.com/svn
Repository UUID: 6f96b356-5bf8-4915-87a6-d3080d869cd8
Revision: 2643
Node Kind: directory
Schedule: normal
Last Changed Author: XXXXXX
Last Changed Rev: 2643
Last Changed Date: 2010-05-02 18:01:52 -0400 (Sun, 02 May 2010)


any solution for this problem?

marc