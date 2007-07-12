From: Fredrik Tolf <fredrik@dolda2000.com>
Subject: Re: Volume of commits
Date: Thu, 12 Jul 2007 16:51:44 +0200
Message-ID: <m3ir8pu133.fsf@pc7.dolda2000.com>
References: <m3ps2xu5hc.fsf@pc7.dolda2000.com> <20070712140304.GB28310@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 16:52:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I901d-00083b-R4
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 16:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755248AbXGLOwF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 12 Jul 2007 10:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755239AbXGLOwE
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 10:52:04 -0400
Received: from main.gmane.org ([80.91.229.2]:34087 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754013AbXGLOwD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 10:52:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I901N-0006fw-1i
	for git@vger.kernel.org; Thu, 12 Jul 2007 16:51:57 +0200
Received: from 1-1-3-7a.rny.sth.bostream.se ([82.182.133.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 16:51:57 +0200
Received: from fredrik by 1-1-3-7a.rny.sth.bostream.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 16:51:57 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 1-1-3-7a.rny.sth.bostream.se
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:LF+KUGd8a8HMZbn6oV+t0QTqJ9k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52294>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2007-07-12 15:16:47 +0200, Fredrik Tolf wrote:
>
>> Or do you somehow aggregate the smaller commits into larger patches
>> and recommit them? Or is there some third possibility that I'm
>> missing?
>
> Aggregating commits and recommitting is easy, so that's a common tool=
,
> I'd say. But it's equally possible to take a large commit and pick it
> apart, for example by editing the patch by hand and reapplying it, or
> by using the hunk selection feature of git-gui.

I see. Initially, it sounds like a lot of work, but the more I think
about it, the more I realize that it probably isn't that bad.

> [...]
> If you need to edit a commit that isn't HEAD, you can use git-reset t=
o
> go back to the commit you want to edit, do the editing, and then use
> git-rebase to reapply the other commits on top of the changed commit.

git-rebase is one of those tools I haven't been looking at so far (I'm
still rather new to Git), so I should probably read through its
manpage.

> In general, there are a thousand ways to use git to rewrite history,
> either "by hand" or by using tools such as StGIT. (StGIT is what I
> personally use most of the time. I find it a good tool for producing
> readable patch series.)

I hadn't heard of StGIT, but it looks interesting.

Thanks for all the suggestions! I'll be needing some time to look them
through. :)

=46redrik Tolf
