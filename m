From: Johannes Gilger <heipei@hackvalue.de>
Subject: border-case/general git test repository
Date: Thu, 29 Jan 2009 18:54:40 +0000 (UTC)
Message-ID: <glsu1g$egf$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 19:56:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSc3r-0007vR-36
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 19:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754393AbZA2Sy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 13:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753946AbZA2Sy4
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 13:54:56 -0500
Received: from main.gmane.org ([80.91.229.2]:33432 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753190AbZA2Syz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 13:54:55 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LSc2Q-0004JE-2F
	for git@vger.kernel.org; Thu, 29 Jan 2009 18:54:54 +0000
Received: from u-4-224.vpn.rwth-aachen.de ([137.226.100.224])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 18:54:54 +0000
Received: from heipei by u-4-224.vpn.rwth-aachen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 18:54:54 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: u-4-224.vpn.rwth-aachen.de
User-Agent: slrn/0.9.9p1 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107716>

Hi,

partly because of laziness, partly out of curiosity I was wondering if 
anyone had a (relatively small) test-repository lying around, that 
especially stresses the output (not really the integrity of the data) of 
git and all kinds of different combinations of operations.

We could really use it for GitX, as GitX parses the output of git and 
everytime we think we have found/fixed a glitch in the display we 
discover some new case. For example we just noticed that we didn't 
detect file-mode changes, and after we implemented that we thought that, 
of course, a file can change its mode and content at the same time...  
and so on ;)

So things we're looking for are things that usually don't happen that 
often (because of obscureness or because of convention respected by 
people) but are still perfectly valid output that our/other programs 
could trip over.

Greetings,
Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://hackvalue.de/heipei/
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
