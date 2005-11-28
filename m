From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: lost again on syntax change - local repository?
Date: 28 Nov 2005 05:04:40 -0800
Message-ID: <86hd9w7wk7.fsf@blue.stonehenge.com>
References: <861x118r9t.fsf@blue.stonehenge.com>
	<7v7jat2w6u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 14:05:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgigX-0006hS-Mt
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 14:04:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVK1NEn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 08:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbVK1NEn
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 08:04:43 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:56367 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932077AbVK1NEm
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 08:04:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id EB89D8F71C;
	Mon, 28 Nov 2005 05:04:41 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 24061-03-86; Mon, 28 Nov 2005 05:04:41 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 4AA8D8F790; Mon, 28 Nov 2005 05:04:41 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.12.15.0; tzolkin = 11 Ahau; haab = 18 Ceh
In-Reply-To: <7v7jat2w6u.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12874>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> If it is not absolutely necessary that you need to use Cogito,
Junio> IOW, if git barebone Porcelains are good enough for your use,
Junio> the following may be adequate.

Well, then, you should get rid of cogito/Documentation/introduction.html,
if you don't plan on supporting the interfaces described there.

I'm really just starting out. I see that tutorial, and I want to do it.

Junio> 	$ echo >.git/remotes/origin <<EOF
Junio> 	URL: /path/to/remote.git/
Junio>         Push: master
Junio>         Pull: master:origin
Junio>         EOF

Ugh, ugh ugh ugh.

Junio> 	$ git push origin

Junio> I said "may be" because I do not understand the sequence before
Junio> "At this point"; how your local.git is initially set up to
Junio> relate to the remoge.git.  I do not see local.git being created
Junio> by cloning remote.git.

I can't, because I have to do the first push.  This is what I was told
last time!

I'm doing what I'm told, and now more things are breaking.  This is
frustrating.

I'm not saying that you guys aren't doing a hell of a job.  I'm just
coming at this from a user's perspective, and trying to describe it to
others.  I'm not comfortable yet, because every time I try to do what
the manuals say, it breaks.  Perhaps y'all are secretly working around
every broken thing, but I don't know enough to do that.

Junio>   But modulo that the above should work
Junio> fine; I do that as a cheap backup on my local machine.

So, give me the exact steps, using "cg" to:

        create a "remote" repo on my disk
        create a "local" repo on my disk
        set up the linkage between remote and local
        push from local to remote
        pull from remote to local

And if it ever needs a command like "cat" or "echo", something is
wrong.  I'll accept a "git-" command for one or two of the steps, but
that feels like dropping into assembler instead of C.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
