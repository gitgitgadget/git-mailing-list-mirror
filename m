From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: GIT vs Other: Need argument
Date: Thu, 19 Apr 2007 09:57:10 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704190954540.23289@reaper.quantumfyre.co.uk>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
 <f06d4m$3rs$1@sea.gmane.org> <4626C4B9.1040707@midwinter.com>
 <200704190408.59595.jnareb@gmail.com> <Pine.LNX.4.64.0704191043140.8822@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jakub Narebski <jnareb@gmail.com>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 19 10:57:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeSSB-0006tT-AK
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 10:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993201AbXDSI5N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 04:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161340AbXDSI5N
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 04:57:13 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:41250 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161305AbXDSI5M (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Apr 2007 04:57:12 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id C62F2C649C
	for <git@vger.kernel.org>; Thu, 19 Apr 2007 09:57:10 +0100 (BST)
Received: (qmail 6291 invoked by uid 103); 19 Apr 2007 09:56:25 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3125. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.042525 secs); 19 Apr 2007 08:56:25 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 19 Apr 2007 09:56:25 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <Pine.LNX.4.64.0704191043140.8822@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44997>

On Thu, 19 Apr 2007, Johannes Schindelin wrote:

> Hi,
>
> On Thu, 19 Apr 2007, Jakub Narebski wrote:
>
>> Steven Grimm wrote:
>>
>>> One can argue about whether allowing partial commits like that is a
>>> good idea, but it's just not true that svn forces you to always update
>>> before you commit, and if you're pushing into a branch that other
>>> people are also updating, the ability to commit files that didn't
>>> change upstream means it is actually *less* insistent on
>>> update-then-commit than git is (if you take "commit" to mean
>>> "commit-and-push" on the git side as was suggested in the message I
>>> replied to originally.)
>>>
>>> Unless, of course, I'm misinterpreting you here.
>>
>> I just think the commit _then_ merge (or commit-then-update) workflow is
>> much, much better than update-then-commit one.
>
> Let me pick up the ball here. Once you did your share of conflicting
> merges, you _will_ realize how much better it is to merge when you are at
> a relatively stable state, i.e. you can test things (if only to make sure
> that the merge did not introduce strange side effects). And guess what, at
> such a stage I would commit anyway.
>
> It is so much easier to resolve conflicts if you can look at both sides,
> and can actually go to both sides to test things out, or even just
> generate the diff to one side. This is just not possible with a dirty
> merge. Exactly because you knowingly lost the current state, you cannot do
> diffs with it.

Not only that, but there is then a _record_ that Joe Developer had to 
merge your work into his (or vice versa) ...

-- 
Julian

  ---
"MacDonald has the gift on compressing the largest amount of words into
the smallest amount of thoughts."
 		-- Winston Churchill
