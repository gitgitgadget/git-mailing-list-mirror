From: Johan Herland <johan@herland.net>
Subject: Re: I have end-of-lifed cvsps
Date: Tue, 17 Dec 2013 18:52:09 +0100
Message-ID: <CALKQrgeegcsO7YVqEmQxD4=HfR4eitodAov0tEh7MRvBxtRKUA@mail.gmail.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com>
	<CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
	<20131212042624.GB8909@thyrsus.com>
	<CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
	<52B02DFF.5010408@gmail.com>
	<CALKQrgf3kuXRpbWmSp_nk8+zDFYNzkgV+dSBHaBbmUkxqjaDUA@mail.gmail.com>
	<20131217145809.GC15010@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Raymond <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Tue Dec 17 18:52:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vsyof-0000c7-Ps
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 18:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755049Ab3LQRwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 12:52:17 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:37586 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340Ab3LQRwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 12:52:16 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VsyoY-0006k9-EO
	for git@vger.kernel.org; Tue, 17 Dec 2013 18:52:14 +0100
Received: from mail-pb0-f54.google.com ([209.85.160.54])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VsyoX-0005LN-UI
	for git@vger.kernel.org; Tue, 17 Dec 2013 18:52:14 +0100
Received: by mail-pb0-f54.google.com with SMTP id un15so7298785pbc.13
        for <git@vger.kernel.org>; Tue, 17 Dec 2013 09:52:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Qua09iePrrJKduPwrYHQToPlEyHAoXI6V0jXJGxQoMM=;
        b=EEsN2VAXfSy6MYddi7QskvdP8qG3Splaj4/jDBL20KTB1DcJOXe+AXWWnfTLZaNmN6
         bPhJm8WdXaTYXFTUHiq6higg8TQsvhb0q9SbVqLxI0EPfA738m2aitYCVtK4ksqsMW/h
         WSU8LlqxKkiACiJx4lzTb8b9n+5axkGUFzgPpGpfjWkGlcwZWZ7L37b1geeXyT5esghv
         0raw2oMzoLxAEhfQJnnFwy+l8Pm3stoV6uJniJ0rWGcAa9T28xrY2pFTvhE5Qc2eK3BJ
         bKr4lywORyuKOXf67MSteyUjlzUqEizQlqpS0/LrUjAVCNHwNMlgM3tLVlDjscktWdSF
         leAw==
X-Received: by 10.68.190.103 with SMTP id gp7mr29025906pbc.74.1387302729947;
 Tue, 17 Dec 2013 09:52:09 -0800 (PST)
Received: by 10.70.24.226 with HTTP; Tue, 17 Dec 2013 09:52:09 -0800 (PST)
In-Reply-To: <20131217145809.GC15010@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239392>

On Tue, Dec 17, 2013 at 3:58 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Johan Herland <johan@herland.net>:
>> HOWEVER, this only solves the "cheap" half of the problem. The reason
>> people want incremental CVS import, is to avoid having to repeatedly
>> convert the ENTIRE CVS history. This means that the CVS exporter must
>> learn to start from a given point in the CVS history (identified by
>> the above mapping) and then quickly and efficiently convert only the
>> "new stuff" without having to consult/convert the rest of the CVS
>> history. THIS is the hard part of incremental import. And it is much
>> harder for systems like CVS - where the starting point has a broken
>> concept of history...
>
> I know of *no* importer that solves what you call the "deep" part of
> the problem.  cvsps didn't, cvs-fast-import doesn't, cvs2git doesn't.
> All take the easy way out; parse the entire history, and limit what
> is emitted in the output stage.

Yes, and starting from a non-incremental importer, that's probably the
only viable way to approach incrementalism.

> Actually, given what I know about delta-file parsing I'd say a "true"
> incremental CVS exporter would be so hard that it's really not worth the
> bother.  The problem is the delta-based history representation.
> Trying to interpret that without building a complete set of history
> states in the process (which is most of the work a whole-history
> exporter does) would be brutally difficult - barely possible in
> principle maybe, but I wouldn't care to try it.

Agreed, you would either have to re-parse the entire ,v-file, or you
would have to store some (probably a lot of) intermediate state that
would allow you to resolve deltas of new revisions without having to
parse all the old revisions.

