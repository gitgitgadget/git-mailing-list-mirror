From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 16:46:00 +0000
Message-ID: <fiet88$68n$1@ger.gmane.org>
References: <200711252248.27904.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 17:47:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwh7b-00053N-K1
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 17:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757321AbXKZQqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 11:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757305AbXKZQqa
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 11:46:30 -0500
Received: from main.gmane.org ([80.91.229.2]:35671 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757277AbXKZQq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 11:46:28 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Iwh6E-0003qx-5o
	for git@vger.kernel.org; Mon, 26 Nov 2007 16:46:22 +0000
Received: from 194.70.53.227 ([194.70.53.227])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Nov 2007 16:46:22 +0000
Received: from andyparkins by 194.70.53.227 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Nov 2007 16:46:22 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 194.70.53.227
User-Agent: KNode/0.10.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66080>

Jakub Narebski wrote:

> If you would write git from scratch now, from the beginning, without
> concerns for backwards compatibility, what would you change, or what
> would you want to have changed?

Erm... (it's much harder to come with lists like these lately :-))

 - "index", "cached" and "stage" are a definite source of confusion
 - "git add" and "git rm" would be nicer as "git stage" and "git unstage"
   (or something similar)
 - libgit would have come first
 - "git revert" should be called "git invert"
 - "git revert" would (maybe) be "git reset"
 - "git clone" wouldn't exist
 - "git-gui" would be written in Qt (ducks)
 - git-apply et al wouldn't be a disaster when the log message contains a   
   diff (change to git diff format?)
 - empty directories in the repository (ducks again)



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
