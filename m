From: David Lang <dlang@digitalinsight.com>
Subject: Re: VCS comparison table
Date: Tue, 24 Oct 2006 08:58:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0610240853160.10841@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>  <453A7D7E.8060105@utoronto.ca>
  <20061022074513.GF29927@artax.karlin.mff.cuni.cz>  <200610221105.26421.jnareb@gmail.com>
  <845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com> 
 <87zmbozau2.wl%cworth@cworth.org> <20061022185350.GW75501@over-yonder.net>
  <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org>  <20061023222131.GB17019@over-yonder.net>
  <Pine.LNX.4.64.0610231534010.3962@g5.osdl.org> <20061024002622.GC17019@over-yonder.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@osdl.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 18:01:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcOhc-0003ZG-Iu
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 18:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbWJXQA3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 12:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbWJXQA3
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 12:00:29 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:52407 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S965165AbWJXQA2
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 12:00:28 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Tue, 24 Oct 2006 09:00:28 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Tue, 24 Oct 2006 08:59:58 -0700
X-X-Sender: dlang@dlang.diginsite.com
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
In-Reply-To: <20061024002622.GC17019@over-yonder.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29985>

On Mon, 23 Oct 2006, Matthew D. Fuller wrote:

> But I don't understand how bzr-the-abstract-data-model makes such
> things impossible, or even significantly different than doing so in
> git.  In git, you're just chopping off one DAG where another one
> intersects it (or similar operations).  To do it in bzr, you'd do...
> exactly the same thing.  The revnos, or the mainline, are completely
> useless in such an operation of course, but they don't hurt it; the
> tool would just just ignore them like it does the SHA-1 of files in
> the revision.

one key difference is that with bzr you have to do this chopping by creating the 
branches at the time changes are done, with git you do this chopping after the 
fact when you are displaying the results.

As such you can chop and compare things in ways that were never contemplated by 
anyone at the time changes are made.

>
>> See? When you visualize multiple branches together, HAVING
>> PER-BRANCH REVISION NUMBERS IS INSANE! Yet, clearly, it's a valid
>> and interesting operation to do.
>
> I wouldn't be so absolutist about it, but certainly they're of
> extremely limited utility if of any at all in such cases.  And yes, it
> can be an interesting operation.  But what does that have to do with
> using revnos in other cases?  You keep saying "having" where I would
> say "using".

and the bzr tools strongly encourage the use of these numbers

> I care about that first parent line.  Therefore, I require my tool to
> at least _pretend_ to care.  I'm not aware of any way in which the
> fundamental bzr structures care, but the UI is chock full of
> pretending.  A necessary part of that pretending is not changing my
> mainline unless I specifically ask for it, and that means a
> merge-vs-pull distinction needs to be there.  That's a _technical_
> sign that the tool is ready to work with me the way I want to work.  A
> lack of it is a _technical_ sign that it's not suitable.

nobody is saying that the bzr approach is invalid for your workflow.

what people are saying is that it doesn't easily support a truely distributed 
workflow. this is a very different statement.

your workflow isn't truely distributed so you bzr's model works well for you. no 
problem, just don't claim that becouse you haven't run into any problems with 
your workflow that there are no problems with bzr with other workflows.

David Lang
