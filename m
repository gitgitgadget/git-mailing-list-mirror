Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2D71802E
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 19:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 658C7D5D
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 12:46:37 -0700 (PDT)
Received: from [192.168.5.3] (c-73-70-62-113.hsd1.ca.comcast.net [73.70.62.113])
	(authenticated bits=0)
	by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 39KJkbFG080391
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 12:46:37 -0700 (PDT)
	(envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-70-62-113.hsd1.ca.comcast.net [73.70.62.113] claimed to be [192.168.5.3]
Message-ID: <dd4befe1-dea7-b27d-720d-9f1616b129ee@tsoft.com>
Date: Fri, 20 Oct 2023 12:46:35 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Git Mailing List <git@vger.kernel.org>
From: Yuri <yuri@rawbw.com>
Subject: Why sometimes branch merging is associated with this commit: Merge
 remote-tracking branch 'remotes/p4/HEAD'
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I use git-p4 to use the perforce repository through git.


There are 3 branches:

* master
   remotes/p4/HEAD -> p4/master
   remotes/p4/master

git-p4 syncs remotes/p4/HEAD with the perforce repository.

Then the user (me) needs to merge remotes/p4/HEAD into master.

Initially such merge doesn't cause "Merge remote-tracking branch 
'remotes/p4/HEAD'" commits.

But then, after several cycles of submit/sync something happens, and git 
forces me to commit with the "Merge remote-tracking branch 
'remotes/p4/HEAD'" comment.


What makes the merge from remotes/p4/HEAD into master to require "Merge 
remote-tracking branch 'remotes/p4/HEAD'"?

What does this mean?

What is changed in remotes/p4/HEAD or master that later requires this?

How to eliminate the need for "Merge remote-tracking branch 
'remotes/p4/HEAD'"?



Thanks,

Yuri


