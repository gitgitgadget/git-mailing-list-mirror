From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 05/21] i18n: sequencer: mark entire sentences for translation
Date: Sat, 21 May 2016 15:15:08 +0200
Message-ID: <CACBZZX790=CtGnryUNrc7S1rpV7D75MOnWnXqd=Smdkojx=ymw@mail.gmail.com>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
 <1463585274-9027-6-git-send-email-vascomalmeida@sapo.pt> <CAPig+cQzsxMMv1XSdStFDs08C3qvb_Ttb4oVeN3T1si85v=f7w@mail.gmail.com>
 <573CD84F.7000207@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Sat May 21 15:15:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b46kg-00024W-Kq
	for gcvg-git-2@plane.gmane.org; Sat, 21 May 2016 15:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbcEUNPa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2016 09:15:30 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:36761 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbcEUNP3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 May 2016 09:15:29 -0400
Received: by mail-qg0-f49.google.com with SMTP id w36so72249214qge.3
        for <git@vger.kernel.org>; Sat, 21 May 2016 06:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=630CGEPCFAD+1oOeFPVTNsXLWn9gTp56GxgsF151VuM=;
        b=lQ8+iuRmj0i4URsDv55rDRRB77V0S/yfaGKbQQdnD5nORnKgI38fUHyyxL7qy+8fLP
         YA3BRuIB+IgAcMc0j/lHqd4gp4Mz2cneksM9HW/xbmUpALRC284ZihYlHVyJ3VhYb54A
         TPzdAgeb0hvXGozWyghcw+OTIitHpBihk1p/SuzzkzMkutzjWPSMliEPQ+tIALAHn0ta
         KrCl56Glay7++Uelg4Ag5+HkGqFg1WjrCNfEUSPbbbjdIbQl2Aj0FLarn7i1bXRiRADJ
         Hlqs12/OHaFjNXhYB0n+0sn52OvKroSAFlGh8goAKEo78hl8JNaBhw3wwQ7J0mcZugAv
         jczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=630CGEPCFAD+1oOeFPVTNsXLWn9gTp56GxgsF151VuM=;
        b=X2/0o4PFHZnvM+NXOhZnyTA+p7zZ11stlbKHVyO3nXt9AhoVxApKT6gBTuJUVYsA6k
         zlHxdKE5g+chHHQMzud9SDsMLDSCIDr3OoJFM8RzqnQMwHX9qRh+9uIAVItZ7/iOacPz
         2Onvd6r6rQNeWUuffihl6njclWVzAiHb62fGt1G36f9RiKpYIUlspLGdssXxM8LJSdeY
         b0mBLKlNb4E05Nepx/HkXQVamDh6XnrkU6Ib0VNUebH+bjN2CsgIyAMRtaZBOQbNbtcM
         r1lQTI7JhXcd+ZbCriKxKK0FmQ4swnTvLbwV9/EGVKHbVS4OWgdvwTWXOzUXeHXz/49Y
         VVIA==
X-Gm-Message-State: AOPr4FXD7KRDO9H+kZ5ne+TIJLbD1eAEt1B9xsdXmjso3nAsEDtNFJu6j3I3opzwjgKKFUBVvKhJsKi0Hvm8vw==
X-Received: by 10.140.108.183 with SMTP id j52mr7912965qgf.90.1463836528507;
 Sat, 21 May 2016 06:15:28 -0700 (PDT)
Received: by 10.55.77.133 with HTTP; Sat, 21 May 2016 06:15:08 -0700 (PDT)
In-Reply-To: <573CD84F.7000207@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295229>

On Wed, May 18, 2016 at 11:02 PM, Vasco Almeida <vascomalmeida@sapo.pt>=
 wrote:
