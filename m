From: Noufal Ibrahim <noufal@nibrahim.net.in>
Subject: Re: Moving commits from one branch to another (improving my git fu!)
Date: Tue, 22 Oct 2013 18:12:14 +0530
Message-ID: <87d2mx1nq1.fsf@sanitarium.localdomain>
References: <CAC+QLdSjTjftgUBy-1cHbATZnX-UO3PavUaLwErhCaxBa-hPmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mandeep Sandhu <mandeepsandhu.chd@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 22 15:18:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYbrC-0006Qc-4w
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 15:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871Ab3JVNSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 09:18:42 -0400
Received: from deleuze.hcoop.net ([69.90.123.67]:47302 "EHLO deleuze.hcoop.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752399Ab3JVNSl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 09:18:41 -0400
X-Greylist: delayed 2060 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Oct 2013 09:18:41 EDT
Received: from [123.238.85.99] (helo=localhost)
	by deleuze.hcoop.net with esmtpsa (TLS-1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <noufal@nibrahim.net.in>)
	id 1VYbJs-0000Uy-I9; Tue, 22 Oct 2013 08:44:21 -0400
In-Reply-To: <CAC+QLdSjTjftgUBy-1cHbATZnX-UO3PavUaLwErhCaxBa-hPmQ@mail.gmail.com>
	(Mandeep Sandhu's message of "Tue, 22 Oct 2013 11:08:41 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236470>

Mandeep Sandhu <mandeepsandhu.chd@gmail.com> writes:

> Hi All,
>
> I'm in a bit of a pickle! :) So I've come to ask for help from the guru's here.
>
> My story is not unique but somehow the various suggested solutions
> don't seem to work in my case.
>
> * I was working on a feature which was supposed to be done off our
> 'dev' branch. But instead I forgot and branched out my topic branch
> from master (or as we call it 'stable').
> * I did 2 commits and finished off my work. Only later realizing that
> it had to be done off 'dev'.
> * Now I want to move my 2 commits (which are the top 2 commits on my
> topic branch) to a new branch which is branched off 'dev'.

I had a situtation similar to this a while ago and used the --onto
option to rebase. The details are at 
http://nibrahim.net.in/2012/01/09/moving_topic_branches_in_git.html

[...]


-- 
Cordially,
Noufal
http://nibrahim.net.in
