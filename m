From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 06/25] gettextize: git-fetch formatting messages
Date: Thu, 2 Sep 2010 20:13:19 +0000
Message-ID: <AANLkTi=K5-BtqtXSkiJ=BGa7hs4AEp-DtJm2_bUhctyi@mail.gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
	<1283456446-22577-7-git-send-email-avarab@gmail.com>
	<20100902195936.GA2531@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 22:13:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrGAQ-0000To-8x
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 22:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756770Ab0IBUNW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 16:13:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36908 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab0IBUNV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 16:13:21 -0400
Received: by fxm13 with SMTP id 13so590459fxm.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 13:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xgeKuYT9/zT6mdS7gZRgRHPhsyQJd0s0Cu8FH0Wsa5o=;
        b=bY89Gh40jMNFz0Gxg9gtxlqQ07/aPude7RWdokqXgNv34+6BJoVO5c3RJ3mY+lLRqC
         X2Ixwiru10JlNKePzbBt8DHu4oialsSF6dL4E09pz2wtR/OyBS+WwbhQBROoJ0Pki8dc
         FBU6clWzENkSiuWYhdMrfJQq4NjZjNLJLFQcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ttHbSta+WOINspe/hj32GTyQGeXLESu8Tvrgg+zZpUQwShnMOOiVN9Vfh1iBwHfArY
         RlfpxgFcnd3B4TVpRyf3CPN7jjh+NOT31+Wf67eqyLTWLXrS9PZlh2/3soO36ta0T7O4
         tysCnbM4PA2wpDYJK3qizxf7o5il5ciFU/n8I=
Received: by 10.223.115.207 with SMTP id j15mr6515077faq.105.1283458399147;
 Thu, 02 Sep 2010 13:13:19 -0700 (PDT)
Received: by 10.223.120.14 with HTTP; Thu, 2 Sep 2010 13:13:19 -0700 (PDT)
In-Reply-To: <20100902195936.GA2531@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155193>

On Thu, Sep 2, 2010 at 19:59, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> (+cc: some fetch ui authors, just as a heads up)
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -236,7 +236,7 @@ static int update_local_ref(struct ref *ref,
>> =C2=A0 =C2=A0 =C2=A0 if (!hashcmp(ref->old_sha1, ref->new_sha1)) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (verbosity > 0)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 sprintf(display, "=3D %-*s %-*s -> %s", TRANSPORT_SUMMARY_WIDTH=
,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "[up to date]", REFCOL_WIDTH, remote,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _("[up to date]"), REFCOL_WIDTH, remote=
,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pretty_ref);
>
> Longer-term question: do people like to translate this kind of thing
> (with the arrows and so on) differently for right-to-left languages o=
r
> is that considered overkill?

They do, on a RTL language the arrows are pointing the wrong way
round. But for now I'm not trying to solve RTL issues (or indeed, word
order or plural issues), just getting something basic going.

>> @@ -249,8 +249,8 @@ static int update_local_ref(struct ref *ref,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If this is =
the head, and it's not okay to update
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the head, a=
nd the old value of the head isn't empty...
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(display, "! %-*s=
 %-*s -> %s =C2=A0(can't fetch in current branch)",
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 TRANSPORT_SUMMARY_WIDTH, "[rejected]", REFCOL_WIDTH, remote,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(display, _("! %-=
*s %-*s -> %s =C2=A0(can't fetch in current branch)"),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 TRANSPORT_SUMMARY_WIDTH, _("[rejected]"), REFCOL_WIDTH, remote,
>
> Regardless of the answer, we should probably be either consistently
> translating or not translating it within this patch. =C2=A0e.g. for n=
ot
> translating (though I suspect translating is the better choice):

I added a _() there because there's English language text in the
message. I wouldn't have marked it if it was just "! %-*s %-*s -> %s".

And I haven't split up "! %-*s %-*s -> %s" and " (can't fetch in
current branch)" because I'm trying to make minimal changes so that
this can get through in a timely manner, before I have a mountain of
merge conflicts on my hands.

But yeah, we want to fix that in the future.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sprintf(displa=
y, "! %-*s %-*s -> %s =C2=A0%s",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0TRANSPORT_SUMMARY_WIDTH, "[rejected]", REFCOL_WIDTH, remo=
te,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0pretty_ref, _("(can't fetch in current branch)"));
>
>> @@ -260,8 +260,8 @@ static int update_local_ref(struct ref *ref,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int r;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D s_update_ref(=
"updating tag", ref, 0);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(display, "%=
c %-*s %-*s -> %s%s", r ? '!' : '-',
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 TRANSPORT_SUMMARY_WIDTH, "[tag update]", REFCOL_WIDTH, remote,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 pretty_ref, r ? " =C2=A0(unable to update local ref)" : "");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 TRANSPORT_SUMMARY_WIDTH, _("[tag update]"), REFCOL_WIDTH, remote,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 pretty_ref, r ? _(" =C2=A0(unable to update local ref)") : "");
>
> Maybe we could stick to "%c %-*s %-*s -> %s%s", to make consistent
> translation easier.

Yeah, maybe. That's pretty much the only part of this series that
deals with issues like that. So it's probably worth a fixup.

(I.e. ignore what I said earlier :)
