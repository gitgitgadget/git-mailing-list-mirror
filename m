From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Automating svn<->git gateway
Date: Tue, 12 Oct 2010 19:35:25 +0200
Message-ID: <20101012173524.GB30870@efreet.light.src>
References: <20101011193007.GA30870@efreet.light.src>
 <AANLkTikp1e72RQs3QQTqyg2m4Vk6rjz=Sv33iHAxDKoP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joshua Shrader <jshrader83@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 19:35:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5ilC-0006kR-94
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 19:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757250Ab0JLRf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 13:35:28 -0400
Received: from cuda1.bluetone.cz ([212.158.128.5]:35191 "EHLO
	cuda1.bluetone.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673Ab0JLRf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 13:35:27 -0400
X-ASG-Debug-ID: 1286904925-5f6b38c40001-QuoKaX
Received: from efreet.light.src (152-31-80-78.praha.adsl.tmcz.cz [78.80.31.152]) by cuda1.bluetone.cz with ESMTP id oPd6u1m8rti8ZqZ7; Tue, 12 Oct 2010 19:35:25 +0200 (CEST)
X-Barracuda-Envelope-From: bulb@ucw.cz
X-Barracuda-Apparent-Source-IP: 78.80.31.152
Received: from bulb by efreet.light.src with local (Exim 4.72)
	(envelope-from <bulb@ucw.cz>)
	id 1P5il3-0002E3-0i; Tue, 12 Oct 2010 19:35:25 +0200
X-ASG-Orig-Subj: Re: Automating svn<->git gateway
Content-Disposition: inline
In-Reply-To: <AANLkTikp1e72RQs3QQTqyg2m4Vk6rjz=Sv33iHAxDKoP@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Barracuda-Connect: 152-31-80-78.praha.adsl.tmcz.cz[78.80.31.152]
X-Barracuda-Start-Time: 1286904925
X-Barracuda-URL: http://212.158.128.5:8000/cgi-mod/mark.cgi
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5000 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=4.5 KILL_LEVEL=4.8 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.43488
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158865>

On Mon, Oct 11, 2010 at 16:33:47 -0400, Joshua Shrader wrote:
> Check out the article and third-to-last comment (as of today) at
> http://blog.emmanuelbernard.com/2010/05/git-how-my-life-has-improved-since-last-month-when-i-used-svn/comment-page-1/#comment-2248
> 
> The comment (by Josh) is mine, and details how I've approached this
> problem.  It's worked very well for us, and follows from a workflow
> presented in Jon Loeliger's "Version Control with Git."  I haven't
> messed with any hooks, but I'd imagine that wouldn't be too difficult.
>  Right now, we keep a couple legacy maintenance SVN branches sync'd up
> with their corresponding Git branches.  The one thing that we haven't
> attempted (and don't plan on) is creating a new branch in Git that we
> want to duplicate in SVN.  We're only syncing branches that existed in
> SVN prior to our move to Git.  Any new branches are "Git-only."

Thanks. That's the workflow I had in mind. I already did something similar
ages ago with GNU arch and CVS, but the exact outline for git-svn will be
definitely helpful. Especially the exact order in which the merges need to be
done.

For my purpose I'll definitely need to automate it, because we often need to
see each other's changes quickly (often somebody needs a fix from somebody
else to be able to test something else or to base other changes on it). So
requiring to log in on the server and run the synchronization manually would
add too much overhead.

> On Mon, Oct 11, 2010 at 3:30 PM, Jan Hudec <bulb@ucw.cz> wrote:
> > Hello Folks,
> >
> > I want to set up a gateway between subversion and git, which would keep the
> > master synchonized with subversion trunk, both ways, and allow working with
> > any additional branches independent of subversion. For users it should behave
> > as any other shared git repository accessed by push and pull. And it needs to
> > be automatic.
> >
> > Did anybody try to set up something like this?
-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
