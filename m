From: Stephen & Linda Smith <ischis2@cox.net>
Subject: Re: [PATCH V4 2/2] user-manual: add section documenting shallow clones
Date: Mon, 28 Dec 2015 17:00:25 -0700
Message-ID: <3529837.cPKXfDBYQ0@thunderbird>
References: <CAPig+cRMdpJ-k9L33jE01ubfK6MOWNGwuoUULuQqOv8C0we+DQ@mail.gmail.com> <1450902961-1528-1-git-send-email-ischis2@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 01:00:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDhhz-00078c-Am
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 01:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbbL2AAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2015 19:00:07 -0500
Received: from fed1rmfepo201.cox.net ([68.230.241.146]:35114 "EHLO
	fed1rmfepo201.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbbL2AAF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2015 19:00:05 -0500
Received: from fed1rmimpo306 ([68.230.241.174]) by fed1rmfepo201.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20151229000003.QEET5597.fed1rmfepo201.cox.net@fed1rmimpo306>
          for <git@vger.kernel.org>; Mon, 28 Dec 2015 19:00:03 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo306 with cox
	id zC021r00L2tqoqC01C02nG; Mon, 28 Dec 2015 19:00:03 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020204.5681CD03.00CA,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=LKq4tuq9 c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=wUQvQvOEmiQA:10
 a=TSbVqHtbAAAA:8 a=VwQbUJbxAAAA:8 a=z3QjaC2aAwYx03ruBs4A:9 a=CjuIK1q_8ugA:10
 a=x8gzFH9gYPwA:10 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.localnet (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id AC641140569;
	Mon, 28 Dec 2015 17:00:25 -0700 (MST)
User-Agent: KMail/5.0.2 (Linux/4.3.0-2-generic; KDE/5.15.0; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283055>

On Monday, December 28, 2015 02:57:47 PM Junio C Hamano wrote:
> "Stephen P. Smith" <ischis2@cox.net> writes:
> 
> > Rather than merely pointing readers at the 1.5 release notes to
> > learn about shallow clones, document them formally.
> >
> > Signed-off-by: Stephen P. Smith <ischis2@cox.net>
> > ---
> >
> >  I replaced the paragraphs that I wrote with Eric Shunshine's since it
> >  was cleaner.
> >
> >  I like the idea of linking to the preceeding effort, but gmane.org is
> >  currently undergoing maintance and therefore giving me errors when I
> >  attempt to access it.
> >
> >  Documentation/user-manual.txt | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> > index 1c790ac..5c13683 100644
> > --- a/Documentation/user-manual.txt
> > +++ b/Documentation/user-manual.txt
> > @@ -2128,6 +2128,20 @@ The gitweb cgi script provides users an easy way to browse your
> >  project's files and history without having to install Git; see the file
> >  gitweb/INSTALL in the Git source tree for instructions on setting it up.
> >  
> > +[[how-to-get-a-git-repository-with-minimal-history]]
> > +How to get a Git repository with minimal history
> > +------------------------------------------------
> > +
> > +A <<def_shallow_clone,shallow clone>>, with its truncated
> > +history, is useful when one is interested only in recent history
> > +of a project and getting full history from the upstream is
> > +expensive.
> > +
> > +A <<def_shallow_clone,shallow clone>> is created by specifying
> > +the linkgit:git-clone[1] `--depth` switch. The depth can later be
> > +changed with the linkgit:git-fetch[1] `--depth` switch, or full
> > +history restored with `--unshallow`.
> > +
> >  [[sharing-development-examples]]
> >  Examples
> >  --------
> 
> OK.
> 
> > @@ -4645,9 +4659,6 @@ standard end-of-chapter section?
> >  
> >  Include cross-references to the glossary, where appropriate.
> >  
> > -Document shallow clones?  See draft 1.5.0 release notes for some
> > -documentation.
> > -
> 
> The 1.5.0 release notes describe three limitations that was present
> back in the day.  I think the first two have been lifted (I am not
> sure if it is throughly tested and shown to be bulletproof, though),
> but the third limitation is fundamental and not something that will
> ever be "fixed".  It probably is a good idea to add it here to avoid
> hurting unsuspecting new users.
> 

I had thought about putting in warnings in the user's manual (and even wrote up a 
paragraph) but then decided to remove it.  My rationale was that there are 
warnings/restrictions elsewhere in the documentation but I wasn't finding any 
in the user manual.  Thanks for changing my mind.

> I notice that this section uses "a shallow clone" as a noun that
> refers to a repository that has incomplete history--it is a synonym
> to "a shallow repository", but more explicitly conveys the fact that
> its cauterised history was obtained originally from elsewhere.
> 
> And I think that is a good use of the word, but I am not sure if
> the phrasing used in your [1/2] is consistent with it:
> 
> +[[def_shallow_clone]]shallow clone::
> +	A clone of a <<def_repository,repository>> which creates a
> +	<<def_shallow_repository,shallow_repository>>.
> +
> 
> I read this sentence, especially the part "A clone ... which creates"
> as referring to "an act of running the 'git clone' command", not
> "the (shallow) repository that results from such an act", and found
> it a bit strange.
> 
> Right now, I do not think we have a canned way to create a shallow
> repository locally without running "git clone --depth", but there is
> no fundamental reason you shouldn't be able to do so (we can even
> today create a shallow repository manually using lower-level tools
> without running "clone --depth" from elsewhere).  And for somebody
> who has seen such a repository, "a shallow clone" and "a shallow
> repository" would have a slight difference.  The former is a shallow
> repository that was created using "clone --depth"; the latter may or
> may not ahve been created with "clone --depth", it just says the
> repository does not have full history without hinting how it was
> made so.
> 
> Perhaps replace 1/2 with something like this?
> 
>     [[def_shallow_clone]]shallow clone::
>             Mostly a synonym to <<def_shallow_repository,shallow repository>>
>             but the phrase makes it more explicit that it was created by
>             running `git clone --depth=...` command.
> 
>     [[def_shallow_repository]]shallow repository::
>             A shallow <<def_repository,repository>> has an incomplete
>             history some of whose <<def_commit,commits>> have
>             <<def_parent,parents>> cauter
> 
That seems like better wording.    

Until I started working on this I wasn't really aware of the term shallow repository.   
Everything I had seen was shallow clone.

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
