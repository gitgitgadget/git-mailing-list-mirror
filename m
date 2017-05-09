Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5848F20188
	for <e@80x24.org>; Tue,  9 May 2017 08:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751703AbdEIISS convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 9 May 2017 04:18:18 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:18861 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751131AbdEIISO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 04:18:14 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e35:2ef1:f910:5006:1621:c385:7777])
        by smtp2-g21.free.fr (Postfix) with ESMTPS id 12EF020040D;
        Tue,  9 May 2017 10:18:11 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     "Kerry, Richard" <richard.kerry@atos.net>
Subject: Re: [PATCH v2 1/3] usability: don't ask questions if no reply is required
Date:   Tue, 09 May 2017 10:18:11 +0200
Message-ID: <3081807.Ek7CimHVI7@cayenne>
User-Agent: KMail/5.2.3 (Linux/4.9.0-2-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <61C67DC73308BD49B2D4B65072480DBA2BDA5654@DEERLM99EZ1MSX.ww931.my-it-solutions.net>
References: <20170503162931.30721-1-jn.avila@free.fr> <CACBZZX77Ad120bgTxJd+jqvPEX81BEYWrXnN2TeK+UgT63816w@mail.gmail.com> <61C67DC73308BD49B2D4B65072480DBA2BDA5654@DEERLM99EZ1MSX.ww931.my-it-solutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le jeudi 4 mai 2017, 10:14:58 CEST Kerry, Richard a écrit :
> 
> My point was to ensure that where English is used on-screen it should make sense, which in this particular case it didn't (a French idiom which, on using an automatic translator, didn't make sense in English).  The same of course applies to other languages used on-screen.
> 
> I agree about ensuring that the application doesn't elicit a response that it won't, or can't, actually handle.  A rhetorical question is fine, so long as it is clear that the program won't accept any further input.
> 
> Though I don't agree about the issue of the length of words, as presented to a non-native speaker.  Sometimes a longer word can be very specific in its meaning, and can be looked up in a dictionary if the reader is not familiar with it.  Sometimes using shorter words can result in a less clear meaning, or perhaps be an idiomatic usage, which might be missed by a non-native speaker.
> 

Thanks. So what's the status of this patch series? I don't buy the idea of rhetorical HMI. That's a sure way to confuse non-native speakers. Please note that I kept the questions when there is a following text. Only questions addressing the user at the end of output have been rephrased.

For the "do you mean" questions, the proposition would then simply be: "the most similar command is:" or "the most similar commands are:".

and then  what about the other patches?

Thanks


