From: Sergio <sergio.callegari@gmail.com>
Subject: Git silently ignores --date when data is not in the correct format
Date: Mon, 13 Dec 2010 15:20:07 +0000 (UTC)
Message-ID: <loom.20101213T161633-993@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 16:20:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSACp-0007yo-GQ
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 16:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120Ab0LMPUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 10:20:34 -0500
Received: from lo.gmane.org ([80.91.229.12]:57857 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754111Ab0LMPUb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 10:20:31 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PSACN-0007jQ-CC
	for git@vger.kernel.org; Mon, 13 Dec 2010 16:20:30 +0100
Received: from i2-ve060.ingce.unibo.it ([137.204.107.60])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 16:20:18 +0100
Received: from sergio.callegari by i2-ve060.ingce.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 16:20:18 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.107.60 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101206 Ubuntu/10.10 (maverick) Firefox/3.6.13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163557>

Hi,

on 1.7.3.3, I have noticed that git --commit silently ignores the 
--date=<date> switch if <date> is not in the current format.

for instance

git --commit --amend --date="10.11.2010" creates a commit with the current
date and time, because the --date argument misses the time.

possibly, it would be better to stop with an error message.
