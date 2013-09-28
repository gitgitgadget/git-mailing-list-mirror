From: Johan Herland <johan@herland.net>
Subject: Re: Local tag killer
Date: Sat, 28 Sep 2013 23:42:59 +0200
Message-ID: <CALKQrgeJn1J4ntE_2Lr7Et+Oao=vB1FE6nLfaFJOvLHJLzG9tA@mail.gmail.com>
References: <52327E62.2040301@alum.mit.edu>
	<CAPc5daXvCf90WYoUWC+DxRyZEQhXGL7Bd_ZJKwfoqxeKt8TADQ@mail.gmail.com>
	<xmqqd2o3p0nk.fsf@gitster.dls.corp.google.com>
	<523D3FD2.4090002@alum.mit.edu>
	<20130924075119.GD7257@sigill.intra.peff.net>
	<alpine.LFD.2.03.1309251834210.312@syhkavp.arg>
	<5246C975.1050504@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Sep 28 23:43:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2ID-0000a4-3T
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 23:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755074Ab3I1VnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 17:43:08 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:51318 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754733Ab3I1VnH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 17:43:07 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VQ2I4-0006HG-C2
	for git@vger.kernel.org; Sat, 28 Sep 2013 23:43:04 +0200
Received: from mail-pd0-f175.google.com ([209.85.192.175])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VQ2I3-000Juh-NI
	for git@vger.kernel.org; Sat, 28 Sep 2013 23:43:04 +0200
Received: by mail-pd0-f175.google.com with SMTP id q10so3998540pdj.20
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 14:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2rOjXGvmNLLRDd9VPa4m3Buv7ZuL/vSMcQ2lvBG02q0=;
        b=Pb5JjMOWGImtcHoOLtVmSb9WCePOVde36GqO7Q/fMrUNJIk94Mg1lJaAZlN7B1ZKeB
         NT5d1VWf8nCzNwVjUi4oaDEj1wPjJn1b1PWdWHhtRxDP4uo57+OLhHkKxtYlThMSBWnG
         ZBJ765AUN2ndzp1rbCtIBo4l1/OQzjoaO0uU7uXWbaVO+OCq13BG/aM1sNeLRAuNKi2x
         Y1hCx5hiiLVnGyfGyrhloNrpzTAgqaXvT7HYWagHUwKEQUvP0myQHa9ORsmZ1PYstEEa
         foMe2RFrr36qf3efCMqUT4/DmgBqG6JS/GKUv3YGfYwX84EuuDnRLVh9DjcUV91YZ/1l
         /skw==
X-Received: by 10.66.227.194 with SMTP id sc2mr19392230pac.41.1380404579639;
 Sat, 28 Sep 2013 14:42:59 -0700 (PDT)
Received: by 10.70.24.226 with HTTP; Sat, 28 Sep 2013 14:42:59 -0700 (PDT)
In-Reply-To: <5246C975.1050504@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235508>

On Sat, Sep 28, 2013 at 2:20 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> I just reviewed that old thread to determine its relevance to the
> present discussion.  For the benefit of the other readers, here is a
> summary of the main points that I got out of it.

I want to thank you immensely for the summary below. It really helps me
clear my own thoughts on this topic, and is an excellent base for
discussing how to advance on it.

> The main proposal under discussion was that of Johan Herland:
>
>     http://article.gmane.org/gmane.comp.version-control.git/165885
>
> Nicolas made the two best arguments for the necessity of
> separate tag namespaces per remote in *some* form:
>
>> The extraordinary misfeature of the tag namespace at the moment
>> comes from the fact that whenever you add a remote repo to fetch,
>> and do fetch it, then your flat tag namespace gets polluted with all
>> the tags the remote might have.  If you decide to delete some of
>> those remote branches, the tags that came with it are still there
>> and indistinguishable from other tags making it a real pain to sort
>> out.
>>
>> -- http://article.gmane.org/gmane.comp.version-control.git/166108
>
> and
>
>> Let's take the OpenOffice vs LibreOffice as an example.  What if I
>> want both in my repository so I can easily perform diffs between
>> those independent branches?  They may certainly end up producing
>> releases with the same version numbers (same tag name) but different
>> content (different tag references).
>>
>> -- http://article.gmane.org/gmane.comp.version-control.git/166749

