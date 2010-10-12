From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
Subject: Re: git ls-files handles paths differently in Windows and Mac (probably Linux)
Date: Tue, 12 Oct 2010 17:52:30 +0400
Message-ID: <38052CF8-66F3-40FD-8D2D-8FD58A622F7B@jetbrains.com>
References: <3C33A244-2449-4A3C-A8B5-2060CE61EE04@jetbrains.com> <AANLkTimB6s_yt6L59xpqsWO_yBsZxuVCiExFoSm9FcN1@mail.gmail.com> <C29949EA-5717-4BA3-936E-354FCB107877@jetbrains.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 15:52:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5fHW-0005KG-Nk
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 15:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418Ab0JLNwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 09:52:36 -0400
Received: from mail.intellij.net ([213.182.181.98]:33741 "EHLO
	mail.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932319Ab0JLNwf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 09:52:35 -0400
Received: (qmail 17132 invoked by uid 89); 12 Oct 2010 13:52:33 -0000
Received: by simscan 1.1.0 ppid: 17088, pid: 17123, t: 0.0139s
         scanners: regex: 1.1.0 clamav: 0.96
/m: 52
Received: from unknown (HELO loki-mac-pro.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@172.26.240.110)
  by mail.intellij.net with ESMTPA; 12 Oct 2010 13:52:33 -0000
In-Reply-To: <C29949EA-5717-4BA3-936E-354FCB107877@jetbrains.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158848>


>>> I want to see which files were changed in the specific directory of my working tree, so I call ls-files:
>>>> git ls-files -douvm --exclude-standard -- MYDIR
>>> 
>> 
>> Well, it is an... unconventional way to do that. May I suggest you consider
>> using "git diff --name-status" or just "git status" next time?
> 
> My tests show that "git ls-files -douvm" is faster than "git diff --name-status".
> 
> "git status" doesn't fit, because it's porcelain (btw, git diff is also porcelain) and its output may change in time;
> "git status --porcelain" appeared only in 1.7.0, so I can't use it to work with older Git.
> 


And also "git diff --name-status" doesn't show unversioned files.
As I've found, "git ls-files" is the only command which shows unversioned files (except git status), isn't it?



----------------------------------
Kirill Likhodedov
JetBrains, Inc
http://www.jetbrains.com
"Develop with pleasure!"
