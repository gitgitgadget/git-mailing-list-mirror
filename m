From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Comments on "Understanding Version Control" by Eric S. Raymond
Date: Wed, 4 Feb 2009 03:04:02 +0100
Message-ID: <200902040304.05028.jnareb@gmail.com>
References: <200902021948.54700.jnareb@gmail.com> <20090202202424.GG14762@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 04 03:06:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUX9J-0006z3-3i
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 03:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbZBDCEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 21:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752057AbZBDCEO
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 21:04:14 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:31045 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbZBDCEN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 21:04:13 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1077571fgg.17
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 18:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=mL7AHAWyeSQgvPO4geH7hRp0vMp3JyLt8e8zNzyXcEo=;
        b=CvAEU36f3PhzlLgoNswym/g4gfXeqoX++PPiQoCA7cBzZhC6Zg+Znzvi1mZNsnhmeI
         ynnfX4o28qd22RAxX4hJRb+plJnZtG8sAazihRxRTjjKXKF8zc9zvMsXU5KdEWk7b4g/
         p5DdE91mrZa5tcfa7ATj+kwEzotb3E0anLqI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=BAsKrGVvFY32CzW6Ezs0K1e/LAU/astyAuZBzZ2ZxgL3WxZ3IKIIrU1c5DdW2mVn+h
         +syE+Fem3f6qM8rcVDHNSjDDZFieHZi9UOQSVSa3/S6HbW4p3inwtsE37uVorEWjz7qR
         PJDjHPMyth4w+yNpM8C4wCgGjSIoIhoC+fuTE=
Received: by 10.86.52.6 with SMTP id z6mr59090fgz.63.1233713050744;
        Tue, 03 Feb 2009 18:04:10 -0800 (PST)
Received: from ?192.168.1.13? (abvm245.neoplus.adsl.tpnet.pl [83.8.210.245])
        by mx.google.com with ESMTPS id 4sm753180fgg.15.2009.02.03.18.04.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Feb 2009 18:04:09 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20090202202424.GG14762@mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108286>

On Mon, Feb 02, 2009, Theodore Tso <tytso@mit.edu> wrote:
> On Mon, Feb 02, 2009 at 07:48:53PM +0100, Jakub Narebski wrote:

> > In my opinion the most important issue is concentrating on "container
> > identity" instead of on the underlying issue of renames in version
> > control, which includes intelligent, rename-aware merge; talk about
> > issues and not about possible solution.  I will concentrate on this
> > issue for now, and leave for example issue of workflows, and of VCS
> > history for possible later posts (it is long enough as is).
> 
> This was discussed in no small amount of detail on the mailing list
> uvc-reviewers [...]

I guess that this mailing list is subscribe-only, isn't it?  So doing
CC to uvc-reviewers wouldn't, unfortunately, cut?

> > Below you can find my comments; quoted fragments of "Understanding
> > Version Control' essay are prefixed with 'UVC> '.  'TODO' refers to
> > http://www.catb.org/esr/writings/version-control/TODO.html
> > 
> > Please do participate in this discussion, especially if you have
> > something to say with respect to rename detection versus rename
> > tracking issue.  Thanks in advance.
> 
> Heh.  A lot of this has been said already.  I think one of the reasons
> why Eric kept things short in his paper, and did *not* say a lot about
> whether or not container identity tracking was fundamentally needed or
> not was because we didn't come to any real consensus on the
> uvc-reviewers mailing list.  I believe it is extremely difficult to do
> so given that it's very hard to avoid the slippery slope of advocating
> for one SCM system versus another.

Well, I tried to be objective, but I know I am biased towards Git.
I tried to list advantages and disadvantages of all three methods of
dealing with renames in VCS: 'container identity' aka. 'file-ids'
(and 'directory-ids') which I think is solution used by Bazaar;
'rename tracking' or 'recording rename information' which I think
is the solution used by Mercurial, and 'rename detection' used by
Git.

BTW. if I remember correctly (either from comments in UVC, or from
TODO) Eric wanted to have test suite which he could run to examine
how well does given VCS support renames in the form of intelligent
rename-aware merges, and in the form of following file through
renames when examining history.  

