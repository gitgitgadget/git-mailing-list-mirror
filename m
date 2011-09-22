From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH v3] Docs: Clarify the --tags option of `git fetch'
Date: Thu, 22 Sep 2011 17:35:02 +0000
Message-ID: <CAMOZ1BtBEHae7x-cn=DtnzwoyC_sYedgFmyNwrDuju+kcJU4hg@mail.gmail.com>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
 <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com>
 <CAMOZ1BuSd52woX0utOQ84gbCzBkZg3ATKnE+7G_BrD5_hUQSiQ@mail.gmail.com>
 <7vwrd1z9it.fsf@alter.siamese.dyndns.org> <CAMOZ1Bvxc+vcofb_KyeLS7Gy=KOtX1SKv72cXA2NtwgYCWA31A@mail.gmail.com>
 <CAMOZ1Bt6gGVd6QuRZduZ4mJ=eoZ9d7xK-WfwZ3G-+oswT0RN_Q@mail.gmail.com>
 <CAH5451nb=DTed2kAVNQmFBbGFJ9zvQAtBE+VCzKqZfGMgYpx5w@mail.gmail.com>
 <CAMOZ1BtPJ_Ddxo1UG2cxJMnGv9y8sR0rAyk3d_5JEz4kLsUQJQ@mail.gmail.com>
 <7vfwjpyzds.fsf@alter.siamese.dyndns.org> <686c38876d5a4ad6bfac67ca77fe9bb3-mfwitten@gmail.com>
 <7v1uv8zen5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>,
	Drew Northup <drew.northup@maine.edu>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Daniel Johnson <computerdruid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 19:35:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6nBX-0000Y0-Ry
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 19:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201Ab1IVRfe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Sep 2011 13:35:34 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46116 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768Ab1IVRfc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2011 13:35:32 -0400
Received: by iaqq3 with SMTP id q3so3008019iaq.19
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 10:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=5hU6aP4kdYufk2ZDkJc5eRwVV/f6r+FHfk5E0u+SfV8=;
        b=XjUQ1dKBVR8KwvanIlaVpN2NF3C2yJXaQ6yGM/i1dAaETGPpzFvBdPks4BLUqF6z0H
         CzogpnG5FJgv6tmPYKPI83i1qoiLbaLwLUaoycHF9k6FFy6PeAmVjS7s+CXWxyC5pQgg
         +jXgIjOyjmyTGVsqxzJPIvRBgMq3woSXoI99o=
Received: by 10.42.95.8 with SMTP id d8mr2635741icn.106.1316712932060; Thu, 22
 Sep 2011 10:35:32 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Thu, 22 Sep 2011 10:35:02 -0700 (PDT)
In-Reply-To: <7v1uv8zen5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181906>

On Thu, Sep 22, 2011 at 17:10, Junio C Hamano <gitster@pobox.com> wrote=
:
> Michael Witten <mfwitten@gmail.com> writes:
>
>> 8<-----------8<-----------8<-----------8<-----------8<-----------8<-=
----------
>>
>> See the discussion starting here:
>>
>> =C2=A0 [PATCH] Clarify that '--tags' fetches tags only
>> =C2=A0 Message-ID: <1314997486-29996-1-git-send-email-anatol.pomozov=
@gmail.com>
>> =C2=A0 http://thread.gmane.org/gmane.comp.version-control.git/180636
>
> It is a good practice to point to earlier discussions while polishing
> patch, and it also is good to include pointers in the commit log mess=
age
> as a supporting material (additional reading), but that is _NOT_ a
> substitute for a properly written commit log message. You need to sta=
te
> what problem you are trying to fix and how the proposed patch fixes i=
t.
>
>> =C2=A0Documentation/fetch-options.txt | =C2=A0 31 ++++++++++++++++++=
+++++--------
>> =C2=A01 files changed, 23 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-o=
ptions.txt
>> index 39d326a..4cc5a80 100644
>> --- a/Documentation/fetch-options.txt
>> +++ b/Documentation/fetch-options.txt
>> @@ -56,14 +56,29 @@ endif::git-pull[]
>> =C2=A0ifndef::git-pull[]
>> =C2=A0-t::
>> =C2=A0--tags::
>> - =C2=A0 =C2=A0 Most of the tags are fetched automatically as branch
>> - =C2=A0 =C2=A0 heads are downloaded, but tags that do not point at
>> - =C2=A0 =C2=A0 objects reachable from the branch heads that are bei=
ng
>> - =C2=A0 =C2=A0 tracked will not be fetched by this mechanism. =C2=A0=
This
>> - =C2=A0 =C2=A0 flag lets all tags and their associated objects be
>> - =C2=A0 =C2=A0 downloaded. The default behavior for a remote may be
>> - =C2=A0 =C2=A0 specified with the remote.<name>.tagopt setting. See
>> - =C2=A0 =C2=A0 linkgit:git-config[1].
>> + =C2=A0 =C2=A0 Most of a remote's tags are fetched automatically as=
 branches are
>> + =C2=A0 =C2=A0 downloaded. However, git does not automatically fetc=
h any tag that,
>> + =C2=A0 =C2=A0 when 'git fetch' completes, would not be reachable f=
rom any local
>> + =C2=A0 =C2=A0 branch head. =C2=A0This option tells git to fetch al=
l tags (and their
>> + =C2=A0 =C2=A0 associated objects).
>
> I would suggest clarifying the beginning of "git fetch --help" like t=
he
> attached patch. With that knowledge at hand, the readers do not need =
the
> fuzzy "Most of ... are fetched" (leaving them wondering "what about t=
he
> rest, and how that Most is determined?"); we only need to say somethi=
ng
> like "fetch all the tags from the remote and store them locally".
>
> =C2=A0Documentation/git-fetch.txt | =C2=A0 21 ++++++++++-----------
> =C2=A01 files changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.tx=
t
> index 60ac8d2..c6c7236 100644
> --- a/Documentation/git-fetch.txt
> +++ b/Documentation/git-fetch.txt
> @@ -19,20 +19,19 @@ SYNOPSIS
>
> =C2=A0DESCRIPTION
> =C2=A0-----------
> -Fetches named heads or tags from one or more other repositories,
> -along with the objects necessary to complete them.
> +Fetches branches and tags (collectively known as 'refs') from one or=
 more
> +other repositories, along with the objects necessary to complete the=
m.
> +Which refs are fetched are determined by the <refspec> arguments, if
> +given. Otherwise the default <refspec> configured for the <repositor=
y>
> +are used (see "REMOTES" section below for how <refspec> works).
>
> -The ref names and their object names of fetched refs are stored
> -in `.git/FETCH_HEAD`. =C2=A0This information is left for a later mer=
ge
> -operation done by 'git merge'.
> +The ref names and their object names are also stored in `.git/FETCH_=
HEAD`.
> +This information is used by 'git pull' that invokes this command.
>
> =C2=A0When <refspec> stores the fetched result in remote-tracking bra=
nches,
> -the tags that point at these branches are automatically
> -followed. =C2=A0This is done by first fetching from the remote using
> -the given <refspec>s, and if the repository has objects that are
> -pointed by remote tags that it does not yet have, then fetch
> -those missing tags. =C2=A0If the other end has tags that point at
> -branches you are not interested in, you will not get them.
> +the tags that point at commits on these branches are also fetched. T=
ags
> +at the remote that point at commits that are not on these remote-tra=
cking
> +branches are not fetched by this mechanism (use `--tags` option to f=
etch them).
>
> =C2=A0'git fetch' can fetch from either a single named repository,
> =C2=A0or from several repositories at once if <group> is given and
>

The only problem is that none of what you say seems to be true.

  * The glossary very distinctly differentiates the
    term `branch' from `branch head'.

  * From skimming the code, it would seem that remote-tracking
    branch [*heads*] are not at all the determining factor for
    whether tags are automatically fetched. Rather, the
    determining factor is much more relaxed: Tags are fetched
    when a refspec's <dst> field is non-empty; it just so
    happens that a <dst> is usually non-empty because at least
    one remote-tracking branch [*head*] is being updated, but
    keep in mind that the branch being updated need not be
    considered a remote-tracking branch.
