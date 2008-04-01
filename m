From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git-submodule getting submodules from the parent repository
Date: Tue, 1 Apr 2008 19:56:10 -0400
Message-ID: <32541b130804011656l2e907895i98e5260b49743bbe@mail.gmail.com>
References: <32541b130803291535m317e84e6p321ebccd5dedaab3@mail.gmail.com>
	 <47EECF1F.60908@vilain.net>
	 <D0F821FA-AF53-4F1F-B9CC-58346828FA15@orakel.ntnu.no>
	 <47EFD253.6020105@vilain.net>
	 <C38585A9-F09C-4A5B-8E72-6F3127DB2BB9@orakel.ntnu.no>
	 <32541b130803301603u65d1b6b6ladac0f6200433e5f@mail.gmail.com>
	 <834174D1-82F4-4438-9854-762F416BB5EF@orakel.ntnu.no>
	 <32541b130803311436t7b5041a4pabface15aad8ce63@mail.gmail.com>
	 <47F2BFCD.5070202@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eyvind Bernhardsen" <eyvind-git@orakel.ntnu.no>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Apr 02 01:57:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgqLa-0004Ts-7t
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 01:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756391AbYDAX4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 19:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756504AbYDAX4N
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 19:56:13 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:59891 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756376AbYDAX4L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 19:56:11 -0400
Received: by fk-out-0910.google.com with SMTP id 19so3153472fkr.5
        for <git@vger.kernel.org>; Tue, 01 Apr 2008 16:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=V45pZzS5/k9Cy236en9e+dsoYpmYhPqOqT56crWjFdw=;
        b=EQ24k86HZvhNEMuTotUg0brP4/dqR1Dfa+u2rQeQu9Iw9l+Tn+xGGYAQ6KLGvbg8s24v9gQQVAejOP2NNLszQDIchWrI7yB5h6hl5znZPkJwhrrN3ZkH27I73MDOYrMKTu+1bCc+QBZvF+CCudOS/r1tVttOP4sOVhS+XZ4nbio=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rZVjEA6nnygxqYr5HhXv2v/87Q2NbHTc3on780gsvxuyKZBnpAGq7/OpTfx/HG/6wKDovEu9kUFG5yJPo9IiwslagKZE8EzsiiUSjs/29f9nrdD1FulpLwYda90ZvIOtcaX+rLP24xl6B68oZNpGW0SLFmOW5fKaxT/TyTEP0Ew=
Received: by 10.82.188.15 with SMTP id l15mr20536733buf.34.1207094170228;
        Tue, 01 Apr 2008 16:56:10 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Tue, 1 Apr 2008 16:56:10 -0700 (PDT)
In-Reply-To: <47F2BFCD.5070202@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78670>

On 4/1/08, Sam Vilain <sam@vilain.net> wrote:
>  > The ideal situation would be to have
>  > git just manage the version control without having to babysit it, of
>  > course.
>
> I can understand the motivation to write such disparaging remarks;
>  however it may be more productive to come up with good ideas about how
>  it can be made to work better for you, without getting in the way of
>  other users.  patches are even better!

I didn't mean anything disparaging.  I have nothing against babysitters :)

I'll be happy to work on patches once we have some sort of consensus
on what would be desirable.  I think we're slowly getting there.

>  >>  If I understand you correctly, you want to be forced to create a
>  >>  branch and push to that?  I don't think that works well with many
>  >>  developers pushing to a shared repository (my situation),
>  >
>  > Hmm, this is curious.  If you're *not* using submodules, then I don't
>  > think you can push successfully without being on a branch, can you?
>
> Sure, you could;
>
>   git push origin HEAD:branchname

Okay, yes.  But that's just arbitrarily avoiding a local branch and
creating a remote one instead.  I can't imagine a situation where
you'd really want the local branch to be anonymous while the remote
one is not.

When doing a normal "git clone" without submodules, git automatically
creates you a local branch with the same name as the remote's
.git/HEAD - which is rather arbitrary, but even an arbitrary local
name is better than no name, and when checking out a brand new
submodule, there are *no* local branches, so a name conflict is
impossible.

>  > If you 'git checkout -b branchname' inside a submodule, then 'git
>  > push' will do the right thing, so I'm not sure what you'd want to be
>  > more automagical than that.
>
> Well, where did you get the branch name from?  That's the part that
>  requires user intervention.  You could make an educated guess, such as
>  with git name-rev, but it would not necessarily be the right guess - so
>  user confirmation of the choice would be desirable.

Here's a paraphrase of what I suggested earlier.  I don't think it got
a response:

Instead of storing only the commitid of each submodule in the parent
tree, store the current branch name as well.  Use this as a hint to
'submodule update' so that when it checks out commitid, it names the
local branch with the same name as it used to have.  (This is rather
user-friendly since if I check in, push, and clone, my new submodule
checkout will have the same branchname as it used to have.)

Note that the newly checked-out submodule branch will probably have
the same name as as remote branch.  However, the remote branch may
refer to a different commitid (for example, if someone has pushed to
that branch after the parent repo was last updated).  This is exactly
right; it means that if I cd into the submodule and "git push", it'll
fail because I'm not up to date (I can always switch to a new branch
if I want), and if I "git pull", it'll pull from the place where it
should.

This way, cloning a project with submodules will work much like
cloning the parent project; pushing and pulling the parent and the
submodules will do as you expect.

The bad news is that this would require a change to the tree format
for submodules (to contain the branch name).  Is that a problem?  Can
it be done in a backwards-compatible way?

Also, I think this is the only time I've seen a branch name in the
commit/tree structure, which normally refers only to sha-1 hashes.  Is
that a problem?  Is there a better way?

Thanks,

Avery
