From: Adam Roben <aroben@apple.com>
Subject: Re: Trivial patch to git-svn
Date: Sat, 17 Nov 2007 13:26:13 -0800
Message-ID: <473F5C75.3040707@apple.com>
References: <473A1D9F.4030103@facebook.com> <20071117211253.GB31598@mayonaise>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: David Reiss <dreiss@facebook.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Nov 17 22:26:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItVBP-0005DN-2t
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 22:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbXKQV0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 16:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752129AbXKQV0O
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 16:26:14 -0500
Received: from mail-out3.apple.com ([17.254.13.22]:61516 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbXKQV0O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 16:26:14 -0500
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out3.apple.com (Postfix) with ESMTP id AF8A918DA6EB
	for <git@vger.kernel.org>; Sat, 17 Nov 2007 13:26:13 -0800 (PST)
Received: from relay13.apple.com (unknown [127.0.0.1])
	by relay13.apple.com (Symantec Mail Security) with ESMTP id 9856628052
	for <git@vger.kernel.org>; Sat, 17 Nov 2007 13:26:13 -0800 (PST)
X-AuditID: 1180711d-a1ac0bb0000008bf-80-473f5c75ab3f
Received: from elliott.apple.com (elliott.apple.com [17.151.62.13])
	by relay13.apple.com (Apple SCV relay) with ESMTP id 791F42804F
	for <git@vger.kernel.org>; Sat, 17 Nov 2007 13:26:13 -0800 (PST)
Received: from [17.151.89.225] by elliott.apple.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPSA id <0JRO00IRL67PK070@elliott.apple.com> for git@vger.kernel.org;
 Sat, 17 Nov 2007 13:26:13 -0800 (PST)
In-reply-to: <20071117211253.GB31598@mayonaise>
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65312>

Eric Wong wrote:
> David Reiss <dreiss@facebook.com> wrote:
>   
>> From d9f93dc1c503c5f42b27485b2c35b38e8c9bca44 Mon Sep 17 00:00:00 2001
>> From: David Reiss <dreiss@dreiss-vmware.(none)>
>> Date: Tue, 13 Nov 2007 13:47:26 -0800
>> Subject: [PATCH] Fix a typo and add a comma in an error message in git-svn
>>
>> Signed-off-by: David Reiss <dreiss@facebook.com>
>> ---
>>  git-svn.perl |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/git-svn.perl b/git-svn.perl
>> index e3e00fd..981cdd6 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -391,7 +391,7 @@ sub cmd_set_tree {
>>  sub cmd_dcommit {
>>  	my $head = shift;
>>  	git_cmd_try { command_oneline(qw/diff-index --quiet HEAD/) }
>> -		'Cannot dcommit with a dirty index.  Commit your changes 
>> first'
>> +		'Cannot dcommit with a dirty index.  Commit your changes 
>> first, '
>>  		. "or stash them with `git stash'.\n";
>>  	$head ||= 'HEAD';
>>  	my @refs;
>>     
>
> I am not an English expert, but both seem acceptable to me.  Anybody else
> agree/disagree?
>   

I don't think the comma matters very much, but having a space between 
"first" and "or" is pretty important. :-)

-Adam
