From: Eric Raible <raible@gmail.com>
Subject: gitk: spanish translation of gitk introduced extra directory
Date: Wed, 21 May 2008 05:17:52 +0000 (UTC)
Message-ID: <loom.20080521T045435-319@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 21 07:19:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JygjQ-0004k3-9a
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 07:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbYEUFSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 01:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752775AbYEUFSE
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 01:18:04 -0400
Received: from main.gmane.org ([80.91.229.2]:54722 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752733AbYEUFSD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 01:18:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Jygi9-0005G8-8E
	for git@vger.kernel.org; Wed, 21 May 2008 05:18:01 +0000
Received: from mobile-166-217-222-044.mycingular.net ([166.217.222.44])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 May 2008 05:18:01 +0000
Received: from raible by mobile-166-217-222-044.mycingular.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 May 2008 05:18:01 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 166.217.222.44 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.14) Gecko/20080404 Firefox/2.0.0.14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82525>

It seems as if commit cc398a286b4cb5cb76c515588668bab4858a01cf
(gitk: Spanish translation of gitk) introduced an extra directory.

Instead of creating gitk-git/po/es.po that commit created
gitk-git/gitk-git/po/es.po.  In other words, we need the following:

    git mv gitk-git/gitk-git/po/es.po gitk-git/po

Additionally, given that this will leave an empty directory
(gitk-git/gitk-git/po) that even "git clean -f" won't remove,
is it worth updating "git mv" so that it removes directories
if/when it removes all content from that directory?

- Eric
