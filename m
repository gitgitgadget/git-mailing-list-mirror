From: Max Kirillov <max@max630.net>
Subject: [PATCH 0/4 v2] gitk: show latest change to region
Date: Tue, 24 Jun 2014 21:15:14 +0300
Message-ID: <20140624181514.GA23051@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 20:15:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzVG7-0007TL-8X
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 20:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbaFXSPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 14:15:51 -0400
Received: from p3plsmtpa11-01.prod.phx3.secureserver.net ([68.178.252.102]:46890
	"EHLO p3plsmtpa11-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752168AbaFXSPu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jun 2014 14:15:50 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa11-01.prod.phx3.secureserver.net with 
	id JJFS1o0013gsSd601JFnQe; Tue, 24 Jun 2014 11:15:49 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252412>

Changes vs v1:
* Rebase to latest gitk master
* Fix typos in commments
* Switch to patch mode at showing the found change

Max Kirillov (4):
      gitk: use single blamestuff for all show_line_source{} calls
      gitk: refactor: separate generic hunk parsing out of find_hunk_blamespecs{}
      gitk: refactor: separate io from logic in the searching origin of line
      gitk: show latest change to region

 gitk | 265 +++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 220 insertions(+), 45 deletions(-)
