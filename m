From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Sun, 5 Apr 2009 23:41:03 +0300
Message-ID: <94a0d4530904051341s7e8718c2uced945a16c26670e@mail.gmail.com>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
	 <7vmyausz3h.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530904051228m4e57ec90y810dded41f47e443@mail.gmail.com>
	 <7v7i1yrj3t.fsf@gitster.siamese.dyndns.org>
	 <7vzleuq3ci.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 22:47:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqZB5-0005Su-N9
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 22:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758180AbZDEUlJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 16:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758118AbZDEUlH
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 16:41:07 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:37506 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758080AbZDEUlG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Apr 2009 16:41:06 -0400
Received: by fxm2 with SMTP id 2so1632042fxm.37
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 13:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fYQphcjG60Efd30deDMc5sgB6bya01LBxVzh6h9FbGY=;
        b=LjDGUQsw7ZdJAH0WP4pOWHJ2ASNG9d/r/G+AJ41srrp7BxhNGKFOP1jVy9P0DJ5mhJ
         VlSHfIieanPwRvJCqdKrF6xgWZtkYhNZVc+CEG0HnO8B+yQ+JF1ygsMjP3PBiiIhfr6R
         JVRv4/BoNvxOTaqggvfHkuyLrBCcgpOFsr+wQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nlbi7UoKhBx2PZ2agqzXqvsN8nJed393HcidTfpbehnVHJVmQmFgxTNeCuHK4nuINM
         JUlIE/19kQbpRcNsxhqzG0O+Ov6EEyNlXnMD6tR+32KsEDgx+hskitYIes0XpttTfsmy
         k3XWHH7PeUTMT7nU2bHzVyxdgJF7m2ufjay14=
Received: by 10.86.1.1 with SMTP id 1mr2578076fga.0.1238964063207; Sun, 05 Apr 
	2009 13:41:03 -0700 (PDT)
In-Reply-To: <7vzleuq3ci.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115705>

On Sun, Apr 5, 2009 at 10:59 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> On Sun, Apr 5, 2009 at 10:02 PM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>>
>>>>> This is the list of actions I've mapped:
>>>>>
>>>>> =C2=A0* add: git stage =3D git stage add (git add)
>>>>> =C2=A0* rm: (git rm --cached)
>>>>> =C2=A0* diff: (git rm --cached)
>>>>> =C2=A0* import: stage all files; modified, deleted, new
>>>>> =C2=A0* ls: (git ls-files --stage)
>>>>
>>>> I do not think these are good ideas at all, as it just spreads mor=
e
>>>> confusion, not less.
>>>
>>> Do you agree that there's already a lot of confusion? (stage, cache=
,
>>> index, etc.)
>>>
>>> And do you agree that many git newbies don't use the stage? Actuall=
y
>>> most of them don't even know what it is, and just do "git commit -a=
".
>>>
>>> If so, how do you think these issues should be handled?
>>
>> Perhaps not spreading "stage" even wider? =C2=A0That is the newest c=
onfusing
>> term that caused the most harm.
>
> This probably needs clarification for new people who do not know the
> history.

Thanks for the clarification.

<snip/>

Consider this:

=3D=3D cache =3D=3D

This word is barely used in the English language, perhaps only used in
computing nowadays. The 'cache' is often referred to a place for
temporary storage, the purpose being rapid access. It is usually
transparent to the user.

Git uses the term in a completely different manner and the --cached
option is used in important command such as rm and diff. However,
people rarely use the term "git cache", probably because it
immediately evokes multiple caches for better performances.

=3D=3D index =3D=3D

It is unclear to me what the word means in English language, but it is
generally used as a list of things, the purpose being for easy
retrieval.

Again, git is using the term in a different manner, however it is the
most widely used term to identify the concept "the git index",
probably due to the fact that the word "index" evokes a single entity.
But for some reason it's not used in any important commands as
'--index' or '--indexed'.

=3D=3D stage =3D=3D

The word "stage" is used widely in the English language, and it
immediately evokes a theatrical stage. Generally, it means a different
(upper) level.

In git it is barely used, mostly on the "documentation industry"
probably because it's easier to understand for most people (even
non-native-English speakers).


Ideally the term should evoke the concept of a *single* area that has
no other purpose to differentiate from the contents of the working
directory. Also, the action to add and remove content from this area
should sound natural.

That rules out "cache" since "uncache" makes no sense. Something
similar happens with "unindex", although it doesn't sound completely
bad. On the other hand "stage" and "unstage" sound perfectly fine.

> I do not think "to stage" as the name of the _concept_ is a bad thing
> per-se. =C2=A0But the name of the concept and the command verb (and o=
ption
> name) does not have to agree with each other.
>
> =C2=A0 =C2=A0cf. http://gitster.livejournal.com/19427.html
>
> In retrospect, I think it might have been less problematic if we firm=
ly
> rejected "stage" as an option name, but instead renamed the --cached
> option to --index-only and made the former a synonym to the latter to
> really standardize on "index". =C2=A0I think it still is Ok to use th=
e word "to
> stage" to colloquially call the act of "adding to index", but if we d=
id
> not add that to the UI but kept it strictly at the concept level, it =
would
> have made the UI less confusing, not more.

Why is it so natural to co-relate "stage" to "adding to the index"?
Would such a relation make sense outside of the git world? No. It is
natural to you because you already know what is the "git index"... it
is a *staging* area for commit preparation, logically it's natural to
co-relate this area with the action "to stage".

Please note it is not an _indexing_ area, nor a _caching_ area.

I agree that the internal (plumbing) term does not need to match the
conceptual term (used in documentation, tutorials, etc.), but the
higher level (porcelain) term *must* match in order for new comers to
grasp it quickly and avoid confusion.

I understand there are historic reasons for the names "cache" and
"index" and those should be thought before considering any change.

But also consider that I'm not proposing any big change... the term
"stage" is already being used, and there's already a "git stage"
command. I'm only proposing to add a few more options :)

I would be very pleased if you could at least try the patch for a few
days, and try "git stage diff" (or "git s diff" with an alias). I've
become very fond of "git s" "git s diff" and "git s -p -u".

Cheers.

--=20
=46elipe Contreras