> =C3=80s 19:28 de 18-05-2016, Eric Sunshine escreveu:
>> On Wed, May 18, 2016 at 11:27 AM, Vasco Almeida <vascomalmeida@sapo.=
pt> wrote:
>>> Mark entire sentences of error message rather than assembling one u=
sing
>>> placeholders (e.g. "Cannot %s during a %s"). That would facilitate
>>> translation work.
>>>
>>> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
>>> ---
>>> diff --git a/sequencer.c b/sequencer.c
>>> @@ -697,9 +697,14 @@ static struct commit *parse_insn_line(char *bo=
l, char *eol, struct replay_opts *
>>>         if (action !=3D opts->action) {
>>> -               const char *action_str;
>>> -               action_str =3D action =3D=3D REPLAY_REVERT ? "rever=
t" : "cherry-pick";
>>> -               error(_("Cannot %s during a %s"), action_str, actio=
n_name(opts));
>>> +               if (action =3D=3D REPLAY_REVERT)
>>> +                     error((opts->action =3D=3D REPLAY_REVERT)
>>> +                           ? _("Cannot revert during a another rev=
ert.")
>>> +                           : _("Cannot revert during a cherry-pick=
=2E"));
>>> +               else
>>> +                     error((opts->action =3D=3D REPLAY_REVERT)
>>> +                           ? _("Cannot cherry-pick during a revert=
=2E")
>>> +                           : _("Cannot cherry-pick during another =
cherry-pick."));
>>>                 return NULL;
>>>         }
>>
>> Similar to my comment on patch 3/21, since the "actions" are literal
>> git commands, it's not clear why this change is helpful. Perhaps the
>> commit message needs to do a better job of persuading the reader?
>>
> I agree, I should have explained why this way. As I tried to explain =
on
> patch 3/21, it concerns a) we can't assume what and how does the
> translator translates into her language, so b) give translations free=
dom
> to choose.

=46or what it's worth I agree with you and disagree with Eric here and
Junio in the "[PATCH 03/21] i18n: advice: internationalize message for
conflicts" thread.

Of course there's a trade-off in source code verbosity when you have
to change every occurance of (pseudocode):

    "our %s failed" # %s can be revert or merge

to:

    if (action =3D=3D "merge")
        gettext("our merge failed")
    elsif (action =3D=3D "revert")
        gettext("our revert failed")

But forcing the translator to turn every such occurrence that flows
naturally in English into "the '%s' command failed" leads to a worse
translation.

=46or example, if I ever get around to doing the Icelandic translation
which I've had on my backlog I might translate something like this:

    "You can merge or revert this commit"
    "To merge run 'git merge $commit', to revert run 'git revert $commi=
t'"
    # Subsequently
    "The %s failed" # for %s =3D merge || revert

As:

    "=C3=9E=C3=BA getur getur framkv=C3=A6mt samruna =C3=A1 =C3=BEessar=
i breytingu, e=C3=B0a afturkalla=C3=B0 hana"
    "Til a=C3=B0 framkv=C3=A6ma samruna keyr=C3=B0u 'git merge $commit'=
, til a=C3=B0
afturkalla 'git revert $commit'"
    # Subsequently
    "Samruninn mist=C3=B3kst =C3=BEegar vi=C3=B0 keyr=C3=B0um 'merge' s=
kipunina".
    "Afturk=C3=B6llunnin mist=C3=B3kst =C3=BEegar vi=C3=B0 keyr=C3=B0um=
 'revert' skipunina"

I.e. even though you might be running "git merge" or "git revert" the
UI is talking about those terms in the translated using native terms
for the action of merging or reverting, but referring to the literal
command names in English.

Not accepting changes like these means you have to translate this sort
of stuff like:

    # Same as the above
    "=C3=9E=C3=BA getur getur framkv=C3=A6mt samruna =C3=A1 =C3=BEessar=
i breytingu, e=C3=B0a
afturkalla=C3=B0 hana".
    "Til a=C3=B0 framkv=C3=A6ma samruna keyr=C3=B0u 'git merge $commit'=
, til a=C3=B0
afturkalla 'git revert $commit'"
    # Subsequently
    "Okkur t=C3=B3kst ekki a=C3=B0 keyra 'git %s' skipunina" # %s =3D m=
erge || revert

It just doesn't flow as well, and leads to a more verbose translation.
Now instead of referring to the translated verb I'd already
established I have to just refer to literal command names.

Both this change and the change you submitted in
<1463585274-9027-4-git-send-email-vascomalmeida@sapo.pt> and Junio
didn't like in <xmqqd1ojqciz.fsf@gitster.mtv.corp.google.com> are
actual examples of cases where if I was (finally getting of my ass to)
doing the Icelandic translation I'd take advantage of this.
