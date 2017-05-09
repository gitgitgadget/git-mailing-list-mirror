Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 314B62018D
	for <e@80x24.org>; Tue,  9 May 2017 09:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753261AbdEIJVv (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 05:21:51 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:33378 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753293AbdEIJVs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 05:21:48 -0400
Received: by mail-io0-f180.google.com with SMTP id p24so66468442ioi.0
        for <git@vger.kernel.org>; Tue, 09 May 2017 02:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uxImhQR4lnKNJof3rYGalMoaj3qIgnKJlUi5dzVpQvU=;
        b=ty13CRRln1KM42aQB7wHC/tHWqUMtd5zVcBly7MQv8ff4XIY/11NaZxvcqQzh6mshG
         KxSd2axWXCZ2pfqgPQnOG/+qgTITqYn0awZxj5TJARAEPiBpcnfGU74Wq3yvjUAyK9v/
         NX0URe7ZpZgjfhTUN1VYV7HxCReRh+7sSswz7mC0p3YYmM8fi6nzbNivwjxQ0wxsdXCR
         JgOre6xNkkpGC/qkWIypqKQUZj5uMkxWvIwFvZ5hmzh+yPPN6O2/XSX6N3zoMU0q42wm
         uu43WBaPt3Vc9VzRg3FeaZySDMMKBIZcT0nnVXvPm/0XbxDO5Q4xVkKl4CC9E/7CRjQ9
         UJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uxImhQR4lnKNJof3rYGalMoaj3qIgnKJlUi5dzVpQvU=;
        b=ns+911CBXqNk/6+0Nf2RBVN+bcbarZS9PMQadArTUO+/ya9Pba9YKEkIyLYdhmkPf3
         R+vEQXcotcoFzvGGTYZ6eQH4RNT49RHTqt6jflEWx6G/59XUE4qSFpb7D9FZevVAJoAc
         AEIHTSfc4YISVKV2Q+OsiAU0ajRaFMFQ+1xFobk9ULw2CH+B6iVZ/zKtNT/UyEn7R8cN
         fK0hrDqADm7wAncHjauB6U5rtMjhL+PdXWAadVLl5e8fqsVv4TlwjH7C/22vDpSFs1On
         COBv9ykly4ivpiyFe6LUhgHkwBAZoxHsode7rvSYs/GDxefhtWlSyQ239/Rei3fmWnyO
         Bp6g==
X-Gm-Message-State: AODbwcBHx/Ld17teu5mpNOgw98uNYJ/sliYwrqC/o0sv7OKFJRhwZZL9
        qQBktRSINOsSlT9u69so32lukdhENg==
X-Received: by 10.107.138.21 with SMTP id m21mr5199744iod.80.1494321707931;
 Tue, 09 May 2017 02:21:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Tue, 9 May 2017 02:21:27 -0700 (PDT)
In-Reply-To: <3081807.Ek7CimHVI7@cayenne>
References: <20170503162931.30721-1-jn.avila@free.fr> <CACBZZX77Ad120bgTxJd+jqvPEX81BEYWrXnN2TeK+UgT63816w@mail.gmail.com>
 <61C67DC73308BD49B2D4B65072480DBA2BDA5654@DEERLM99EZ1MSX.ww931.my-it-solutions.net>
 <3081807.Ek7CimHVI7@cayenne>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 9 May 2017 11:21:27 +0200
Message-ID: <CACBZZX7kDx_F=b=efuH=m786SEOTy7EZ659tw7a=QpLWojaB5Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] usability: don't ask questions if no reply is required
To:     =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Kerry, Richard" <richard.kerry@atos.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 9, 2017 at 10:18 AM, Jean-No=C3=ABl AVILA <jn.avila@free.fr> wr=
ote:
> Le jeudi 4 mai 2017, 10:14:58 CEST Kerry, Richard a =C3=A9crit :
>>
>> My point was to ensure that where English is used on-screen it should ma=
ke sense, which in this particular case it didn't (a French idiom which, on=
 using an automatic translator, didn't make sense in English).  The same of=
 course applies to other languages used on-screen.
