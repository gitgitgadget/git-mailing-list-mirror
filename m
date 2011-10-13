From: Adam Piatyszek <ediap@wp.pl>
Subject: git rebase +
Date: Thu, 13 Oct 2011 11:48:39 +0000 (UTC)
Message-ID: <loom.20111013T134405-495@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 14:18:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REKEf-000232-Uw
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 14:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042Ab1JMMPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 08:15:10 -0400
Received: from lo.gmane.org ([80.91.229.12]:57129 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384Ab1JMMPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 08:15:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1REKBm-0000T6-JP
	for git@vger.kernel.org; Thu, 13 Oct 2011 14:15:06 +0200
Received: from nat-dem.mentorg.com ([195.212.93.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 14:15:06 +0200
Received: from ediap by nat-dem.mentorg.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 14:15:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 195.212.93.2 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.835.202 Safari/535.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183471>

Hi,

In the middle of "git rebase --continue" process I hit Ctrl+C today to break
this operation. When I tried to replay the same command it errors out with the 
following problem:

ediap@stsrdt1:src/toolfiles: git rebase --continue
Rebasing (2/3)

[Ctrl+C was hit here]

ediap@stsrdt1:src/toolfiles: git rebase --continue
/project/dfttools/libexec/git-core/git-rebase--interactive: line 650: 
/home/ediap/project.git/.git/rebase-merge/author-script: No such file or 
directory

Is this an expected behavior?

Thanks,
/Adam
