Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A97C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 00:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D73613E6
	for <git@archiver.kernel.org>; Thu, 13 May 2021 00:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhEMAWa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 20:22:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63446 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239348AbhEMAV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 20:21:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37E37CFA7A;
        Wed, 12 May 2021 20:20:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hEFqtnAfcKsx
        RDlmX7C8ip4I8gKbg4NRAPZqnneXHq8=; b=FHK+pTI3oi1qyP8oFUYJTqiTK+3r
        UBiwxasvlNxSSDXRiMKbnhhAgnUAAAMPAh/a/Q4gT4Nb/C5OCJhFLY9YLNQDGn4d
        7QlwDHeOQNvn2a6dvt/IBC2SBbQutrHBYnV+6WK7HhIA9i4H3k7FuAn8BzZXIWpe
        DXDsHlD3MVxJCbo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D250CFA79;
        Wed, 12 May 2021 20:20:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8F667CFA78;
        Wed, 12 May 2021 20:20:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dave Huseby <dwh@linuxprogrammer.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        felipe.contreras@gmail.com, stefanmoch@mail.de,
        philipoak@iee.email, bagasdotme@gmail.com, sunshine@sunshineco.com,
        avarab@gmail.com
Subject: Re: [PATCH v3] doc: writing down Git mailing list etiquette
References: <20210512031821.6498-2-dwh@linuxprogrammer.org>
        <20210512233412.10737-1-dwh@linuxprogrammer.org>
Date:   Thu, 13 May 2021 09:20:15 +0900
In-Reply-To: <20210512233412.10737-1-dwh@linuxprogrammer.org> (Dave Huseby's
        message of "Wed, 12 May 2021 16:34:12 -0700")
Message-ID: <xmqqy2cjcwn4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FE277F84-B380-11EB-83C6-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dave Huseby <dwh@linuxprogrammer.org> writes:

>  Documentation/MailingListEtiquette.txt | 93 ++++++++++++++++++++++++++
>  Documentation/SubmittingPatches        | 74 +++++++++++++++++++-
>  2 files changed, 166 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/MailingListEtiquette.txt

I've read this version over, and did not find much that is
objectionable, but as some others said on the previous round, there
may be overlaps and repetitions we'd rather get rid of.  We should
be able to cover discussions around patches in the SubmittingPatches
document without introducing a new document, so all that remains is
what to do with non-patch discussions.  I suspect that it might even
be sufficient to (1) taylor descriptions introduced in this patch
for discussions around patches and reviews, and add it as a new
section to SubmittingPatches and (2) mention that the same principle
applies to non-patch communication in the same section as a sidenote
but obviously others may disagree.

=C3=86var, you also have some updates to SubmittingPatches in flight.