I'd also like to mention my initial motivation for the proposal: a
natural way to organize other types of remote refs (notes, replace
refs, etc.). The separate tag namespace came about as a natural
(and IMHO quite useful) consequence of the proposed reorganization
of refs/remotes/*.

> Other discussion and open issues regarding a ref namespace reorg:
>
> * What exactly would be the ambiguity rules for references with the same
>   name that appear in multiple remotes' namespaces?
>
>   * Are references to two annotated tags considered the same if they
>     refer to the same SHA-1, even if the annotated tags are different?
>     What about an annotated vs an unannotated tag?  The consensus
>     seemed to be "no".
>
>   * Do they depend on how the reference is being used?  Yes, sometimes
>     only a SHA-1 is needed, in which case multiple agreeing references
>     shouldn't be a problem.  Other times the DWIM caller needs the
>     full refname (e.g., "git push" pushes to different locations
>     depending on whether the source is a branch or tag), in which case
>     the rules would have to be more nuanced.

Could we try to classify all ref lookups as either ref _name_ lookups
(in which case only a single, matching full refname is acceptable), or
ref _value_ lookups (in which case multiple matching names are allowed,
as long as they all point to the same SHA-1)? There are some complicated
cases (e.g. describe) which needs more thought, but if we can agree on
a mechanism for dealing with all the simpler cases, that might help
inform how to deal with the complicated ones.

>   * Should the same ambiguity rules be applied to other references
>     (e.g., branches)?

IMHO, yes.

>   * What if a branch and a tag have the same name?

IMHO, it depends on the context of the lookup. Some commands (e.g.
branch, tag) are clearly only interested in one ref type, and should
not care about other ref types at all.

For other lookups (e.g. rev-list, rev-parse), IMHO it depends on
whether they're looking up ref _names_ or ref _values_. In the former
case, ambiguity is always an error, while in the latter case it's not,
provided they agree on the SHA-1 (although maybe warning about
ambiguity might be appropriate in some contexts).

>     * Nicolas Pitre suggested that usually they should be accepted if
>       they have the same value, and if the refname matters then the
>       branch should take precedence (with a warning).
>
>     * Peff pointed out that currently dwim_ref prefers tags, but that
>       Junio has said that that behavior was arbitrary [and by
>       implication could be changed].  He suggested:
>
>       > For dwim_ref, it prefers the tag and issues a warning. For
>       > git-push, it complains about the ambiguity and dies. For git
>       > checkout, we prefer the head. For git-tag, we prefer the tag
>       > (though I think that only matters for "git tag -d").
>       >
>       > -- http://article.gmane.org/gmane.comp.version-control.git/166290
>
> * What should "name-rev", "describe", "--decorate" output?  See
>   discussion here:
>
>       http://article.gmane.org/gmane.comp.version-control.git/165911

AFAICS, "name-rev" and "--decorate" are the simple cases: Use the
shortest possible name which is still completely unambiguous in the
current repo.

For "describe", we want to use a tag name with no prefix (i.e. only
"$tag", not "$remote/$tag" or "$remote/tags/$tag" etc.). We also
probably want to prefer tags from some remotes over tags from other
remotes. Maybe something like:

  git describe --tags-from $remote

where the default behavior (i.e. given no --tags-from) would be to
assume

  --tags-from $(branch.$current.remote)
  --tags-from origin
  --tags-from . # local tags

or some combination of those.

> * "fetch" should probably warn if it ends up fetching a tag with the
>   same name (according to the refname disambiguation rules) but value
>   that conflicts with an existing tag in a different namespace.
>
> * Do we need some pathspec modifier (e.g., "~") to specify that the
>   corresponding references should be auto-followed in the manner
>   currently done for refs/tags/*?  Or is auto-following maybe not
>   needed at all anymore?:
>
>       http://article.gmane.org/gmane.comp.version-control.git/160726
>
>   Junio thought, and Johan agreed, that tag auto-following should still
>   be done for repositories that use the old ref namespace format.  But
>   perhaps this could be special-cased via a config setting rather than
>   built into the refspec syntax.

When using separate remote tag namespaces, I believe tag auto-following
is no longer needed. Instead the default refspec would simply fetch all
tags into the remote tag namespace.

As for the config setting, I have thought much about whether it is
possible to introduce remote ref namespaces while retaining backwards
compatibility, all _without_ having an explicit config switch. However,
I have more or less arrived at the conclusion that a "clean break" with
a config switch that selects either old or new ref layouts (and
associated semantics/behavior) is preferable.

> * How would somebody (e.g., an interim maintainer) suck down tags from
>   a project into his own refs/tags/* namespace?  (Would it even be
>   necessary?)

I'm not convinced it would be necessary. I have yet to see a case where
a (suitably unambiguous) remote tag would not fulfill the same purpose
as the equivalent local tag. The only exception is for dealing with
ambiguous remote tags, where a local tag could be created to serve as a
tie-breaker.

>   Should there be a tool for this?  [It seems to me that something like
>
>       git fetch . refs/remotes/origin/tags/*:refs/tags/*
>
>   would do the trick, as long as pruning were turned off.]

AFAICS, that fetch command should work (and should IMHO be unaffected
by fetch.prune or remote.$remote.prune in the configuration).

> * What special handling (if any) is required for
>   refs/remotes/$REMOTE/HEAD?
>
>   * According to Junio, HEAD is meant to indicate which branch is the
>     "main" branch of the remote.  It is not transferred via the
>     protocol, but rather guessed at by the client's "clone" process:
>
>         http://article.gmane.org/gmane.comp.version-control.git/166694
>         http://article.gmane.org/gmane.comp.version-control.git/166740

IMHO, if we want HEAD to accurately represent the "main" branch of the
remote, then we must also extend the protocol to contain it, so that it
does not go stale or suffer at the mercy of "guesswork".

> * How would this help somebody who wants to fetch content from multiple
>   projects (e.g., git, gitk, gitgui) into a single repo?  There might
>   be tags with the same names but very different meanings, and it would
>   be awkward if there were ambiguity warnings all over the place.
>   [Would it work to configure the fetching repo something like
>
>   [remote "gitk-origin"]
>           fetch = refs/tags/*:refs/remotes/gitk-origin/tags/gitk/*
>
>   and to refer to a hypothetical gitk tag "v1.2.3" as "gitk/1.2.3"?
>   Admittedly this is somewhat ambiguous with the proposed DWIM pattern
>   <REMOTE>/<TAGNAME>.]

Only if you also had a remote called "gitk". ;)

An alternative way to solve the problem of many ambiguity warnings:
If we define the rules so that local tags always override remote tags,
you could simply fetch the tags from your preferred remote into your
local tag namespace (as discussed above).

Personally, I would rather set up the configuration like this:

  [remote "gitk"]
          fetch = refs/tags/*:refs/remotes/gitk/tags/*

(i.e. keeping the default refspec) and then use "gitk/v1.2.3",
"git/v.1.2.3", "gitgui/v1.2.3" to disambiguate between the tags.

> * It might be nice to have a command like
>
>       git push $REMOTE --interactive
>
>   that allows the user to choose interactively which branches/tags to
>   push
>
>   -- http://article.gmane.org/gmane.comp.version-control.git/166700

I like that idea, but I think it's somewhat peripheral to the ref
namespace discussion.

> I hope that saves somebody the time of reading the whole thread
> (though admittedly my summary is not especially short either).
>
>
> As far as I can tell, the division of tags into remote-specific
> namespaces would be another way of preventing the problem of tags being
> pruned too aggressively.  But given that such a big change would be a
> huge development effort, implementing something like the following
> might be a quicker fix and would not conflict with a hypothetical
> future ref namespace reorganization:
>
> 1. Limit "git fetch --prune" to only pruning references that are under
>    refs/remotes/*
>
> 2. Add a new option --prune-tags that removes the above limitation
>
> 3. And the above two changes would make this one possible: Change the
>    meaning of the --tags option to mean "fetch all tags *in addition
>    to* (rather than *instead of*) the references that would otherwise
>    be fetched".

Agreed. The ref namespace topic clearly dwarfs the issue that started
this thread.

> @Johan, I know that you were working on the ref-namespace issue at
> GitMerge.  Did your work get anywhere? Are you still working on it?

I posted a couple of patch series dealing with _some_ preliminary
issues and adding some initial behavior changes. The first one was
parked in 'pu':

  https://git.kernel.org/cgit/git/git.git/commit/?h=pu&id=07e56ed

but has since been stuck in limbo, since we decided to roll it into
the larger series:

  http://article.gmane.org/gmane.comp.version-control.git/225137

The larger series was last posted here:

  http://thread.gmane.org/gmane.comp.version-control.git/223981

Since then, regrettably, not much has happened. I've now rebased the
series (still unfinished) onto v1.8.4 (no conflicts, still passes all
tests), and pushed it to my GitHub account:

  https://github.com/jherland/git/commits/peers-resurrect

That said, there are probably things in that series I'd like to revise,
e.g. introducing the config switch controlling new vs. old behavior as
early as possible, and reverting back to using refs/remotes/* instead
of refs/peers/*.

> Have you documented somewhere any new insights that you have gained
> about the problem space?

I think this (hideously long) reply should cover it...


Have fun! :)

...Johan

--
Johan Herland, <johan@herland.net>
www.herland.net
