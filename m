From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] New git-seek command with documentation and test.
Date: Fri, 24 Feb 2006 11:11:48 +0100
Message-ID: <43FEDBE4.8040200@op5.se>
References: <20060224002915.17331.qmail@science.horizon.com> <43FEAD62.6050302@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux@horizon.com, cworth@cworth.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 11:12:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCZvx-0007oi-Is
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 11:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWBXKLu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 05:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWBXKLu
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 05:11:50 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:22675 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932187AbWBXKLt
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 05:11:49 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 6A9936BD0A; Fri, 24 Feb 2006 11:11:48 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43FEAD62.6050302@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16691>

H. Peter Anvin wrote:
> linux@horizon.com wrote:
> 
>> The annoying thing about temporary branch names like "bisect" and "seek"
>> is that:
>> a) They clutter up the nae space available to the repository user.
>>    Users have to know that those are reserved names.
>> b) If a repository is cloned while they're in use, they might get
>>    into a "remotes" file, with even more confusing results.
>>
>> This is somewhat heretical, but how about making a truly unnamed 
>> branch by
>> having .git/HEAD *not* be a symlink, but rather hold a commit ID 
>> directly?
>> It's already well established that files in the .git directory directly
>> are strictly local to this working directory, so it seems a much better
>> home for such temporary state.
>>
> 
> It might be easier to just reserve part of the namespace, e.g. ".bisect" 
> and ".seek" instead.
> 

Ach, no. Not specific names. ^\.-.* would be acceptable, but I sometimes 
use '.name' or '-name' to mark a temporary branch. Making .- or some 
such reserved would perhaps make sense, but not with specific names.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
