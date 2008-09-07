From: david@lang.hm
Subject: Re: rsync vs. git-push/pull ? (+kudus)
Date: Sat, 6 Sep 2008 23:27:39 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0809062326000.8096@asgard.lang.hm>
References: <dfb262380809062311i3fffb900m5d73f5396b403dbe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Ramagudi Naziir <naziirr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 08:27:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcDkV-0006ly-Gf
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 08:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbYIGG0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 02:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbYIGG0o
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 02:26:44 -0400
Received: from mail.lang.hm ([64.81.33.126]:40489 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751587AbYIGG0o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 02:26:44 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m876QgbA016347;
	Sat, 6 Sep 2008 23:26:42 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <dfb262380809062311i3fffb900m5d73f5396b403dbe@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95120>

On Sun, 7 Sep 2008, Ramagudi Naziir wrote:

> Hi all,
>
> I have several local git repositories on my machine. I'm the only
> user, and use them only locally. Now, sometimes when I need to work
> remotely, I just rsync my repositories to my laptop, and keep working
> there. When I finish (few hours, days or sometimes weeks later), I
> just rsync everything back to my local git repositories on my main
> workstation, and continue working there.
>
> Now I was wondering whether it's OK or whether there are bad
> implication I might not think of working this way. For example, maybe
> some of these little git files are named differently on each machine,
> and rsyncing them back and forth makes me piling a lot of clutter (in
> that case maybe git-gc will clean up everything). Or maybe something
> else horrid is going on and I really should just use git-push or pull.

the git files are names by their content so you don't need to worry about 
them being named differently

> I really prefer rsync to git-push/pull since it is much more easier -
> It's one command that syncs my whole working folder, including the git
> repositories..

the problems you can run into with rsync all end up related to one of two 
things.

1. what happens if the sync gets interrupted

2. what happens if the source gets updated during the sync

in your case these cannot happen without you knowing it, so you should be 
ok.

David Lang
