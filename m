From: Miles Bader <miles@gnu.org>
Subject: Re: way to automatically add untracked files?
Date: Sun, 05 Aug 2007 13:53:40 +0900
Message-ID: <874pjelgyz.fsf@catnip.gol.com>
References: <873ayymzc1.fsf@catnip.gol.com>
	<fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com>
	<20070805041320.GH9527@spearce.org> <87lkcqlif2.fsf@catnip.gol.com>
	<7v8x8qip7n.fsf@assigned-by-dhcp.cox.net>
	<87d4y2li2c.fsf@catnip.gol.com>
	<7v4pjeioi6.fsf@assigned-by-dhcp.cox.net>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 06:53:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHY7K-0003pp-Ir
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 06:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbXHEExX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 00:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbXHEExX
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 00:53:23 -0400
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:56603 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbXHEExW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 00:53:22 -0400
Received: from 203-216-96-074.dsl.gol.ne.jp ([203.216.96.74] helo=catnip.gol.com)
	by smtp02.dentaku.gol.com with esmtpa (Dentaku)
	id 1IHY7F-0005Qm-Bl; Sun, 05 Aug 2007 13:53:21 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id A07EE300F; Sun,  5 Aug 2007 13:53:40 +0900 (JST)
System-Type: i686-pc-linux-gnu
In-Reply-To: <7v4pjeioi6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sat\, 04 Aug 2007 21\:39\:13 -0700")
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54944>

Junio C Hamano <gitster@pobox.com> writes:
> You get into an illusion that that is often used, only when you have
> just started.  As your project progresses, that feeling will fade
> away.

I imagine this depends strongly on the nature of the project.

My current comments stem from using git a personal project which I've
been working on for about 2 years; maybe I'm weird, but I seem to
add/remove files fairly regularly (as far as I can tell, it's not an
illusion :-).

> And that is natural, if you think about it for 5 seconds.
...
> You _could_ argue that people should be more disciplined and
> write perfect .gitignore files so that "git add ." is always
> safe, but the world does not work that way.

Sigh.  There are all sorts of people using git, and everybody has their
own working style.  My personal style involves keeping .gitignore
up-to-date so that there's no cruft in the git-status output.

Anyway, I wouldn't be complaining except that I _keep_ running into
circumstances where I need to type "git-add NEWFILE1 NEWFILE2
NEWFILE3...; git rm OLD_FILE1..." -- which is kind of annoying after
seeing a list of _exactly_ the files I need to add/remove output just
previously by git-status.  Thus my wish to have git "do it
automatically."

"git-add -u; git-add ." seems like it should do the job though.

Thanks,

-Miles

-- 
We live, as we dream -- alone....
