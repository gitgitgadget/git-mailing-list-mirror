From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 1/1] doc: format-patch: don't use origin as a branch name
Date: Thu, 14 Aug 2014 20:50:18 +0100
Organization: OPDS
Message-ID: <69D7BD4F1C8A46C2AEBD261FE8317EAC@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	reply-type=response
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "GitList" <git@vger.kernel.org>,
	"Jonathan Nieder" <jrnieder@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 21:50:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XI12W-0004YI-9W
	for gcvg-git-2@plane.gmane.org; Thu, 14 Aug 2014 21:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823AbaHNTuR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2014 15:50:17 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:6126 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753174AbaHNTuQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Aug 2014 15:50:16 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aqm9AIAS7VNZ8YVnPGdsb2JhbABZgw2BKocxgQS+dAgOgkWLMgECAQGBGBcFAQEBATg2g34FAQEECQEBKAEFHgEBIQUGAQEIAgEDEQQBAQo5AQQIEgYHAwwOEwgCAQIDAYgdAwkMqBGPBohrDYVEjR+BVgYBARwzDYMpgR0FimOGOleGCIIvkFmKEDwvgQcIF4EpAQEB
X-IPAS-Result: Aqm9AIAS7VNZ8YVnPGdsb2JhbABZgw2BKocxgQS+dAgOgkWLMgECAQGBGBcFAQEBATg2g34FAQEECQEBKAEFHgEBIQUGAQEIAgEDEQQBAQo5AQQIEgYHAwwOEwgCAQIDAYgdAwkMqBGPBohrDYVEjR+BVgYBARwzDYMpgR0FimOGOleGCIIvkFmKEDwvgQcIF4EpAQEB
X-Header: TalkTalk
X-IronPort-AV: E=Sophos;i="5.01,865,1400022000"; 
   d="scan'208";a="118289485"
Received: from host-89-241-133-103.as13285.net (HELO PhilipOakley) ([89.241.133.103])
  by out1.ip07ir2.opaltelecom.net with SMTP; 14 Aug 2014 20:50:12 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255272>

resending - send mail failure
----- Original Message -----=20
=46rom: "Philip Oakley" <philipoakley@iee.org>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "GitList" <git@vger.kernel.org>; "Jonathan Nieder"=20
<jrnieder@gmail.com>
Sent: Wednesday, August 13, 2014 5:03 PM
Subject: Re: [PATCH v2 1/1] doc: format-patch: don't use origin as a=20
branch name