> Regards,
> Richard.
> 
> 
> 
> 
> Richard Kerry
> BNCS Engineer, SI SOL Telco & Media Vertical Practice
> T: +44 (0)20 3618 2669
> M: +44 (0)7812 325518
> 4 Triton Square, Regent’s Place, London NW1 3HG
> richard.kerry@atos.net
> 
> 
> This e-mail and the documents attached are confidential and intended solely for the addressee; it may also be privileged. If you receive this e-mail in error, please notify the sender immediately and destroy it. As its integrity cannot be secured on the Internet, the Atos group liability cannot be triggered for the message content. Although the sender endeavours to maintain a computer virus-free network, the sender does not warrant that this transmission is virus-free and will not be liable for any damages resulting from any virus transmitted.
> 
> ________________________________________
> From: Ævar Arnfjörð Bjarmason [avarab@gmail.com]
> Sent: 04 May 2017 10:09
> To: Kerry, Richard
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH v2 1/3] usability: don't ask questions if no reply is required
> 
> On Thu, May 4, 2017 at 10:52 AM, Kerry, Richard <richard.kerry@atos.net> wrote:
> >
> > May I suggest that " The most approaching commands" doesn't make much sense as English (I don't think a command can "approach").
> > Perhaps it should be " The most appropriate commands".
> 
> I had the same concern, saying "appropriate" is IMO also confusing.
> The point of this UI is not to point out what you should be running,
> which "appropriate" implies, but just "we couldn't find what you
> meant, did you mean one of these?".
> 
> I think nothing needs to change here. The whole premise here is that a
> program should never ask a question when you can't give an answer, I
> think that's nonsense. There's such a thing as a rhetorical question,
> and sometimes using that form is the most obvious & succinct way to
> put things.
> 
> Which is not to say that phrasing these things as a non-question can't
> be better, but the suggestions so far just seem more complex.
> 
> Also keep in mind that a huge part of the user base for git using the
> English UI consists of non-native speakers, and when in doubt we
> should definitely be picking simpler English like "did you mean?" v.s.
> alternatives with >10 character more obscure words.
> 
> > Richard Kerry
> > BNCS Engineer, SI SOL Telco & Media Vertical Practice
> >
> > T: +44 (0)20 3618 2669
> > M: +44 (0)7812 325518
> > Lync: +44 (0) 20 3618 0778
> > Room G300, Stadium House, Wood Lane, London, W12 7TA
> > richard.kerry@atos.net
> >
> >
> >
> >
> > -----Original Message-----
> > From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On Behalf Of Jean-Noel Avila
> > Sent: Wednesday, May 03, 2017 10:07 PM
> > To: git@vger.kernel.org
> > Cc: rashmipai36@gmail.com; Jean-Noel Avila <jn.avila@free.fr>
> > Subject: [PATCH v2 1/3] usability: don't ask questions if no reply is required
> >
> > There has been a bug report by a corporate user that stated that "spelling mistake of stash followed by a yes prints character 'y'
> > infinite times."
> >
> > This analysis was false. When the spelling of a command contains errors, the git program tries to help the user by providing candidates which are close to the unexisting command. E.g Git prints the
> > following:
> >
> >         git: 'stahs' is not a git command. See 'git --help'.
> >         Did you mean this?
> >
> >         stash
> >
> > and then exits.
> >
> > The problem with this hint is that it is not formally indicated as an hint and the user is in fact encouraged to reply to the question, whereas the Git command is already finished.
> >
> > The user was unlucky enough that it was the command he was looking for, and replied "yes" on the command line, effectively launching the `yes` program.
> >
> > The initial error is that the Git programs, when launched in command-line mode (without interaction) must not ask questions, because these questions would normally require a user input as a reply while they won't handle indeed. That's a source of confusion on UX level.
> >
> > To improve the general usability of the Git suite, the following rule was applied:
> >
> > if the sentence
> >  * appears in a non-interactive session
> >  * is printed last before exit
> >  * is a question addressing the user ("you")
> >
> > the sentence is turned into affirmative and proposes the option.
> >
> > The basic rewording of the question sentences has been extended to other spots found in the source.
> >
> > Requested at https://github.com/git/git-scm.com/issues/999 by rpai1
> >
> > Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
> > ---
> >  builtin/am.c       | 4 ++--
> >  builtin/checkout.c | 2 +-
> >  help.c             | 4 ++--
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/builtin/am.c b/builtin/am.c index a95dd8b4e..f5afa438d 100644
> > --- a/builtin/am.c
> > +++ b/builtin/am.c
> > @@ -1312,7 +1312,7 @@ static int parse_mail(struct am_state *state, const char *mail)
> >         }
> >
> >         if (is_empty_file(am_path(state, "patch"))) {
> > -               printf_ln(_("Patch is empty. Was it split wrong?"));
> > +               printf_ln(_("Patch is empty. It may have been split wrong."));
> >                 die_user_resolve(state);
> >         }
> >
> > @@ -1940,7 +1940,7 @@ static void am_resolve(struct am_state *state)
> >
> >         if (unmerged_cache()) {
> >                 printf_ln(_("You still have unmerged paths in your index.\n"
> > -                       "Did you forget to use 'git add'?"));
> > +                       "You might want to use 'git add' on them."));
> >                 die_user_resolve(state);
> >         }
> >
> > diff --git a/builtin/checkout.c b/builtin/checkout.c index bfa5419f3..05037b9b6 100644
> > --- a/builtin/checkout.c
> > +++ b/builtin/checkout.c
> > @@ -1287,7 +1287,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
> >                  */
> >                 if (opts.new_branch && argc == 1)
> >                         die(_("Cannot update paths and switch to branch '%s' at the same time.\n"
> > -                             "Did you intend to checkout '%s' which can not be resolved as commit?"),
> > +                             "'%s' can not be resolved as commit, but it should."),
> >                             opts.new_branch, argv[0]);
> >
> >                 if (opts.force_detach)
> > diff --git a/help.c b/help.c
> > index bc6cd19cf..4658a55c6 100644
> > --- a/help.c
> > +++ b/help.c
> > @@ -411,8 +411,8 @@ const char *help_unknown_cmd(const char *cmd)
> >
> >         if (SIMILAR_ENOUGH(best_similarity)) {
> >                 fprintf_ln(stderr,
> > -                          Q_("\nDid you mean this?",
> > -                             "\nDid you mean one of these?",
> > +                          Q_("\nThe most approaching command is",
> > +                             "\nThe most approaching commands are",
> >                            n));
> >
> >                 for (i = 0; i < n; i++)
> > --
> > 2.12.0
> >
> > Atos, Atos Consulting, Worldline and Canopy The Open Cloud Company are trading names used by the Atos group. The following trading entities are registered in England and Wales: Atos IT Services UK Limited (registered number 01245534), Atos Consulting Limited (registered number 04312380), Atos Worldline UK Limited (registered number 08514184) and Canopy The Open Cloud Company Limited (registration number 08011902). The registered office for each is at 4 Triton Square, Regent’s Place, London, NW1 3HG.The VAT No. for each is: GB232327983.
> >
> > This e-mail and the documents attached are confidential and intended solely for the addressee, and may contain confidential or privileged information. If you receive this e-mail in error, you are not authorised to copy, disclose, use or retain it. Please notify the sender immediately and delete this email from your systems. As emails may be intercepted, amended or lost, they are not secure. Atos therefore can accept no liability for any errors or their content. Although Atos endeavours to maintain a virus-free network, we do not warrant that this transmission is virus-free and can accept no liability for any damages resulting from any virus transmitted. The risks are deemed to be accepted by everyone who communicates with Atos by email.
> Atos, Atos Consulting, Worldline and Canopy The Open Cloud Company are trading names used by the Atos group. The following trading entities are registered in England and Wales: Atos IT Services UK Limited (registered number 01245534), Atos Consulting Limited (registered number 04312380), Atos Worldline UK Limited (registered number 08514184) and Canopy The Open Cloud Company Limited (registration number 08011902). The registered office for each is at 4 Triton Square, Regent’s Place, London, NW1 3HG.The VAT No. for each is: GB232327983.
> 
> This e-mail and the documents attached are confidential and intended solely for the addressee, and may contain confidential or privileged information. If you receive this e-mail in error, you are not authorised to copy, disclose, use or retain it. Please notify the sender immediately and delete this email from your systems. As emails may be intercepted, amended or lost, they are not secure. Atos therefore can accept no liability for any errors or their content. Although Atos endeavours to maintain a virus-free network, we do not warrant that this transmission is virus-free and can accept no liability for any damages resulting from any virus transmitted. The risks are deemed to be accepted by everyone who communicates with Atos by email.
> 


