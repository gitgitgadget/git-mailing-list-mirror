From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2] Group the default git help message by topic
Date: Tue, 15 Jun 2010 00:49:35 +0800
Message-ID: <AANLkTimNdZO8-lesiGmGm2DeHdhAKbTwzjct-U5P5LLJ@mail.gmail.com>
References: <AANLkTiloErvcWS1hW80cIV9SiWu_7CBdNSx_iAppcGOd@mail.gmail.com>
	<7vbpbeazy5.fsf@alter.siamese.dyndns.org>
	<AANLkTimFUGkYeZaXA7BqX8ghsHX_gGYRK69ScHMXbw2l@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 18:49:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOCr0-0006Ka-QU
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 18:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756188Ab0FNQth convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 12:49:37 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41340 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901Ab0FNQtg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 12:49:36 -0400
Received: by yxl31 with SMTP id 31so1457588yxl.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 09:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=p9tvHO4oMu4vEab3q7g3K+3xxQ7mbULETnULH4EniTM=;
        b=ke13whUhsE4PKxtHTbvgx59Pjc0l/GrEfZ8ooz9BBKc7YedPhUw+RQfKA2TFsMZvAS
         XWUD9VO86BKBKlhA70XcxDO7YhNTeUVd5fn/AhrxWIKXQQvS9ZBlVW+nC0FbxEUuEO3X
         Bq08jkhAO4uUmViMXZTyPwZymiLeYw1t76zf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HX9EPihomEITCFzOm6em4lOOFMb3vBwUHxrj9uiqkdYNTpZTDLmvvMduILGn3qMqDJ
         BTSQhgPTEAs2GoalKrFQ03SeQBkJO83bdnCp13TT/JoXhfybLEuzrebVqKH26VEX0CLc
         QksZ0fYTuudvA3STES5DXvfePBIpD+yPCgGQ0=
Received: by 10.150.165.1 with SMTP id n1mr6827169ybe.253.1276534175471; Mon, 
	14 Jun 2010 09:49:35 -0700 (PDT)
Received: by 10.231.31.141 with HTTP; Mon, 14 Jun 2010 09:49:35 -0700 (PDT)
In-Reply-To: <AANLkTimFUGkYeZaXA7BqX8ghsHX_gGYRK69ScHMXbw2l@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149126>

Hi,

On Mon, Jun 14, 2010 at 11:31 PM, Scott Chacon <schacon@gmail.com> wrot=
e:
> [snip]
> On Sun, Jun 13, 2010 at 11:30 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
> [snip]
> To disambiguate what we're talking about here, this is the output tha=
t
> is generated from this new patch:
>
> Some commonly used git commands per developer roles are:
> =A0* Individual Developer (Standalone)
> =A0 init =A0 =A0 =A0 =A0 =A0Create an empty git repository or reiniti=
alize an existing one
> =A0 show-branch =A0 Show branches and their commits
> =A0 log =A0 =A0 =A0 =A0 =A0 Show commit logs
> =A0 checkout =A0 =A0 =A0Checkout a branch or paths to the working tre=
e
> =A0 add =A0 =A0 =A0 =A0 =A0 Add file contents to the index
> =A0 diff =A0 =A0 =A0 =A0 =A0Show changes between commits, commit and =
working tree, etc
> =A0 commit =A0 =A0 =A0 =A0Record changes to the repository
> =A0 reset =A0 =A0 =A0 =A0 Reset current HEAD to the specified state
> =A0 merge =A0 =A0 =A0 =A0 Join two or more development histories toge=
ther
> =A0 rebase =A0 =A0 =A0 =A0Forward-port local commits to the updated u=
pstream head
> =A0 tag =A0 =A0 =A0 =A0 =A0 Create, list, delete or verify a tag obje=
ct signed with GPG
> =A0* Individual Developer (Participant)
> =A0 clone =A0 =A0 =A0 =A0 Clone a repository into a new directory
> =A0 pull =A0 =A0 =A0 =A0 =A0Fetch from and merge with another reposit=
ory or a local branch
> =A0 push =A0 =A0 =A0 =A0 =A0Update remote refs along with associated =
objects
> =A0 format-patch =A0Prepare patches for e-mail submission
> =A0* Integrator
> =A0 am =A0 =A0 =A0 =A0 =A0 =A0Apply a series of patches from a mailbo=
x
> =A0 revert =A0 =A0 =A0 =A0Revert an existing commit
> =A0* Repository Administration
> =A0 daemon =A0 =A0 =A0 =A0A really simple server for git repositories
> =A0 shell =A0 =A0 =A0 =A0 Restricted login shell for GIT-only SSH acc=
ess

On behalf of people too lazy to patch and compile, like myself - thanks=
=2E

> [snip]
> As you mention next,
> 'show-branches' is second in the list, which is an issue,

Then perhaps we should do something about Documentation/everyday.txt.

> but there
> are several more. =A0'am', 'revert', 'daemon', 'shell', 'rebase' - no=
ne
> of these are appropriate for someone running 'git' and trying to see
> where to start. =A0If we put those aside, all we have is a big list o=
f
> commands again which adds almost no value to what we had before.

They are placed under the titles 'Integrator' and 'Repository
Administration', which, I think, is enough to serve as a 'warning!
git-fu ahead' for users who wish to preserve their sanity.

On 'big' - mercurial, which is associated with 'user-friendly', shows
a list of 50 commands.

>> If readers notice that there are some commands that are out of fashi=
on
>> (e.g. I don't think many people use show-branch anymore in the prese=
nce of
>> "log --oneline --graph" and friends) listed in the "git help" output=
, that
>> is a _good thing_. =A0It will give us an incentive to keep the Every=
day
>> document up to date, and with the effort spent for that, "git help" =
will
>> automatically be kept up to date as well for free ;-)
>
> That's a fine goal, but I feel like it shouldn't be an "everyday"
> document that generates that output, it should be a "beginner"
> document or a "how to start using Git" document that isn't really in
> the Git source.

I, for one, don't think "git help" is the place beginners go to when
they first start off - I sure didn't.

The goal of re-grouping and having a short list of commands is nice,
and I see this as useful for people starting to use git, but not for
people learning it.

--=20
Cheers,
Ray Chuan
