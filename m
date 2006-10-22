From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 16:39:53 +0200
Message-ID: <200610221639.54233.jnareb@gmail.com>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <200610221524.00408.jnareb@gmail.com> <845b6e870610220711t8040a13g3dedbe18a2949ce1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-13
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jan Hudec" <bulb@ucw.cz>, bazaar-ng@lists.canonical.com,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Carl Worth" <cworth@cworth.org>, "Andreas Ericsson" <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 16:39:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbeUL-0006dq-06
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 16:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWJVOjm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 22 Oct 2006 10:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWJVOjm
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 10:39:42 -0400
Received: from hu-out-0506.google.com ([72.14.214.225]:5847 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751020AbWJVOjl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 10:39:41 -0400
Received: by hu-out-0506.google.com with SMTP id 28so811804hub
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 07:39:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WOxwICyagCYfdyXOdDKn1FCJTUddyLA5pRTt+7SNO9P2gkBYCDf6jCnSbCSRG7QM8TLJtjKWnwL7/14GSegUXh49ViJVJEQbQ6LcKSiuThVrC4Zokyq1zgNvfjkeSLDy2fW0eWVHrSbxcvWR5K6SWdJ6yl37uQhycKA8Ua37GGo=
Received: by 10.66.222.9 with SMTP id u9mr5531052ugg;
        Sun, 22 Oct 2006 07:39:39 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id u1sm2684748uge.2006.10.22.07.39.38;
        Sun, 22 Oct 2006 07:39:38 -0700 (PDT)
To: "Erik =?iso-8859-13?q?B=E5gfors?=" <zindar@gmail.com>
User-Agent: KMail/1.9.3
In-Reply-To: <845b6e870610220711t8040a13g3dedbe18a2949ce1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29754>

Erik B=E5gfors wrote:
> On 10/22/06, Jakub Narebski <jnareb@gmail.com> wrote:
>> Erik B=E5gfors wrote:
>>> Jakub Nar=E6bski wrote:
>>
>>>> For example git encourages using many short and longer-lived featu=
re
>>>> branches; I don't see bzr encouraging this workflow.
>>>
>>> Why not? I think it really does.  And due to the fact that merges a=
re
>>> merges and will show up as such, I think it's very suitable for
>>> feature branches.
>>
>> I think I haven't properly explained what "feature branch" means.
>> "Feature branch" is short (or medium) lived branch, created for
>> development of one isolated feature. When feature is in stable
>> stage, we merge feature branch and forget about it. We are not
>> interested in the fact that given feature was developed on given
>> branch. BTW. for example in published git.git repository are
>> only available in the form of "digest" 'pu' (proposed updates)
>> branch.=20
>=20
> That's what I'm talking about too.
> For example, in my bzr bzr-repo I have
> bzr.init-repo-tree/
> bzr.aliases/
> bzr.dev/

Due to the fact that git uses separate namespace for branch names,
and not position on filesystem, one would probably use 'dev'
(or 'master', or perhaps 'next'), 'aliases' and 'init-repo-tree'
as branch names. No need for 'bzr.' prefix to distingush
branches from other directories for user.

Git does use convention like above for bare repositories
(clones of repositories without working tree; working tree
is associated with repository, not with branch), e.g. git.git
or linux-2.6.18.y.git though.

> and others...
> In bzr.aliases for example, I built the support for defining aliases
> in the bzr config file. That was a unique feature that didn't exist i=
n
> any other branch.  The branch survived about 17 days before it was
> merged into bzr.dev.  During that time, I merge in another branch
> twice.  The branch I merged at this time was NOT bzr.dev, but rather
> another branch, from one of the main developers.  The reason I merged
> his branch was that I needed a bugfix (or two? :) ) that he had done,
> but that wasn't approved in bzr.dev yet.

That is also quite common. Merging 'master' into feature branch,
or 'next' into feature branch. One could of course cherry-pick
only the bugfix... can you do this in bzr?

> After a time, his branch was merged into bzr.dev, shortly thereafter,
> so was my branch.
>=20
> After my branch was merged, I forgot about it.  I still have it layin=
g
> around on my computer because it really doesn't take up any extra
> space (since it's in a shared repository), but I really have forgotte=
n
> about it.

Usually after feature branch is merged (or fast-forwarded) we delete
it. All the parentage information is in DAG anyway. We can later
attach new branch with the same name to the point where the branch was.

> This is typically how all features in bzr are created.
> Short/medium/long-lived feature branches.

Like I said, in git.git development we use development branches
(e.g. 'master', 'maint', 'next'), tracking branches (e.g. 'origin',
'linus'), feature branches (e.g. 'jc/pickaxe', 'np/pack'), "helper"
branches storing somewhat unrelated ('html' and 'man' branches for
autogenerated documentation) or unrelated ('todo' for TODO notes)
wtr. code stored to the main project, "digest" branches (e.g. 'pu'
branch in git.git, which is merge of WIP feature branches to be
published, and does not fast-forward), and temporary branches (for
example for shelving current work).

=46rom long, to medium, to short, to extremly short lived.
--=20
Jakub Narebski
Poland
