From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 18:05:39 +0200
Message-ID: <200610201805.40235.jnareb@gmail.com>
References: <aaron.bentley@utoronto.ca> <200610201728.13327.jnareb@gmail.com> <Pine.LNX.4.63.0610201736440.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Fri Oct 20 18:06:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GawsW-0000hR-4e
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 18:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWJTQFk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 12:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWJTQFk
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 12:05:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:2197 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932246AbWJTQFh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 12:05:37 -0400
Received: by ug-out-1314.google.com with SMTP id z34so661739ugc
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 09:05:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CMfcEHtelv7R1uNqkSXUBexwXBQMI3/1u5kRPUvRNVrOvKVQJWu9mF49ohbvsig90ZSiijXqGrO0QYkCYVfCLG4qBuPHBTB6MH5DhOTy2R56oJ48eD3qyUv9oJD7jfBKTNWWkxUPY5KWRm6e0c6StiRVwEKmhibAKHfJWu5WakM=
Received: by 10.66.224.19 with SMTP id w19mr2145855ugg;
        Fri, 20 Oct 2006 09:05:36 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id s1sm1565200uge.2006.10.20.09.05.35;
        Fri, 20 Oct 2006 09:05:35 -0700 (PDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0610201736440.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29499>

Johannes Schindelin wrote:
> On Fri, 20 Oct 2006, Jakub Narebski wrote:
>> Johannes Schindelin wrote:
>>> On Fri, 20 Oct 2006, Jakub Narebski wrote:
>>> 
>>>> Christian MICHON wrote:
>>>> 
>>>>> - git is the fastest scm around
>>>> 
>>>> Mercurial also claims that.
>>> 
>>> Funny. When you type in "mercurial" and "benchmark" into Google, the 
>>> _first_ hit is into "git Archives: Mercurial 0.4b vs git patchbomb 
>>> benchmark". Performed by the good Mercurial people.
>>> 
>>> Leaving git as winner.
>>  
>> Check out http://git.or.cz/gitwiki/GitBenchmarks section "Quilt import 
>> comparison of Git and Mercurial" for the latest (OLS2006) benchmark
>> by Mercurial.
> 
> Thanks for the hint!
> 
> BTW the tests in Clone/status/pull make sense, especially the "4 times 
> slower on pull/merge". In my tests, merge-recur (the default merge 
> strategy, which was written in Python, and is now in C) was substantially 
> faster.

As it was mentioned somewhere else in this thread, to compare times
for pull/merge in git with other SCM one should in principle substract
time for diffstat/git diff --stat.

-- 
Jakub Narebski
Poland
