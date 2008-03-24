From: Santiago Gala <sgala@apache.org>
Subject: BUG:git-log --follow <path> should never trim output WRT equivalent git-log <path>
Date: Mon, 24 Mar 2008 16:19:01 +0000 (UTC)
Message-ID: <loom.20080324T161602-184@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 17:20:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdpOy-0003N1-Kk
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 17:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419AbYCXQTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 12:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753337AbYCXQTS
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 12:19:18 -0400
Received: from main.gmane.org ([80.91.229.2]:51207 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437AbYCXQTS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 12:19:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JdpOC-0002Aq-DG
	for git@vger.kernel.org; Mon, 24 Mar 2008 16:19:12 +0000
Received: from 233.Red-81-33-31.staticIP.rima-tde.net ([81.33.31.233])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Mar 2008 16:19:12 +0000
Received: from sgala by 233.Red-81-33-31.staticIP.rima-tde.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Mar 2008 16:19:12 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 81.33.31.233 (Mozilla/5.0 (X11; U; Linux x86_64; es-ES; rv:1.8.1.12) Gecko/20080209 Firefox/2.0.0.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78055>

I tried this on today's git.git repository, as a suggestion for following moves:

$ git log  -M -C -C --color --stat --follow -- gitk-git/po/de.po | wc -l
0
sgala@marlow ~/newcode/git/git (master)$ git log  -M -C -C --color --stat --
gitk-git/po/de.po | wc -l
31
$ git --version
git version 1.5.4.4

I find very strange that --follow makes git log to stop outputting the first
entries.

Regards
Santiago
