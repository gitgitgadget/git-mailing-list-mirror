From: "=?ISO-8859-1?Q?Erik_B=E5gfors?=" <zindar@gmail.com>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 15:09:35 +0200
Message-ID: <845b6e870610180609l70daa727wbda9b03ab99ba301@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610171555.56778.jnareb@gmail.com> <vpqr6x711cm.fsf@ecrins.imag.fr>
	<200610171641.04455.jnareb@gmail.com>
	<20061018000026.GH20017@pasky.or.cz> <45357596.8050702@utoronto.ca>
	<20061018003920.GK20017@pasky.or.cz>
	<845b6e870610180228m39829c49nf37e07e76e744250@mail.gmail.com>
	<20061018110841.GS20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, bazaar-ng@lists.canonical.com,
	Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Wed Oct 18 15:10:24 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaBBN-0004ET-C5
	for gcvbg-bazaar-ng@m.gmane.org; Wed, 18 Oct 2006 15:10:05 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GaBB4-0000ql-CB; Wed, 18 Oct 2006 14:09:47 +0100
Received: from wx-out-0506.google.com ([66.249.82.224])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <zindar@gmail.com>) id 1GaBAv-0000mm-0E
	for bazaar-ng@lists.canonical.com; Wed, 18 Oct 2006 14:09:37 +0100
Received: by wx-out-0506.google.com with SMTP id h26so248603wxd
	for <bazaar-ng@lists.canonical.com>;
	Wed, 18 Oct 2006 06:09:36 -0700 (PDT)
Received: by 10.90.115.9 with SMTP id n9mr6098739agc;
	Wed, 18 Oct 2006 06:09:36 -0700 (PDT)
Received: by 10.35.116.4 with HTTP; Wed, 18 Oct 2006 06:09:33 -0700 (PDT)
To: "Petr Baudis" <pasky@suse.cz>
In-Reply-To: <20061018110841.GS20017@pasky.or.cz>
Content-Disposition: inline
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29231>

On 10/18/06, Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Wed, Oct 18, 2006 at 11:28:32AM CEST, I got a letter
> where Erik B?gfors <zindar@gmail.com> said that...
> > On 10/18/06, Petr Baudis <pasky@suse.cz> wrote:
> > >Dear diary, on Wed, Oct 18, 2006 at 02:30:14AM CEST, I got a letter
> > >where Aaron Bentley <aaron.bentley@utoronto.ca> said that...
> > >> Petr Baudis wrote:
> > >> > Another aspect of this is that Git (Linus ;) is very focused on getting
> > >> > the history right, nice and clean (though it does not _mandate_ it and
> > >> > you can just wildly do one commit after another; it just provides tools
> > >> > to easily do it).
> > >>
> > >> Yes, rebasing is very uncommon in the bzr community.  We would rather
> > >> evaluate the complete change than walk through its history.  (Bundles
> > >> only show the changes you made, not the changes you merged from the
> > >> mainline.)
> > >>
> > >> In an earlier form, bundles contained a patch for every revision, and
> > >> people *hated* reading them.  So there's definitely a cultural
> > >> difference there.
> > >
> > >BTW, I think what describes the Git's (kernel's) stance very nicely is
> > >what I call the Al Viro's "homework problem":
> > >
> > >        http://lkml.org/lkml/2005/4/7/176
> > >
> > >If I understand you right, the bzr approach is what's described as "the
> > >dumbest kind" there? (No offense meant!)
> >
> > Yes and no, The bundle includes both the full final thing, and each
> > step along the way. Each step along the way is something you'll get
> > when you merge it.
> >
> > Once merged, it will be "next one" in the description above. It would
> > typically look something like this in "bzr log"(shortened)  In this
> > example, doing C requires doing A and B as well...
> >
> > committer: foobar@foobar.com
> > message: merged in C
> >      -------
> >      committer: bar@bar.com
> >      message: opps, fix bug in A
> >      -------
> >      committer: bar@bar.com
> >      message: implement B
> >      -------
> >      committer: bar@bar.com
> >      message: implement A
> >
> > So, you'll get full history, including errors made :)  You can also
> > see who approved it to this branch (foobar) and who did the actual
> > work (bar)
>
> I see, that's what I've been missing, thanks. So it's the middle path
> (as any other commonly used VCS for that matter, expect maybe darcs?;
> patch queues and rebasing count but it's a hack, not something properly
> supported by the design of Git, since at this point the development
> cannot be fully distributed).
>
> I also assume that given this is the case, the big diff does really not
> serve any purpose besides human review?
>
> But somewhere else in the thread it's been said that bundles can also
> contain merges. Does that means that bundles can look like:
>
>    1
>   / \
>  2   4
>  |   | _
>  3   5  |
>   \ /   | a bundle
>    6    |
>        ~
>
> In that case, against what the big diff from 6 is done? 2? 4? Or even 1?

When you run the "bundle" command, you can tell it what you want the
bundle to be created against.  So, If I just commited 5, I can run
"bzr bundle -r-1" to get the bundle against 4, or I can do "bzr bundle
path/to/other/branch" to get a bundle that relates to it.

To merge a bundle into a branch, the parrent of the first revision in
the bundle, has to exist in the branch is't being merged into. (well,
unless you use patch, but that's outside of bzr, and bzr wouldn't know
about each revision in them)

This command will find a common root and create a bundle that
corresponds to it.  The "big diff" as you call it, would be the
changes between the point where the branch was created, and the last
commit.

In the case of just committing 5, and you want to create a bundle that
can be merged back at point 6, the "big diff" would be against 1 since
that's the branch point.

/Erik