>>
>> I agree about ensuring that the application doesn't elicit a response th=
at it won't, or can't, actually handle.  A rhetorical question is fine, so =
long as it is clear that the program won't accept any further input.
>>
>> Though I don't agree about the issue of the length of words, as presente=
d to a non-native speaker.  Sometimes a longer word can be very specific in=
 its meaning, and can be looked up in a dictionary if the reader is not fam=
iliar with it.  Sometimes using shorter words can result in a less clear me=
aning, or perhaps be an idiomatic usage, which might be missed by a non-nat=
ive speaker.
>>
>
> Thanks. So what's the status of this patch series? I don't buy the idea o=
f rhetorical HMI. That's a sure way to confuse non-native speakers. Please =
note that I kept the questions when there is a following text. Only questio=
ns addressing the user at the end of output have been rephrased.
>
> For the "do you mean" questions, the proposition would then simply be: "t=
he most similar command is:" or "the most similar commands are:".
>
> and then  what about the other patches?

When you submit patches you can monitor the next "What's cooking" mail
for the status. See "ja/do-not..." here:
https://public-inbox.org/git/xmqqlgq77pse.fsf@gitster.mtv.corp.google.com/

It got picked up for the "pu" branch. You can fetch git.git and see it ther=
e.

My feedback on the 3:

* 1/3: Mostly covered above. I did notice after my last comment that
every time gcc wants to suggest you should do something different
(e.g. misspelled variable or macro) it'll say "did you mean?" similar
to what git does now.

