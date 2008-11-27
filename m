From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-svn and svn branches
Date: Thu, 27 Nov 2008 11:02:42 +0100
Message-ID: <492E7042.1060800@drmicha.warpmail.net>
References: <20081121195835.GA12141@athena.lan> <20081125230823.GA6664@mayonaise>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ryan Phillips <ryan@trolocsis.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Nov 27 11:04:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5dj9-0004BR-4y
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 11:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730AbYK0KCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 05:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbYK0KCq
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 05:02:46 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43977 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752687AbYK0KCp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Nov 2008 05:02:45 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 1089E1C60B5;
	Thu, 27 Nov 2008 05:02:45 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 27 Nov 2008 05:02:45 -0500
X-Sasl-enc: 3oaOvAp5Pjxmf2Cey3ncv8tAUbLMNFHqOd2TdQXhzfPD 1227780164
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5F4A2B022;
	Thu, 27 Nov 2008 05:02:44 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <20081125230823.GA6664@mayonaise>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101807>

Eric Wong venit, vidit, dixit 26.11.2008 00:08:
> Ryan Phillips <ryan@trolocsis.com> wrote:
>> I followed the following instructions on adding a remote svn branch to my
>> local git-svn repository. http://www.dmo.ca/blog/20070608113513
>>
>> Are these still accurate?
>>
>> I started the repository with
>>   # git svn init [url/trunk]`
>>   # cd project.git
>>   # git svn fetch -r[HEAD revision]
>> which works fine. I added something like Snippet 1 to the .git/config and
>> issued a `git svn fetch -r[HEAD revision of the branch]` and nothing
>> happens. It takes git-svn a few seconds to run, but the git-remote svn
>> branch doesn't get initialized.
>>
>> Does this procedure only work with a full mirror of a git-svn repository?
>> or perhaps I'm doing something wrong. Any help would be appreciated.
>>
>> Thanks,
>> Ryan
>>
>> Snippet 1
>> =========
>>
>> [svn-remote "svn34"]
>> url = svn+ssh://your-server/home/svn/project-name/branches/3.4.x
>> fetch = :refs/remotes/git-svn-3.4
> 
> Try this:
> 
>   git svn fetch -i svn34
> 
> It's been a while since I've used this, but I believe a test
> case covers it so it probably still works :)
> 

Uhm, I think it's rather "-R svn34" which tells git-svn to use the svn
remote config "svn34". -i sets GIT_SVN_ID.

Michael