When writing this email I have wanted to add as appendix a proposal
for such test, which would also clarify what are the expectations
wrt. rename support... but I plainly forgot to add it.  You can
find some very bare bones version in my post "Git at Better SCM
Initiative comparison of VCS (long)"[1][2] on git mailing list,
around where I was talking about intelligent_renames section.
(The post was meant to correct invalid information about Git in
'Better SCM Initiative' comparison[3]).

[1] http://thread.gmane.org/gmane.comp.version-control.git/95809
[2] My earlier posts with similar title were about _adding_ Git
    to the comparison.
[3] http://better-scm.berlios.de/comparison/

> 
> I'll include some of my writings on the subject from the uvc-reviewers
> mailing list so folks can see where some of this discussion went last
> time...  (All of this dates from January, 2008, when Eric was last
> aggressively updating the paper in question.)

Thank you very much for those excerpts / fragments, even though
I'd rather have your fresh comments either on current state of 
"Understanding Version-Control Systems", or on my post.

> BTW, when I referred to 
> SCM's being a horrible hack and "guessing" and "fit only to be used by
> amateurs" if they didn't record function-level identity tracking,
> there were those who were seriously arguing that any SCM (i.e., like
> git) that didn't track container identity was fundamentally a "hack".
> Yes, there are people who seriously take that view, some of which were
> very bitter that their DSCM didn't win the market/popularity wars, and
> so their pet projects overtaken by SCM's such as git, describing
> $THEIR_PET_SCM_WITH_PROVABLY_CORRECT_SEMANTICS as Betamax, and git as
> VHS.  The argument that without rename-tracking, if git was used to
> development an software for Air Traffic Control application, airplanes
> could be dropping out of the sky was also made by these advocates, no
> kidding.  (So was the argument that using a DSCM that didn't do
> container identity tracking might be considered Programming
> Malpractice.)

That is, I think, the difference between being 'perfect in theory' and
'good enough in practice', and reminds me of times of discussion about
"perfect" contents merge algorithm (Codeville merge and precise
Codeville merge, folks at revctrl.org and mark-merge, etc.).  Nowadays
even Bram Cohen (of the Codeville) that 3-way merge algorithm is good
enough ("Version Control Recommended Practices", '3. Use 3-way merge',
at http://bramcohen.livejournal.com/52148.html).

Failing gracefully matters (i.e. if there is a conflict it can be
easily understood), low probability of falsely clean merges matters,
and performance (to not be exponential in some real cases) matters
too.  More than theoretical perfection.

And there are many, many examples of using heuristics over perfect
algorithmic solution (if algorithmic solution exists at all).

> 
> So be careful about wanting to reopen this discussion; if the some of
> the wrong people join in, you may be very sorry!   :-)

Thanks for the warning! :-) Well, I hope they are not present on git
mailing list...

> 
>    	     	       	       	    	       	    	 - Ted
> 
> 
> > Here then are some types of identity  
> > tracking one might imagine:
> > 
> >    * File identity tracking: tracks the identity of a file through  
> > renames and moves.

Git tracks _contents_ of a file.  Not file identity.  And this works
quite well in practice (although it is not free from disadvantages).

> >    * Simple file content tracking: tracks the identity of content  
> > using adds and deletes within a single file.  (Note, there is a  
> > question that could be asked here about the resolution of the  
> > tracking.  Most current systems that track do so on a line-by-line  
> > basis, but one could imagine tracking bytes.  I wont say any more  
> > about this in this email.)
> >    * Movement of content within a file: tracks the identity of  
> > content within a file when lines are moved.
> >    * Movement of content between files: tracks the identity of  
> > content when lines are moved between files.

"git blame -C -C <file>" supports all three. I think it is the only
VCS which supports detection of code movement and copying in single
file and across files.  That's by the way, of course...

> 
> One obvious one which isn't in this list is "Directory Identity
> Tracking", that is when you move a directory, new files which are
> created in one branch at the original directory location will be moved
> when you merge with another branch where the directory has been moved.

Or "Detecting [Wholesame] Directory Renames"... which can be done
using 'rename detection' paradigm, and we have patches to prove it![4]
but unfortunately code didn't made it (yet!) into git.  And it can,
I think, deal with splitting files into two directories, something
which I guess in 'container identity' (directory-id) based solution
is simply impossible

