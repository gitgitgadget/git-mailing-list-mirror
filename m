From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: Question about "git commit -a"
Date: Fri, 5 Oct 2007 11:06:14 +0200
Message-ID: <4d8e3fd30710050206h7a177472x7c92f91204b15aa4@mail.gmail.com>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com>
	 <545CB3B2-96B3-4853-9397-B42F4F268A15@wincent.com>
	 <fcaeb9bf0710041333l636b2c1fn4d8f3298000127c7@mail.gmail.com>
	 <Pine.LNX.4.64.0710042209410.4174@racer.site>
	 <4d8e3fd30710050139j45a5a924t5c048994e3457c5f@mail.gmail.com>
	 <4705FB52.3030208@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
	"Wincent Colaiuta" <win@wincent.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Oct 05 11:07:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idj8q-0005mF-31
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 11:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869AbXJEJGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 05:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754505AbXJEJGR
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 05:06:17 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:33198 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493AbXJEJGP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 05:06:15 -0400
Received: by nz-out-0506.google.com with SMTP id s18so387333nze
        for <git@vger.kernel.org>; Fri, 05 Oct 2007 02:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=olcOSHadx5bcKOtP4mH/2g6PFC/J0VWmfSMz72k3Kec=;
        b=icdS7SrogMunmLoCETjjvJoVYKo1l/mEIG8gLU1He2NePlWIVlX2uxC4GV1X9+jBb2aSW3OecKbE8P0KOStEO7M2gcZQO1QpaA+BDpsVdJWxE05Kfi7Pk8k7+mjZnrXAYQ0KMQNiQnMn45UOyq5/dPVzn5uK9BKW3Dz2mcSgdNU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f0WPLQMtG7YwHM6PIhU6f17ghFoys3rVR3dVfWnGNG/ddwTp8eHrdQOVtj3EdCtp0jnHEQexfhSS4JIfOSiqNmZ8z24DZ66AM03t2Qxy1amrgL9BxYzbl4jtEJziA0qteK+AidrrLKB4FPyOdsOXx6hRkpszACIZdPMIid2iNg8=
Received: by 10.142.203.13 with SMTP id a13mr1517404wfg.1191575174292;
        Fri, 05 Oct 2007 02:06:14 -0700 (PDT)
Received: by 10.143.43.21 with HTTP; Fri, 5 Oct 2007 02:06:14 -0700 (PDT)
In-Reply-To: <4705FB52.3030208@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60057>

On 10/5/07, Andreas Ericsson <ae@op5.se> wrote:
> Paolo Ciarrocchi wrote:
> > On 10/4/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >> Hi,
> >>
> >> On Fri, 5 Oct 2007, Nguyen Thai Ngoc Duy wrote:
> >>
> >>> On 10/4/07, Wincent Colaiuta <win@wincent.com> wrote:
> >>>>> Am I wrong?
> >>>> About it being a majority, yes, I suspect so.
> >>>>
> >>> Maybe in the next survey we should include question "do you usually do
> >>> 'git commit' or 'git commit -a'" :-)
> >> Not meaning to discourage you, but it is a known fact that Linus does "git
> >> commit" without "-a" quite often.
> >>
> >> And if that were not bad enough for your plan, I myself omit "-a"
> >> regularly.  So you would get a veto from me, too.
> >
> > So you are used to do something like (please correct me if I'm wrong):
> > - modify A
> > - modify B
> > - modify C
> > - modify D
> > - modify E
> >
> > $ git A B E
>
>
> This isn't really a valid command. I'm not sure where you got it from.

Doh! Don't consider it, it's just a silly copy and paste error! It has
no meaning!

> > $ git add A B E (A, B and E are now in the staging area)
> > $ git commit -m "I just modified A,B and E"
>
> I do something like that, except that for full-file commits I'd rather
> say
>
>         git commit -s A B E
>
> I never pass -m to git commit. It's too easy to get into habit of being
> sloppy with historic documentation that way.

Right.
But in the scenario you described isn't enough to type "git commit -s".
Why did you write "git commit -s A B E".

> > $ git C D
>
> Again not a valid command, but...

See above, just a very silly copy and paste error.

> > $ git add C D (C and D are now in the staging area)
> > $ git commit -m "I just modified C and D"
> >
>
> See above :)
>
> There's also the times when I hack on some feature and find some small
> bug/easy-to-write-feature, so I make the change for that other thing,
> swap to a different branch and do 'git commit -s --interactive' to
> just break out that small fix.
>
> Or if I have to add some logic to some other function in a file I've
> modified for other purposes and want it to be two separate commits,
> I just make the change and then run 'git commit --interactive' to
> make it two separate commits.

Very interesting!

> I just don't do 'git commit -a' for the same reason I don't do
> 'git commit -m', really. It tends to be habit-forming, and bisect
> has saved my arse enough times for me to *want* my changes to be
> small and isolated. Debugging a 5-line patch is so much more pleasant
> than debugging a 30k-lines one that spans over several different files.

Yeah, I see.
Thanks for your comments Andreas, very appreciated.

Just to clarify my goal, since I had that interesting discussion with
an hg user I started looking for simple examples of the usage of the
"staging area" to be added to the introduction to git documentation.
The role of the index/staging area seems to be something complex for a
git newbie.

Regards
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
http://ubuntista.blogspot.com