> It's much more practical to tune up a whole-history exporter so it's
> acceptably fast, then do incremental dumping by suppressing part of
> the conversion in the output stage.
>
> cvs-fast-export's benchmark repo is the history of GNU troff.  That's
> 3057 commits in 1549 master files; when I reran it just now the
> whole-history conversion took 49 seconds.  That's 3.7K commits a
> minute, which is plenty fast enough for anything smaller than (say)
> one of the *BSD repositories.

Those are impressive numbers, and in that scenario, using a
"repurposed" converter (i.e. whole-history converter that has been
taught to do incremental output) is undoubtedly the best solution.

However, I fear that you underestimate the number of users that want
to use Git against CVS repos that are orders of magnitude larger (in
both dimensions: #commits and #files) than your example repo. For
these repos, running a proper whole-history conversion takes hours -
or even days - and working incrementally on top of that is simply out
of the question. Obviously, they still need the whole-history
converter for the future point in time when they have collected enough
motivation/buy-in to migrate the entire project/company to a better
VCS, but until then, they want to use Git locally, while enduring CVS
on the server.

At my previous $DAYJOB, I was one of those people, and I ended up with
a two-pronged "solution" to the problem (this is ~5 years ago now, so
I'm somewhat fuzzy on the details):

 1. Adopt an ad hoc incremental approach for working against the CVS
server: Keep a CVS checkout next to my git repo. and maintain a map
between corresponding states/commits in CVS and git. When I update
from CVS, apply the corresponding patch to the "cvs" branch in my git
repo. Rebase my git-based work on top of that, and use "git
cvsexportcommit" to propagate my Git work back to CVS. This is crude
and hacky as hell, but it provides me a local git-based workflow.

 2. Start convincing fellow developers and lobby management about
switching away from CVS. We got a discussion started, gained momentum,
and eventually I got to spend most of my time preparing and performing
the full-history conversion from CVS to git. This happened mostly
before cvs2svn grew its cvs2git sibling, so I ended up writing a
custom converter for our particular variation of insane and demented
CVS practices. Today, I would probably have gone for cvs2git, or your
more recent work.

But back to my main point:

I believe there are two classes of CVS converters, and I have slowly
come to believe that they solve two fundamentally different problems.
The first problem is "how to faithfully recreate the project history
in a different VCS", which is solved by the full-history converters.
Case closed.

The second problem is somewhat harder to define, but I'll try: "how to
allow me to work productively against a CVS server, without having to
deal with the icky CVS bits". Compared to the first problem, the
parameters differ somewhet:

 - Conversion/synchronization time must be short to allow me to stay
productive and up-to-date with my colleagues.

 - Correctness of "current state" is very important. I must be sure
that my git working tree is identical to its CVS counterpart, so that
my git changes can be reproduced in CVS as faithfully as possible.

 - Correctness of "history" is less important. I can accept a
messy/incorrect Git history, since I can always query the CVS server
for the "correct" history (whatever that means in a CVS context...).

 - As a generic CVS user (not the CVS admin) I don't necessarily have
direct access to the ,v files stored on the CVS server.

Although a full-history converter with fairly stable output can be
made to support this second problem for repos up to a certain size,
there will probably still be users that want to work incrementally
against much bigger repos, and I don't think _any_
full-history-gone-incremental importer will be able to support the
biggest repos.

Consequently I believe that for these big repos it is _impossible_ to
get both fast incremental workflows and a high degree of (historical)
correctness.

cvsps tried to be all of the above, and failed badly at the
correctness criteria. Therefore I support your decision to "shoot it
through the head". I certainly also support any work towards making a
full-history converter work in an incremental manner, as it will be
immensely useful for smaller CVS repos. But at the same time we should
realize that it won't be a solution for incrementally working against
_large_ CVS repos.

Although it should have been made obvious a long time ago, the removal
of cvsps has now made it abundantly clear that Git currently provides
no way to support the incremental workflow against large CVS repos.
Maybe that is ok, and we can ignore that, waiting for the few
remaining large CVS repos to die? Or maybe we need a new effort to
fill this niche? Something that is NOT based on a full-history
converter, and does NOT try to guarantee a history-correct conversion,
but that DOES try to guarantee fast and relatively worry-free two-way
synchronization against a CVS server. Unfortunately (or fortunately,
depending on POV) I have not had to touch CVS in a long while, and I
don't see that changing soon, so it is not my itch to scratch.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