This issue would be in my planned test suite of VCS rename support.

[4] e.g. http://thread.gmane.org/gmane.comp.version-control.git/99529

> In private conversations with Tom Lord, he tells me that he had also
> played with the concept of "Function/variable (more generally,
> programming structure identifier) identity tracking". [...]

True, it is _theoretical_ advantage of changeset based model that
one can use richer set of operators than simple delta (this is IIRC
touched in Darcs manual).  But first, nobody implemented such thing,
even as proof-of-concept prototype.  Second, I GUESS that _in practice_
this would require something like Darcs' theory of patches and Darcs'
patch commutation, and to merge strategy which would have to take
into account _whole_ history (and not only endpoints: branches to
be merged and common ancestor(s) like in 3-way merge)... which could
and would lead to exponential time; extremely bad performance.  But
that is just my guess.

> ---------------------------
> 
> > The second could be called "location".  Which file should this patch  
> > be applied to?  Which lines within a file should this hunk be applied  
> > to?  I argue in [2] that Darcs does strictly better at the task of  
> > location than do SVN or GNU diff3. [...]
> 
Does Darcs still have bug with exponential time of some merges?

> How are you defining "provably correct"?  In order to show
> correctness, you need to define what correctness means.

Additionally if it would be possible to decide and mathematically
define what is correct way of merge resolution, it still wouldn't
help in the case of semantic conflict.  And not tool would be
ever able to solve it.

>
> One approach is that you force the user to tell you [...]

And this is of course _wrong_ solution from the usability point of
view.  Well, at least I think it is.

> > Let's be careful not to lump these three things together, say "All  
> > merging involves guessing.", and thus overlook the interesting fact  
> > that some merge algorithms involve strictly more guessing than do  
> > others.
> 
> Part of the problem is that words like "guessing" and claims of some
> algorithm being "provably correct" are basically marketing words.
> They are generally used to denigrate one SCM, and promote someone's
> favorite SCM as being **better**.
> 
> Fundamentally, the goal of merging is to Do The Right Thing --- from a
> semantic point of view, which means that the user's intentions is
> what's important at the end of the day.  The question then is whether
> you record the user's intentions, or try to determine it in from a
> heuristics point of view.

As I wrote: sometimes heuristic algorithms are better; take for
example the NP-C 'travelling salesman' problem...

And what matters is if given merge strategy (algorithm) is good
in practice, and not if it is good in theory...  (I'm repeating
myself.)

> 
> The people who claim that recording the user's intentions is superior
> will claim that you can never know for sure what the user meant, so
> you have to ask him or her to provide that information.  In some cases
> that's relatively easy; you require the user to use commands like "bk
> mv" and "bk cp" and "bk rm" which not only performs the function, but
> also records the user's intention.  Unfortunately, if you are applying
> a patch, and the patch file hasn't been enhanced to carry this kind of
> information, you have to use heuristics and then somehow get the user
> to confirm them --- hence the use of the Annoying Popup Dialog Box.

Ordinary patches, filemanages, your favorite editor (if it doesn't
have support for 'rename recording' VCS you use)...

BTW. using heuristic to find renames and record information about
renames during commit wouldn't help in the case if the file was
independently added but for example under different filename: for
this is I think necessary to have rename detection at merge time.


[...]
> And yet, people seem to focus on recording of user intention because
> it reflects some holy grail of Perfection and Correctness.  And maybe,
> because it is easily measurable, whereas usability and improving
> programmer productivty are inherently more subjective measures.
> What's very sad are the people who are feel profoundly hurt that they
> spent a huge amount of their life working on SCM Correctness, only to
> find that people chose other SCM's based on other metrics and other
> issues other than the one that they felt was most important.
> Unfortunately there's not a lot that can be done about that.
> 
> 		      	       	      - Ted

Erm... this certainly shows that discussion on uvc-reviewers mailing
list drifted _badly_ away from what "Understanding Version Control"
is about :-( 


P.S. I hoped that Linus who is strong proponent of 'contents is the
     king' and superiority of rename detection would write something
     but perhaps it was too long...
-- 
Jakub Narebski
Poland
