From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: How to find a commit that introduces (not removes) a string?
Date: Thu, 03 Nov 2011 10:50:18 +0100
Message-ID: <j8to8h$vqd$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 10:52:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLtyR-0008DG-V3
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 10:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204Ab1KCJwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 05:52:35 -0400
Received: from lo.gmane.org ([80.91.229.12]:51661 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754913Ab1KCJwe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 05:52:34 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RLtyL-0008C7-VM
	for git@vger.kernel.org; Thu, 03 Nov 2011 10:52:33 +0100
Received: from jambul.zib.de ([130.73.68.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Nov 2011 10:52:33 +0100
Received: from sschuberth by jambul.zib.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Nov 2011 10:52:33 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: jambul.zib.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184710>

Hi all,

I know about git log's -S / -G, but I'm unable to make these search through *introduced* strings only. Is there a way to do so?

Thanks!

PS: I also read [1], but although the author claims to be interested in introduced strings only, he seems to be satisfied with -G, which slightly puzzles me.

[1] http://stackoverflow.com/questions/5816134/git-finding-a-commit-that-introduced-a-string

-- 
Sebastian Schuberth
