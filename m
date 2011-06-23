From: layer <layer@known.net>
Subject: git + cygwin + core.editor - adding drive when it shouldn't
Date: Thu, 23 Jun 2011 15:09:37 -0700
Message-ID: <25237.1308866977@relay.known.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 00:09:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZs5r-0007f7-3a
	for gcvg-git-2@lo.gmane.org; Fri, 24 Jun 2011 00:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760027Ab1FWWJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 18:09:38 -0400
Received: from relay.known.net ([173.13.135.57]:40897 "EHLO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760019Ab1FWWJi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 18:09:38 -0400
Received: from relay.known.net (localhost [127.0.0.1]) by relay.known.net
    (Allegro Maild v1.2.25) id 000000196639; Thu, 23 Jun 2011 15:09:37 -0700
X-Mailer: MH-E 8.2; nmh 1.3; GNU Emacs 23.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176296>

Actually, it looks like emacs is doing it:

1 -> server-log: string="Received -auth ... -dir C:\\cygwin\\home\\layer\\acl82.64\\src\\cl/ -current-frame -tty CONOUT$ emacs -file /home/layer/acl82.64/src/cl/.git/rebase-merge/git-rebase-todo 
" client=#<process server <127.0.0.1:55481>>

The -file value doesn't have a c:/....  nevermind.

Kevin