> From: "Junio C Hamano" <gitster@pobox.com>
> Sent: Tuesday, August 05, 2014 7:19 PM
>> "Philip Oakley" <philipoakley@iee.org> writes:
>>
>>> From: "Junio C Hamano" <gitster@pobox.com>
>>> ...
>>>> Nowhere I am assuming that "the reader is creating paches based on
>>>> wherever someone else had got to".  Sorry, but I have no idea what
>>>> you are complaining about.
>>>
>>> I think we are talking at cross purposes. My starting point is that
>>> (the examples says that) the reader wants to create a patch series
>>> for
>>> a local branch, relative to their <some name> branch which they
>>> branched from...
>>
>> Perhaps what you are missing is that the 'origin' in that example is
>> not "their" <some name> branch.  It is how we used to spell what we
>> call 'refs/remotes/origin/HEAD' these days, a copy of their upstream
>> repository's primary branch.
>
> Aha, I had a revelation as to where you were coming from in terms of=20
> workflow and now see what you were meaning, and how it differed from=20
> my perception of the workflow.
>
> I've documented the different expectations at the end (for those=20
> interested),
> however of more interest is how the confusion happened and what can b=
e
> learned from it. We should be ensuring that the examples avoid any=20
> such
> confusion. It can't be assumed that readers appreciate the history of=
=20
> Git so the starting example should be both simple relative to the=20
> synopsis and give the any necessary background workflow info.
>
>>
>>> (e.g. the example, relative to Git, could have been from
>>> branched from (e.g. the example, relative to Git, could have been
>>> from
>>> a 'pu' picked up a couple of days earlier, when they'd have said=20
>>> 'git
>>> format-patch pu' ;-).
>>
>> Again, if that were a "'pu' picked up a few days earlier, it would
>> not be 'pu', but be 'origin/pu'".
>
> We haven't been clear how the branch is 'picked up' which, to me, is
> partly where the expectation diverged.
>
> The other aspect (to me, a more recent learner of git) is that
> established users were already used to the integrated nature of the
> remote's DAG, while it's a mental extra step for newer users to link
> across the 'refs/remotes/<name>/<branch>' divide, when a lot of advic=
e
> is of the type 'don't work on/with remote branches - there be=20
> dragons'.
>
>>
>>>> The primary reason why 'origin' in the example should be replaced
>>>> with 'origin/master' is because that is the literal adjustment fro=
m
>>>> the pre-separate-remote world order to today's world order.
>>>
>>> I was trying to avoid a literal adjustment to what I'd perceived as=
=20
>>> a
>>> presumed workflow.
>>
>> These are "examples", showing uses of commands in some hopefully
>> common scenarios.  I am not exactly sure what you are aiming at, but
>> if you are trying to strip context and/or background from them and
>> trying to limit them purely to "If you do X, Y happens", the
>> resulting description would lack clues that readers rely on in order
>> to choose the usage pattern of the command that is suitable for
>> their situation, which I do not think is a good change to make.  The
>> readers would be helped more with "You are in state A and want to
>> achieve B. If you do X starting from state A, Y happens, which helps
>> you achieve B.", and that is what examples are about.
>
> At the moment the example already lacked sufficient context.
>>
>> Now, these "where you are and what you want to do" may not be
>> explicitly spelled out to avoid redundancy, and it may be an
>> improvement to enhance the scenario without making them too narrow.
>> But that would be a separate change, and renaming 'origin' (whose
>> modern equivalent is 'origin/master' in the context of these
>> examples) to 'master' alone would not do any such enhancement.
>>
>>>> The
>>>> local branch 'origin' (more specifically, 'refs/heads/origin') use=
d
>>>> to be what we used to keep track of 'master' of the upstream, whic=
h
>>>> we use 'refs/remotes/origin/master' these days.
>>>>
>>>> Side note: DWIMming origin to remotes/origin/HEAD to
>>>> remotes/origin/master was invented to keep supporting this
>>>> "'origin' keeps track of the default upstream" convention
>>>> when we transitioned from the old world order to
>>>> separate-remote layout.
>>>>
>>>> And the reason why 'origin' should not be replaced with 'master' i=
s
>>>> because your 'master' may already have patches from the topic you
>>>> are working on, i.e. in your current branch, that the upstream doe=
s
>>>> not yet have.
>>>
>>> So this a 'develop on master' view, rather than a 'develop on=20
>>> feature
>>> branches' approach? Which could explain the misunderstanding.
>>
>> The new work on the feature branches may be merged in 'master'
>> without ever intending to push 'master' out.  The development is
>> still done on the topic branches that are merged to your local
>> 'master', perhaps for testing purposes and most likely to personally
>> use it before the upstream picks them up.
>>
>> I suspect your misunderstanding is primarily coming from that you
>> may have forgotten, or you may be too new to know, that 'origin' in
>> the example, 'refs/heads/origin', used to be how we tracked the
>> primary branch of the other side back in the era when these examples
>> were written, and refs/remotes/origin/master is used for the same
>> tracking these days.
>> --
>
> I'll look to update the patch for review in the next week or so,=20
> though family/work commitments may delay further.
>
> Philip
>
> Ascii art of the workflows
> Example: Documented
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Build on top workflow; With fetch, not pull, update
>
> The user is working on top of his 'master' branch.
>
>        / -              origin/master
>        =A6
> A - B - C - x - y - z    (local) master  [built upon origin/master]
>         \
>          \
>            D - E - G
>                    ^    (refreshed/fetched from upstream)=20
> origin/master
>
> In both cases (with or without a refresh/fetch from upstream), 'git
> format-patch origin/master' will find commit 'C' as the branch point
> (aka merge-base), and will create patches for commits x, y, and z.
>
> This is the workflow I think Junio is using as his basis for=20
> discussion.
> (This fits well with the historic methods of working with remotes,=20
> which
> were not as explicit differentiated as they are now)
>
> With this simple [easy] view of that worflow then:
> At some point, when the patchs have been accepted upstream, one must
> drop one's current (local) master branch and 'git reset --hard
> origin/master' to become up to date with the upstream.
>
> --
>
> My viewpoint, based on my development on 'pu' style coding would star=
t
> with this view of the described flow. (Here the starting point is tha=
t
> remotes are viewed as 'separate' from local branches.)
>
>        / -              origin/master when development started,
>        =A6                    ref no longer valid.
>        =A6
> A - B - C - x - y - z    (local) master  [built upon origin/master]
> \
>  \
>    B'- C'- D - E - G    (fetched) upstream has rewound/rebased
>                    =A6              (as per some published policy)
>                    =A6
>                    ^    (refreshed) origin/master
>
> Note that here the 'git format-patch origin/master' will find commit=20
> 'A'
> as the branch point (aka merge-base), and produce additional patches=20
> for
> commits B and C as well as the desired x, y & z. Hence my initial=20
> replies.
>
>
> In fact my workflow doesn't develop 'on-top', rather uses the 'featur=
e
> branch' viewpoint, so:
>
>
>        / -              origin/master when development started,
>        =A6                  ref no longer valid.
>        =A6
> A - B - C                (local) master
> =A6       =A6                 [starts at original origin/master]
> =A6        \
> =A6         \ x - y - z    (feature branch) 'current'
> \
>  \
>    B'- C'- D - E - G    upstream has rewound/rebased
>                    =A6     (e.g. as per published policy *note*)
>                    =A6
>                    ^    (refreshed) origin/master
>
> Here the command 'git format-patch origin/master' would be wrong (as
> above), while 'git format-patch master' would be the desired user=20
> action
> (patches just for x, y & z).
>
> *note*: while rewinding 'master' is untypical (if not insane), it can=
=20
> be normal for some published branches, e.g. Git's pu branch.=20
