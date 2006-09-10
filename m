From: "Anand Kumria" <wildfire@progsoc.org>
Subject: Re: Change set based shallow clone
Date: Sun, 10 Sep 2006 23:20:24 +0000 (UTC)
Message-ID: <ee26jo$jqp$1@sea.gmane.org>
References: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com>
	<edpuut$dns$1@sea.gmane.org>
	<9e4733910609071341u7e430214j71ddcbefa26810ca@mail.gmail.com>
	<7vlkovtjd1.fsf@assigned-by-dhcp.cox.net>
	<9e4733910609071609o50e5dacm53323e023e90358f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-From: git-owner@vger.kernel.org Mon Sep 11 01:20:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMYbX-0000aw-7U
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 01:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWIJXUi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 19:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWIJXUi
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 19:20:38 -0400
Received: from main.gmane.org ([80.91.229.2]:54227 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964813AbWIJXUh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Sep 2006 19:20:37 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GMYbM-0000XN-PP
	for git@vger.kernel.org; Mon, 11 Sep 2006 01:20:36 +0200
Received: from 88-111-195-250.dynamic.dsl.as9105.com ([88.111.195.250])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Sep 2006 01:20:36 +0200
Received: from wildfire by 88-111-195-250.dynamic.dsl.as9105.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Sep 2006 01:20:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 88-111-195-250.dynamic.dsl.as9105.com
User-Agent: pan 0.106 (Dum Maro Dum)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26821>

On Thu, 07 Sep 2006 19:09:21 -0400, Jon Smirl wrote:

> On 9/7/06, Junio C Hamano <junkio@cox.net> wrote:
>> "Jon Smirl" <jonsmirl@gmail.com> writes:
>>
>> > Does an average user do these things? The shallow clone is there to
>> > address the casual user who gags at a five hour download to get an
>> > initial check out Mozilla when they want to make a five line change or
>> > just browse the source for a few minutes.
>> >...
>> > Maybe the answer is to build a shallow clone tool for casual use, and
>> > then if you try to run anything too complex on it git just tells you
>> > that you have to download the entire tree.
>>
>> For that kind of thing, "git-tar-tree --remote" would suffice I
>> would imagine.  The five line change can be tracked locally by
>> creating an initial commit from the tar-tree extract; such a
>> casual user will not be pushing or asking to pull but sending in
>> patches to upstream, no?
> 
> From my observation the casual user does something like this:
> 
> get a shallow clone

This could basically be something which look at the remote HEAD and pulls
down a copy of that commit/tree (and associated objects), right?

> look at it for a while
> pull once a day to keep it up to date

Same again.

> decide to make some changes
> start a local branch
> commit changes on local branch
> 
> push these changes to someone else for review
> maybe pull changes on the branch back from the other person

[...]

At what point, if any, do you envisage a casual user pulling down a full
copy of the repository?

Cheers,
Anand
