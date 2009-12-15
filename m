From: Sam Elliott <sam@lenary.co.uk>
Subject: New Proposal (simple) for Metadata in Git Commits: git-meta
Date: Tue, 15 Dec 2009 22:27:03 +0100
Message-ID: <93857A5A-744E-4A7C-B42D-23A56A48AAF7@lenary.co.uk>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 22:27:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKevP-0003fT-84
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 22:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694AbZLOV1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 16:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbZLOV1N
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 16:27:13 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:59317 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932672AbZLOV1M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 16:27:12 -0500
Received: by bwz27 with SMTP id 27so305246bwz.21
        for <git@vger.kernel.org>; Tue, 15 Dec 2009 13:27:07 -0800 (PST)
Received: by 10.204.48.144 with SMTP id r16mr35579bkf.170.1260912426952;
        Tue, 15 Dec 2009 13:27:06 -0800 (PST)
Received: from ?192.168.2.103? (pD95ECCB1.dip.t-dialin.net [217.94.204.177])
        by mx.google.com with ESMTPS id 14sm82448bwz.1.2009.12.15.13.27.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 15 Dec 2009 13:27:06 -0800 (PST)
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135301>

Hi,

I had this idea a day or so again, and have written a simple  
implementation to storing some semi-structured data in a git commit  
message. This means that it's much easier for data to be found and  
scraped from a certain commit, for instance what issue numbers commits  
refer to or close.

The entirety of the idea is expressed here: http://lenary.github.com/hackery/2009/12/git-meta/

I have so far built an implementation of a way to get the data out of  
a commit. I am still investigating how to get this info into the  
commit message before the git-commit command so that it doesn't have  
to be entirely hand-written.

I was just looking for feedback and to see whether the mailing list  
thinks this is a good idea or not? Any help would also be greatly  
appreciated.

Thanks!

Sam
--
Sam Elliott
sam@lenary.co.uk
--