Can I ask you to work with Dave to figure out how well this update
fits in the entire picture as a stakeholder to the document (i.e.
not as "the guilty party who is involved in conflicts", but as
"somebody who has been long enough to be qualified to guide the
evolution of the document, and obviously is interested in improving
the document")?

Thanks.


> diff --git a/Documentation/MailingListEtiquette.txt b/Documentation/Mai=
lingListEtiquette.txt
> new file mode 100644
> index 0000000000..8a383f81a8
> --- /dev/null
> +++ b/Documentation/MailingListEtiquette.txt
> @@ -0,0 +1,93 @@
> +Mailing List Etiquette
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +[[introduction]]
> +=3D=3D Introduction
> +
> +The Git project uses a mailing list and email to coordinate developmen=
t and
> +submit patches. Many other open source projects use web-based forums a=
nd pull
> +requests (PRs) to achieve the same thing. This article focuses entirel=
y on the
> +Git project and the etiquette and unspoken rules that have developed o=
ver the
> +years. What follows are best practices and suggestions for the "proper=
" way to
> +interact via email on the Git mailing list.
> +
> +If you are looking for details on how to submit a patch, that is docum=
ented
> +elsewhere in:
> +
> +- `Documentation/SubmittingPatches`
> +- `Documentation/MyFirstContribution.txt`
> +
> +[[proper-use-of-to-and-cc]]
> +=3D=3D Proper Use of To and Cc
> +
> +The "To:" field is the place to list the people you want to directly i=
nteract
> +with and request responses from and the "Cc:" field is for other peopl=
e that
> +you wish to inform of this conversation. Everybody is welcome to chime=
 in on
> +the thread. When there is no particular person you wish to talk to, th=
e mailing
> +list address is a good catch-all addres to reach everybody and should =
be put in
> +the "To:" field.
> +
> +When replying to an email on the mailing list, put the person you are =
replying
> +to in the "To:" field and all other people in the thread in the "Cc:" =
field,
> +including the mailing list address.
> +
> +The motivation for the above suggestions is to allow recipients to pri=
oritize
> +their incoming messages; they can direct their immediate attention to =
those
> +messages with their names on the "To:" field and the ones with their n=
ames on
> +the "Cc:" field can wait.
> +
> +Make sure to keep everyone involved in the "Cc:" field so that they do=
 not have
> +to be subscribed to the mailing list to receive replies.
> +
> +[[proper-use-of-subject]]
> +=3D=3D Proper Use of the Subject
> +
> +When replying to an email on the list, make sure that the subject of t=
he
> +original email is the subject of your email with "Re:" added to it. So=
 if
> +you reply to an email with subject "first post", the subject of your e=
mail
> +should be "Re: first post".
> +
> +Sometimes email threads diverge into other threads about related, but =
distinct
> +topics. In those cases, the subject like should change to the new topi=
c and
> +include in parenthesis "(Was: <original thread subject>)". So for inst=
ance,
> +if a side thread is created from the "first post" thread example, the =
subject
> +line should be something like "second post (was: first post)" with rep=
lies
> +having the subject "Re: second post (was: first post)".
> +
> +[[use-interleaved-style]]
> +=3D=3D Use Interleaved Style in Replies
> +
> +> A: Because it messes up the order in which people normally read text=
.
> +> Q: Why is top-posting such a bad thing?
> +> A: Top-posting.
> +> Q: What is the most annoying thing in email?
> +
> +When replying to emails, use interleaved style which is also sometimes=
 called
> +an "inline reply". This creates a natural flow for the reader of the r=
eply. They
> +can easily see what the context for the reply is. Also leave only the =
context
> +that is important for your reply and delete the rest.
> +
> +[[do-not-use-mail-followup-to]]
> +=3D=3D Do Not Use Mail-Followup-To
> +
> +When posting to the mailing list, your email client might add a
> +"Mail-Followup-To:" field containing all of the recipients, including =
the
> +mailing list address, but not the sender's email address. This is inte=
nded to
> +prevent the sender from receiving replies twice, once from the replyin=
g person
> +and again from the mailing list.
> +
> +This goes directly against the desired "To:" and "Cc:" etiquette (see =
"Proper
> +Use of To and Cc" above) because "Reply to all"/"group reply" will red=
irect the
> +response to all of the people in the original "Cc:" field instead of g=
oing to
> +the person who sent the message being responded to.
> +
> +Some email clients, such as Mutt (see Disable Mail-Followup-To in the =
Mutt
> +section below) are configured by default to add "Mail-Followup-To:" fi=
elds and
> +to honor existing "Mail-Followup-To:" fields. It is best to disable bo=
th.
> +
> +[[enable-plain-text-mode]]
> +=3D=3D Enable Plain Text Mode
> +
> +The Git mailing list software rejects email sent in text/html format. =
It is
> +important that your email client is set to create text/plain emails to=
 ensure
> +delivery.
> diff --git a/Documentation/SubmittingPatches b/Documentation/Submitting=
Patches
> index 55287d72e0..4f8b9f24ee 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -433,7 +433,7 @@ help you find out who they are.
> =20
>  In any time between the (2)-(3) cycle, the maintainer may pick it up
>  from the list and queue it to `seen`, in order to make it easier for
> -people play with it without having to pick up and apply the patch to
> +people to play with it without having to pick up and apply the patch t=
o
>  their trees themselves.
> =20
>  [[patch-status]]
> @@ -450,6 +450,46 @@ their trees themselves.
>    entitled "What's cooking in git.git" and "What's in git.git" giving
>    the status of various proposed changes.
> =20
> +[[patches-that-receive-no-response]]
> +=3D=3D Patches that Receive No Response
> +
> +If you sent a patch and you did not hear any response from anybody for
> +several days, it could be that your patch was totally uninteresting,
> +but it also is possible that it was simply lost in the noise.  Please
> +do not hesitate to send a reminder message in such a case.  Messages
> +getting lost in the noise may be a sign that those who can evaluate
> +your patch don't have enough mental/time bandwidth to process them
> +right at the moment, and it often helps to wait until the list traffic
> +becomes calmer before sending such a reminder.
> +
> +Alternatives to sending direct reminders are:
> +
> +* Wait for the next "What's cooking in git.git" email to see if your p=
atch
> +  series was mentioned and replying to that email with a note pointing=
 out that
> +  your patch series has been overlooked.
> +
> +* Attend the weekly "stand-up" meeting held in the "#git-devel" channe=
l on
> +  irc.freenode.net and bring it up then.
> +
> +[[send-merge-ready-patches-to-the-maintainer]]
> +=3D=3D Send Merge-Ready Patches to the Maintainer
> +
> +Once a patch has achieved consensus and all stakeholders are satisfied=
 and
> +everything is ready for merging, you have two main options for getting=
 your
> +patch noticed by the maintainer.
> +
> +1. Submit a new, final, version of the patch with an accurate list of =
commit
> +   trailers. Make this submission "To:" the maintainer, "In-Reply-To:"=
 the
> +   previous version of the patch, and add everybody concerned, includi=
ng the
> +   mailing list address to the "Cc:" field. This is a nice way to redu=
ce the
> +   amount of work the maintainer must do to merge the patch while also=
 getting
> +   their attention.
> +
> +2. Creating a "group reply"/"Reply to all" email to the latest patch s=
eries
> +   with the maintainer in the "To:" field. This is sometimes referred =
to as a
> +   "review ping" email and is appropriate if the patch requires no mor=
e work
> +   and is in its final state with an accurate list of commit trailers.
> +
>  [[travis]]
>  =3D=3D GitHub-Travis CI hints
> =20
> @@ -510,6 +550,38 @@ first patch.\n", if you really want to put in the =
patch e-mail,
>  should come after the three-dash line that signals the end of the
>  commit message.
> =20
> +=3D=3D=3D Mutt
> +
> +[[known-mailing-lists]]
> +=3D=3D=3D=3D Known Mailing Lists
> +
> +Mutt has the ability to change its behavior when replying to a mailing=
 list. You
> +must specify mailing list addresses using the `subscribe` keyword in y=
our Mutt
> +configuration:
> +
> +**~/.muttrc:**
> +```
> +# tell Mutt about the Git mailing list
> +subscribe git@vger.kernel.org
> +```
> +
> +[[disable-mail-followup-to]]
> +=3D=3D=3D=3D Disable Mail-Followup-To
> +
> +By default, when replying to mailing lists, Mutt automatically generat=
es
> +"Mail-Followup-To:" fields. To fix this, disable the generation of the=
 field
> +in your Mutt configuration. It is also a good idea to disable honoring=
 any
> +"Mail-Followup-To:" field so that your "group reply" operations are co=
rrectly
> +addressed.
> +
> +**~/.muttrc:**
> +```
> +# disable Mail-Followup-To header
> +unset followup_to
> +
> +# disable honoring Mail-Followup-To header
> +unset honor_followup_to
> +```
> =20
>  =3D=3D=3D Pine
