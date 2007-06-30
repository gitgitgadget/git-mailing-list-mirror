From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: a bunch of outstanding updates
Date: Sat, 30 Jun 2007 20:56:11 +1200
Message-ID: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 10:57:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4YlO-0006AV-Jw
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 10:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887AbXF3I4q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 04:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754073AbXF3I4p
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 04:56:45 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:56639 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779AbXF3I40 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 04:56:26 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1I4Ykf-0008Tt-Vz; Sat, 30 Jun 2007 20:56:22 +1200
Received: by localhost.localdomain (Postfix, from userid 1000)
	id E6EC95CE00; Sat, 30 Jun 2007 20:56:21 +1200 (NZST)
X-Mailer: git-send-email 1.5.2.1.1131.g3b90-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51208>


Following up to this e-mail are a whole load of outstanding feature
requests of mine.

These changes are relatively mundane:

    * repack: improve documentation on -a option
    * git-remote: document -n
    * git-remote: allow 'git-remote fetch' as a synonym for 'git fetch'
    * git-svn: use git-log rather than rev-list | xargs cat-file
    * git-svn: cache max revision in rev_db databases

This one will impact on the version displayed by "git --version", but
I think this is for the better:

    * GIT-VERSION-GEN: don't convert - delimiter to .'s

These ones are really only very minor updates based on feedback so
far:

    * git-merge-ff: fast-forward only merge
    * git-mergetool: add support for ediff

This one is just the previously posted hook script put into the
templates directory, let me know if you'd rather I reshaped it to go
into contrib/hooks:

    * contrib/hooks: add post-update hook for updating working copy

This one probably needs a bit more consideration and review, could
perhaps sit on pu.

    * git-repack: generational repacking (and example hook script)