While I think this is a rather tragic story of *nix usability ("user
gets asked a question, types yes, gets a few GB/s of y as output") the
main UX problem is surely that the user in question didn't understand
from the terminal output when the program had exited & wasn't
interactive anymore.

But overall this seems like optimizing for a really obscure edge case
at the expense of making the wording more clever. I don't think "did
you mean?" will confuse non-native speakers, as the bug report shows
the user in question has a reasonable command of English, they're
fundimentally confused about how the shell interface works.

* 2/3: Looks great, surprised it took so long for someone to remove
that cutsey but bad message.

* 3/3: I think this partly makes things slightly worse. I.e. now you
get a specific error message about refs being missing, after it shows
you the entire usage info, so you don't know if you e.g. misspelled a
command-line flag or what. I couldn't find any pattern in the existing
shell scripts for "print usage with custom message" thoug.

>> Regards,
>> Richard.
>>
>>
>>
>>
>> Richard Kerry
>> BNCS Engineer, SI SOL Telco & Media Vertical Practice
>> T: +44 (0)20 3618 2669
>> M: +44 (0)7812 325518
>> 4 Triton Square, Regent=E2=80=99s Place, London NW1 3HG
>> richard.kerry@atos.net
>>
>>
>> This e-mail and the documents attached are confidential and intended sol=
ely for the addressee; it may also be privileged. If you receive this e-mai=
l in error, please notify the sender immediately and destroy it. As its int=
egrity cannot be secured on the Internet, the Atos group liability cannot b=
e triggered for the message content. Although the sender endeavours to main=
tain a computer virus-free network, the sender does not warrant that this t=
ransmission is virus-free and will not be liable for any damages resulting =
from any virus transmitted.
>>
>> ________________________________________
>> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason [avarab@gmail.com]
>> Sent: 04 May 2017 10:09
>> To: Kerry, Richard
>> Cc: git@vger.kernel.org
>> Subject: Re: [PATCH v2 1/3] usability: don't ask questions if no reply i=
s required
>>
>> On Thu, May 4, 2017 at 10:52 AM, Kerry, Richard <richard.kerry@atos.net>=
 wrote:
>> >
>> > May I suggest that " The most approaching commands" doesn't make much =
sense as English (I don't think a command can "approach").
>> > Perhaps it should be " The most appropriate commands".
>>
>> I had the same concern, saying "appropriate" is IMO also confusing.
>> The point of this UI is not to point out what you should be running,
>> which "appropriate" implies, but just "we couldn't find what you
>> meant, did you mean one of these?".
>>
>> I think nothing needs to change here. The whole premise here is that a
>> program should never ask a question when you can't give an answer, I
>> think that's nonsense. There's such a thing as a rhetorical question,
>> and sometimes using that form is the most obvious & succinct way to
>> put things.
>>
>> Which is not to say that phrasing these things as a non-question can't
>> be better, but the suggestions so far just seem more complex.
>>
>> Also keep in mind that a huge part of the user base for git using the
>> English UI consists of non-native speakers, and when in doubt we
>> should definitely be picking simpler English like "did you mean?" v.s.
>> alternatives with >10 character more obscure words.
>>
>> > Richard Kerry
>> > BNCS Engineer, SI SOL Telco & Media Vertical Practice
>> >
>> > T: +44 (0)20 3618 2669
>> > M: +44 (0)7812 325518
>> > Lync: +44 (0) 20 3618 0778
>> > Room G300, Stadium House, Wood Lane, London, W12 7TA
>> > richard.kerry@atos.net
>> >
>> >
>> >
>> >
>> > -----Original Message-----
>> > From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On =
Behalf Of Jean-Noel Avila
>> > Sent: Wednesday, May 03, 2017 10:07 PM
>> > To: git@vger.kernel.org
>> > Cc: rashmipai36@gmail.com; Jean-Noel Avila <jn.avila@free.fr>
>> > Subject: [PATCH v2 1/3] usability: don't ask questions if no reply is =
required
>> >
>> > There has been a bug report by a corporate user that stated that "spel=
ling mistake of stash followed by a yes prints character 'y'
>> > infinite times."
>> >
>> > This analysis was false. When the spelling of a command contains error=
s, the git program tries to help the user by providing candidates which are=
 close to the unexisting command. E.g Git prints the
>> > following:
>> >
>> >         git: 'stahs' is not a git command. See 'git --help'.
>> >         Did you mean this?
>> >
>> >         stash
>> >
>> > and then exits.
>> >
>> > The problem with this hint is that it is not formally indicated as an =
hint and the user is in fact encouraged to reply to the question, whereas t=
he Git command is already finished.
>> >
>> > The user was unlucky enough that it was the command he was looking for=
, and replied "yes" on the command line, effectively launching the `yes` pr=
ogram.
>> >
>> > The initial error is that the Git programs, when launched in command-l=
ine mode (without interaction) must not ask questions, because these questi=
ons would normally require a user input as a reply while they won't handle =
indeed. That's a source of confusion on UX level.
>> >
>> > To improve the general usability of the Git suite, the following rule =
was applied:
>> >
>> > if the sentence
>> >  * appears in a non-interactive session
>> >  * is printed last before exit
>> >  * is a question addressing the user ("you")
>> >
>> > the sentence is turned into affirmative and proposes the option.
>> >
>> > The basic rewording of the question sentences has been extended to oth=
er spots found in the source.
>> >
>> > Requested at https://github.com/git/git-scm.com/issues/999 by rpai1
>> >
>> > Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
>> > ---
>> >  builtin/am.c       | 4 ++--
>> >  builtin/checkout.c | 2 +-
>> >  help.c             | 4 ++--
>> >  3 files changed, 5 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/builtin/am.c b/builtin/am.c index a95dd8b4e..f5afa438d 10=
0644
>> > --- a/builtin/am.c
>> > +++ b/builtin/am.c
>> > @@ -1312,7 +1312,7 @@ static int parse_mail(struct am_state *state, co=
nst char *mail)
>> >         }
>> >
>> >         if (is_empty_file(am_path(state, "patch"))) {
>> > -               printf_ln(_("Patch is empty. Was it split wrong?"));
>> > +               printf_ln(_("Patch is empty. It may have been split wr=
ong."));
>> >                 die_user_resolve(state);
>> >         }
>> >
>> > @@ -1940,7 +1940,7 @@ static void am_resolve(struct am_state *state)
>> >
>> >         if (unmerged_cache()) {
>> >                 printf_ln(_("You still have unmerged paths in your ind=
ex.\n"
>> > -                       "Did you forget to use 'git add'?"));
>> > +                       "You might want to use 'git add' on them."));
>> >                 die_user_resolve(state);
>> >         }
>> >
>> > diff --git a/builtin/checkout.c b/builtin/checkout.c index bfa5419f3..=
05037b9b6 100644
>> > --- a/builtin/checkout.c
>> > +++ b/builtin/checkout.c
>> > @@ -1287,7 +1287,7 @@ int cmd_checkout(int argc, const char **argv, co=
nst char *prefix)
>> >                  */
>> >                 if (opts.new_branch && argc =3D=3D 1)
>> >                         die(_("Cannot update paths and switch to branc=
h '%s' at the same time.\n"
>> > -                             "Did you intend to checkout '%s' which c=
an not be resolved as commit?"),
>> > +                             "'%s' can not be resolved as commit, but=
 it should."),
>> >                             opts.new_branch, argv[0]);
>> >
>> >                 if (opts.force_detach)
>> > diff --git a/help.c b/help.c
>> > index bc6cd19cf..4658a55c6 100644
>> > --- a/help.c
>> > +++ b/help.c
>> > @@ -411,8 +411,8 @@ const char *help_unknown_cmd(const char *cmd)
>> >
>> >         if (SIMILAR_ENOUGH(best_similarity)) {
>> >                 fprintf_ln(stderr,
>> > -                          Q_("\nDid you mean this?",
>> > -                             "\nDid you mean one of these?",
>> > +                          Q_("\nThe most approaching command is",
>> > +                             "\nThe most approaching commands are",
>> >                            n));
>> >
>> >                 for (i =3D 0; i < n; i++)
>> > --
>> > 2.12.0
>> >
>> > Atos, Atos Consulting, Worldline and Canopy The Open Cloud Company are=
 trading names used by the Atos group. The following trading entities are r=
egistered in England and Wales: Atos IT Services UK Limited (registered num=
ber 01245534), Atos Consulting Limited (registered number 04312380), Atos W=
orldline UK Limited (registered number 08514184) and Canopy The Open Cloud =
Company Limited (registration number 08011902). The registered office for e=
ach is at 4 Triton Square, Regent=E2=80=99s Place, London, NW1 3HG.The VAT =
No. for each is: GB232327983.
>> >
>> > This e-mail and the documents attached are confidential and intended s=
olely for the addressee, and may contain confidential or privileged informa=
tion. If you receive this e-mail in error, you are not authorised to copy, =
disclose, use or retain it. Please notify the sender immediately and delete=
 this email from your systems. As emails may be intercepted, amended or los=
t, they are not secure. Atos therefore can accept no liability for any erro=
rs or their content. Although Atos endeavours to maintain a virus-free netw=
ork, we do not warrant that this transmission is virus-free and can accept =
no liability for any damages resulting from any virus transmitted. The risk=
s are deemed to be accepted by everyone who communicates with Atos by email=
.
>> Atos, Atos Consulting, Worldline and Canopy The Open Cloud Company are t=
rading names used by the Atos group. The following trading entities are reg=
istered in England and Wales: Atos IT Services UK Limited (registered numbe=
r 01245534), Atos Consulting Limited (registered number 04312380), Atos Wor=
ldline UK Limited (registered number 08514184) and Canopy The Open Cloud Co=
mpany Limited (registration number 08011902). The registered office for eac=
h is at 4 Triton Square, Regent=E2=80=99s Place, London, NW1 3HG.The VAT No=
. for each is: GB232327983.
>>
>> This e-mail and the documents attached are confidential and intended sol=
ely for the addressee, and may contain confidential or privileged informati=
on. If you receive this e-mail in error, you are not authorised to copy, di=
sclose, use or retain it. Please notify the sender immediately and delete t=
his email from your systems. As emails may be intercepted, amended or lost,=
 they are not secure. Atos therefore can accept no liability for any errors=
 or their content. Although Atos endeavours to maintain a virus-free networ=
k, we do not warrant that this transmission is virus-free and can accept no=
 liability for any damages resulting from any virus transmitted. The risks =
are deemed to be accepted by everyone who communicates with Atos by email.
>>
>
>
