From: John Goerzen <jgoerzen@complete.org>
Subject: git-relink doesn't work on bare repos
Date: Mon, 3 Mar 2008 18:29:38 -0600
Message-ID: <slrnfsp5vi.sa5.jgoerzen@katherina.lan.complete.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 02:08:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWLeH-0002f9-W3
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 02:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190AbYCDBIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 20:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752027AbYCDBIQ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 20:08:16 -0500
Received: from main.gmane.org ([80.91.229.2]:37327 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751454AbYCDBIP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 20:08:15 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JWLdc-00005Z-PE
	for git@vger.kernel.org; Tue, 04 Mar 2008 01:08:13 +0000
Received: from 63-245-179-205.kitusa.com ([63.245.179.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 01:08:12 +0000
Received: from jgoerzen by 63-245-179-205.kitusa.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 01:08:12 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 63-245-179-205.kitusa.com
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76006>

If I try to point git-relink at a bare repo, I get:

Usage: /usr/bin/git-relink [--safe] <dir> [<dir> ...] <master_dir>
All directories should contain a .git/objects/ subdirectory.

In my case, both master_dir and the CWD are bare repos.

This is 1.5.4.2


