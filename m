From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH v3] Docs: Clarify the --tags option of `git fetch'
Date: Thu, 22 Sep 2011 17:38:00 +0000
Message-ID: <CAMOZ1BtHUtZvQJMM0yhOumb8aq7NnHv8udPOVdciQE3=jNGq4Q@mail.gmail.com>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
 <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com>
 <CAMOZ1BuSd52woX0utOQ84gbCzBkZg3ATKnE+7G_BrD5_hUQSiQ@mail.gmail.com>
 <7vwrd1z9it.fsf@alter.siamese.dyndns.org> <CAMOZ1Bvxc+vcofb_KyeLS7Gy=KOtX1SKv72cXA2NtwgYCWA31A@mail.gmail.com>
 <CAMOZ1Bt6gGVd6QuRZduZ4mJ=eoZ9d7xK-WfwZ3G-+oswT0RN_Q@mail.gmail.com>
 <CAH5451nb=DTed2kAVNQmFBbGFJ9zvQAtBE+VCzKqZfGMgYpx5w@mail.gmail.com>
 <CAMOZ1BtPJ_Ddxo1UG2cxJMnGv9y8sR0rAyk3d_5JEz4kLsUQJQ@mail.gmail.com>
 <7vfwjpyzds.fsf@alter.siamese.dyndns.org> <686c38876d5a4ad6bfac67ca77fe9bb3-mfwitten@gmail.com>
 <7v1uv8zen5.fsf@alter.siamese.dyndns.org> <CAMOZ1BtBEHae7x-cn=DtnzwoyC_sYedgFmyNwrDuju+kcJU4hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>,
	Drew Northup <drew.northup@maine.edu>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Daniel Johnson <computerdruid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 19:38:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6nEP-0002Mu-L1
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 19:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254Ab1IVRig convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Sep 2011 13:38:36 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63444 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987Ab1IVRig convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2011 13:38:36 -0400
Received: by gxk6 with SMTP id 6so2139894gxk.19
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 10:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=gFhnvDOQJyb0JKqBuHVLNztqr+O4hUi/vtN3JGnwF9I=;
        b=b0+EPYFJjhAX5fzJeF5qOW5R2T9mtgET49Gp+SuFwLEPzpqx84JBBwZy9V36kfPeK9
         EJD6q6bnAl0XJPvnCWEE4JsRfdAPuxtvhILm2a5XEWcxFllnoshc41sIJMvzsns8zDFV
         gMk4iqhnZLBs/JCxwIF4m9qN+IYsG5jJNCOnY=
Received: by 10.42.95.8 with SMTP id d8mr2641168icn.106.1316713112250; Thu, 22
 Sep 2011 10:38:32 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Thu, 22 Sep 2011 10:38:00 -0700 (PDT)
In-Reply-To: <CAMOZ1BtBEHae7x-cn=DtnzwoyC_sYedgFmyNwrDuju+kcJU4hg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181907>

On Thu, Sep 22, 2011 at 17:35, Michael Witten <mfwitten@gmail.com> wrot=
e:
> On Thu, Sep 22, 2011 at 17:10, Junio C Hamano <gitster@pobox.com> wro=
te:
>> Michael Witten <mfwitten@gmail.com> writes:
>>
>>> 8<-----------8<-----------8<-----------8<-----------8<-----------8<=
-----------
>>>
>>> See the discussion starting here:
>>>
>>> =C2=A0 [PATCH] Clarify that '--tags' fetches tags only
>>> =C2=A0 Message-ID: <1314997486-29996-1-git-send-email-anatol.pomozo=
v@gmail.com>
>>> =C2=A0 http://thread.gmane.org/gmane.comp.version-control.git/18063=
6
>>
>> It is a good practice to point to earlier discussions while polishin=
g
>> patch, and it also is good to include pointers in the commit log mes=
sage
>> as a supporting material (additional reading), but that is _NOT_ a
>> substitute for a properly written commit log message. You need to st=
ate
>> what problem you are trying to fix and how the proposed patch fixes =
it.
>>
>>> =C2=A0Documentation/fetch-options.txt | =C2=A0 31 +++++++++++++++++=
++++++--------
>>> =C2=A01 files changed, 23 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-=
options.txt
>>> index 39d326a..4cc5a80 100644
>>> --- a/Documentation/fetch-options.txt
>>> +++ b/Documentation/fetch-options.txt
>>> @@ -56,14 +56,29 @@ endif::git-pull[]
>>> =C2=A0ifndef::git-pull[]
>>> =C2=A0-t::
>>> =C2=A0--tags::
>>> - =C2=A0 =C2=A0 Most of the tags are fetched automatically as branc=
h
>>> - =C2=A0 =C2=A0 heads are downloaded, but tags that do not point at
>>> - =C2=A0 =C2=A0 objects reachable from the branch heads that are be=
ing
>>> - =C2=A0 =C2=A0 tracked will not be fetched by this mechanism. =C2=A0=
This
>>> - =C2=A0 =C2=A0 flag lets all tags and their associated objects be
>>> - =C2=A0 =C2=A0 downloaded. The default behavior for a remote may b=
e
>>> - =C2=A0 =C2=A0 specified with the remote.<name>.tagopt setting. Se=
e
>>> - =C2=A0 =C2=A0 linkgit:git-config[1].
>>> + =C2=A0 =C2=A0 Most of a remote's tags are fetched automatically a=
s branches are
>>> + =C2=A0 =C2=A0 downloaded. However, git does not automatically fet=
ch any tag that,
>>> + =C2=A0 =C2=A0 when 'git fetch' completes, would not be reachable =
from any local
>>> + =C2=A0 =C2=A0 branch head. =C2=A0This option tells git to fetch a=
ll tags (and their
>>> + =C2=A0 =C2=A0 associated objects).
>>
>> I would suggest clarifying the beginning of "git fetch --help" like =
the
>> attached patch. With that knowledge at hand, the readers do not need=
 the
>> fuzzy "Most of ... are fetched" (leaving them wondering "what about =
the
>> rest, and how that Most is determined?"); we only need to say someth=
ing
>> like "fetch all the tags from the remote and store them locally".
>>
>> =C2=A0Documentation/git-fetch.txt | =C2=A0 21 ++++++++++-----------
>> =C2=A01 files changed, 10 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.t=
xt
>> index 60ac8d2..c6c7236 100644
>> --- a/Documentation/git-fetch.txt
>> +++ b/Documentation/git-fetch.txt
>> @@ -19,20 +19,19 @@ SYNOPSIS
>>
>> =C2=A0DESCRIPTION
>> =C2=A0-----------
>> -Fetches named heads or tags from one or more other repositories,
>> -along with the objects necessary to complete them.
>> +Fetches branches and tags (collectively known as 'refs') from one o=
r more
>> +other repositories, along with the objects necessary to complete th=
em.
>> +Which refs are fetched are determined by the <refspec> arguments, i=
f
>> +given. Otherwise the default <refspec> configured for the <reposito=
ry>
>> +are used (see "REMOTES" section below for how <refspec> works).
>>
>> -The ref names and their object names of fetched refs are stored
>> -in `.git/FETCH_HEAD`. =C2=A0This information is left for a later me=
rge
>> -operation done by 'git merge'.
>> +The ref names and their object names are also stored in `.git/FETCH=
_HEAD`.
>> +This information is used by 'git pull' that invokes this command.
>>
>> =C2=A0When <refspec> stores the fetched result in remote-tracking br=
anches,
>> -the tags that point at these branches are automatically
>> -followed. =C2=A0This is done by first fetching from the remote usin=
g
>> -the given <refspec>s, and if the repository has objects that are
>> -pointed by remote tags that it does not yet have, then fetch
>> -those missing tags. =C2=A0If the other end has tags that point at
>> -branches you are not interested in, you will not get them.
>> +the tags that point at commits on these branches are also fetched. =
Tags
>> +at the remote that point at commits that are not on these remote-tr=
acking
>> +branches are not fetched by this mechanism (use `--tags` option to =
fetch them).
>>
>> =C2=A0'git fetch' can fetch from either a single named repository,
>> =C2=A0or from several repositories at once if <group> is given and
>>
>
> The only problem is that none of what you say seems to be true.
>
> =C2=A0* The glossary very distinctly differentiates the
> =C2=A0 =C2=A0term `branch' from `branch head'.
>
> =C2=A0* From skimming the code, it would seem that remote-tracking
> =C2=A0 =C2=A0branch [*heads*] are not at all the determining factor f=
or
> =C2=A0 =C2=A0whether tags are automatically fetched. Rather, the
> =C2=A0 =C2=A0determining factor is much more relaxed: Tags are fetche=
d
> =C2=A0 =C2=A0when a refspec's <dst> field is non-empty; it just so
> =C2=A0 =C2=A0happens that a <dst> is usually non-empty because at lea=
st
> =C2=A0 =C2=A0one remote-tracking branch [*head*] is being updated, bu=
t
> =C2=A0 =C2=A0keep in mind that the branch being updated need not be
> =C2=A0 =C2=A0considered a remote-tracking branch.

DAMNIT

That last bit should use the world `head':

  but keep in mind that the branch *head* being updated
  need not be considered a remote-tracking branch [*head*].
