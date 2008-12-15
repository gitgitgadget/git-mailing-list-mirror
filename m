From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: hooks/post-update execs git-update-server-info
Date: Mon, 15 Dec 2008 16:18:30 +0000 (UTC)
Organization: disorganised!
Message-ID: <gi600m$tts$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 17:20:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCGAw-0003pd-Vp
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 17:20:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbYLOQSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 11:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752914AbYLOQSt
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 11:18:49 -0500
Received: from main.gmane.org ([80.91.229.2]:57941 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753116AbYLOQSs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 11:18:48 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LCG9Y-0006Tz-IJ
	for git@vger.kernel.org; Mon, 15 Dec 2008 16:18:40 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 16:18:40 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 16:18:40 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103176>

shouldn't .git/hooks/post-update contain "exec git
update-server-info" (note the space not hyphen) instead of
"exec git-update-server-info"?

Either I am horribly confused or HTTP pulls have not been
working on post 1.6 gits and no one has noticed till now :-)
