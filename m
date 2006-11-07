X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: If merging that is really fast forwarding creates new commit
 [Was: Re: how to show log for only one branch]
Date: Tue, 07 Nov 2006 15:59:56 +0800
Message-ID: <45503CFC.7000403@gmail.com>
References: <454EAEDB.8020909@gmail.com> <7vk629f6is.fsf@assigned-by-dhcp.cox.net> <454F31D7.1030202@gmail.com> <Pine.LNX.4.64.0611060734490.25218@g5.osdl.org> <Pine.LNX.4.64.0611060928180.3667@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 7 Nov 2006 08:01:14 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=bXOo8d5vs9xGOEcNBKK3EVWAL6aINe2Tp7aWQQxb46ow67GNRP003WjSzJ2nf6qxLZIMVVc5Hg8pjBdTvdFQVDMmyjAhfkcac/7uuaCEusC0grZZNKFvmQS/ID8tXl4+FHOrU4KygxJQH0XUeuenOzj8x70VYWQq+APjLreX9zA=
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.7) Gecko/20060909 Thunderbird/1.5.0.7 Mnenhy/0.7.4.666
In-Reply-To: <Pine.LNX.4.64.0611060928180.3667@g5.osdl.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31051>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhLtN-000766-FO for gcvg-git@gmane.org; Tue, 07 Nov
 2006 09:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754095AbWKGIBE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 03:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754097AbWKGIBE
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 03:01:04 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:14358 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1754095AbWKGIBB
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 03:01:01 -0500
Received: by py-out-1112.google.com with SMTP id a73so1209928pye for
 <git@vger.kernel.org>; Tue, 07 Nov 2006 00:01:01 -0800 (PST)
Received: by 10.35.76.10 with SMTP id d10mr2549420pyl.1162886460411; Tue, 07
 Nov 2006 00:01:00 -0800 (PST)
Received: from ?192.168.88.85? ( [221.122.47.70]) by mx.google.com with ESMTP
 id f77sm6244209pyh.2006.11.07.00.00.57; Tue, 07 Nov 2006 00:00:59 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 6 Nov 2006, Linus Torvalds wrote:
>> Besides, doing an empty commit like that ("I fast forwarded") literally 
>> doesn't add any true history information. It literally views history not 
>> as history of the _project_, but as the history of just one of the 
>> repositories. And that's wrong.
>>
>> So just get used to it. You MUST NOT do what you want to do. It's stupid.
> 
> Btw, absolutely the _only_ reason people seem to want to do this is 
> because they want to "pee in the snow" and put their mark on things. They 
> seem to want to show "_I_ did this", even if the "doing" was a total 
> no-op and they didn't actually generate any real value.

We can kick out fake commits when calculate credits, we can grep logs with
author name to see what he/she has done.

Fake commit is only for digging branch scope history, I can *outline* what has
been merged to a branch and don't care about how these good work are done on 
earth.

> 
> That's absolutely the last thing you want to encourage, especially when 
> the end result is a history that is totally unreadable and contains more 
> "junk" than actual real work. 
> 
> I'll be the first to say that "merging code" is often as important as 
> actually writing the code in the first place, and that it is important to 
> show who actually did real work to make a patch appear in a project.
> 
> In the kernel, for example, we have "sign-off" lines to show what route a 
> patch took before it was accepted, and it's very instructive to see (for 
> example) how man patches give credit to somebody like Andrew Morton for 
> passing it on versus actually writing the code himself (he has a lot of 
> authorship credit too, but it's absolutely _dwarfed_ by his importance as 
> a maintainer - and if you were to ask any random kernel developer why 
> Andrew is so important, I can pretty much guarantee that his importance is 
> very much about those "sign-offs", and not about the patches he authors).
> 
> But at the same time, when it comes to merging, because it actually 
> clutters up history a lot, we actively try to _avoid_ it. Many subsystem 
> maintainers purposefully re-generate a linear history, rebased on top of 
> my current kernel, exactly because it makes the history less "branchy", 
> and because that makes things easier to see.
> 
> So we have actually done work to _encourage_ fast-forwarding over "merge 
> with a commit", because the fast-forwarding ends up generating a much more 
> readable and understandable history. Generating a _fake_ "merge commit" 
> would be absolutely and utterly horrible. It gives fake credit for work 
> that wasn't real work, and it makes history uglier and harder to read. 
> 
> So it's a real NEGATIVE thing to have, and you should run away from it as 
> fast as humanly possible.
> 
> Now, the kernel actually ends up being fairly branchy anyway, but that's 
> simply because we actually have a lot of real parallel development (I bet 
> more than almost any other project out there - we simply have more commits 
> done by more people than most projects). I tend to do multiple merges a 
> day, so even though people linearize their history individually, you end 
> up seeing a fair amount of merges. But we'd have a lot _more_ of them if 
> people didn't try to keep history clean.

That's right the central semantics I have said, git tends to and recommends
a trunk mode development *on a high level*. It's not a bad thing.

> 
> Btw, in the absense of a merge, you can still tell who committed 
> something, exactly because git keeps track of "committer" information in 
> addition to "authorship" information. I don't understand why other 
> distributed environments don't seem to do this - because separating out 
> who committed something (and when) from who authored it (and when) is 
> actually really really important.

Yes, agree.

> 
> And that's not just because we use patches and other SCM's than just git 
> to track things (so authorship and committing really are totally separate 
> issues), but because even if the author and committer is the same person, 
> it's very instructive to realize that it might have been moved around in 
> history, so it might actually have been cherry-picked later, and the 
> committer date differs from the author date even if the actual author and 
> committer are the same person (but you might also have had somebody _else_ 
> re-linearize or otherwise cherry-pick the history: again, it's important 
> to show the committer _separately_ both as a person and as a date).
> 
> And because there is a committer field, if you actually want to linearize 
> or log things by who _committed_ stuff, you can. Just do
> 
> 	git log --committer=torvalds
> 
 > on the kernel, and you can see the log as it pertains for what _I_
 > committed, for example. You can even show it graphically, although it
 > won't be a connected graph any more, so it will tend to be very ugly
 > (but you'll see the "linear stretches" when somebody did some work). Just
 > do "gitk --committer=myname" to see in your own project.
 >
 > 		Linus

I want to separate a branch, not to separate commits by some author, for 
example, many authors can contribute to git's master branch, I want to
know what happened in the master branch like this:
      good work from A;
      good work from C;
      merge from next;   -----> I don't care how this feature is realized.
      good work from A;
      ....

As Junio points out, HEAD^1 is not always the tip of working branch,
so "git log" can't never satisfy me. There is reflog, but it's not public.

BTW: I have a great respect for any man who contributes to Linux and GIT,
especially you:-)

