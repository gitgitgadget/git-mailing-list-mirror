Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C3511F859
	for <e@80x24.org>; Wed, 31 Aug 2016 18:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933932AbcHaShP (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 14:37:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:62272 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933926AbcHaShL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 14:37:11 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MZCQ8-1bOkUU0B4e-00KxqH; Wed, 31 Aug 2016 20:36:54
 +0200
Date:   Wed, 31 Aug 2016 20:36:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/22] sequencer: remove overzealous assumption
In-Reply-To: <09fd1436-301a-b0e1-c32a-81a47e4eb351@gmail.com>
Message-ID: <alpine.DEB.2.20.1608311706400.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <3c8c60e0799fdf176c72e7e17c257d33b2a362bc.1472457609.git.johannes.schindelin@gmx.de> <09fd1436-301a-b0e1-c32a-81a47e4eb351@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-335878806-1472668614=:129229"
X-Provags-ID: V03:K0:tYxEZWtq+KcC9viy/QMHTZKhMXwG6/aH7yhwGqhIJwEyQ9f9tre
 U2AuXlc1J3P/3Z7CSyXs+M2+aXNW8zx4huE08SrnoSk5F/0Y7gMxjQcBUz04KLiq7LEnE24
 6T878yHqcrf8uYcFY52sY0SCX24P/Wa5KVw32Epd9lPrSwl+7h5Rz16VBjQjcRc+U8lPlMh
 X7kJ0md7RLDogbnqB6vug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LD9gcA9TFUk=:42EiXeDazokTndmNAgJLR4
 D3kycZGgwkjG0PthZCn94d+va6Ct5HlnGP5BKU6FjwFFPOObk9SkMpaOe0jEaARRYSF+QOdPO
 olWy4EO2vfLDnBJXrGGcKfOn51bS64l2JRJY4yxTsIH6T22P+RKPqg7VvCLNgMNWmeywIDDV1
 eO00J1CTbEuvD8Qkl05XtiRW484sm6bdHUp9kAW7i39ZwWEYvr2YknSMX9OUwIvyD17UYFh1y
 cOZwx3lEvIY0A7VjmXQTuXbC9kNBWk8ZjEMgMpHbaYLn2UEtHqBcN5+aN07dZpCv+588/Ih3W
 RPYmJ8+IN1/r5kuRuJlLhCo3+eJrs1jlUK41OrrmRu+UBvlXggFhEFj3ChCD2FiWBXtzIN92s
 NnUFhKHe+3KcEbj2s7v5sxBm3zrq0DniZHCwcZUyTgqCptL9RHW3Vq7hYNj9jsFiFXlMSF2bT
 01ZRb7Zu3Dn0GepMbUdCo3JwzJg8V0Hhia5TWbaTV/o+t5CVNWnt90BnzPdZ4sSn/s6sfVZFp
 KwIRnIuCFC+U+TR0mxLUpXTqbb3tivOngX4K2h7HHY7hj7X0bK2VUreGhVbDyjMN9KG5gpNZ8
 uobT3lGjfwO2GXV3tkh5sLDdQnAwxExG2kJRaiPs9BFbvZzOMs+Vk5plDIkj6PLrGLmp0kFCL
 1dyZshNaKWdYslj1M/oFf5Kr/J33iq3gFoSXLzEtr9dJgzQGLiFkQe4iocDz9ewiU+MdeOATc
 l+NuPu2zmBYWtqS4tuY+6cpGjc9LEceLMB55clDphcOo4X11gXNYcUWsLMlMAvuOh7XeNTsHu
 fzMWoK6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-335878806-1472668614=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Wed, 31 Aug 2016, Jakub Nar=C4=99bski wrote:

> W dniu 29.08.2016 o 10:04, Johannes Schindelin pisze:
> > The sequencer was introduced to make the cherry-pick and revert
> > functionality available as library function, with the original idea
> > being to extend the sequencer to also implement the rebase -i
> > functionality.
> >=20
> > The test to ensure that all of the commands in the script are identical
> > to the overall operation does not mesh well with that.
>=20
> Actually the question is what does the test that got removed in this
> commit actually check.  Is it high-level sanity check that todo list
> for git-cherry-pick contains only 'pick', and for git-revert contains
> only 'revert'?

It might have been that at some stage.

But should we really check that? Or should we check the *effects*?

I am of the opinion that overzealous checking of certain implementation
details is something to be avoided.

> > Therefore let's just get rid of the test that wants to verify that this
> > limitation is still in place, in preparation for the upcoming work to
> > teach the sequencer to do rebase -i's work.
>=20
> Is it "upcoming work" as in one of the patches in this series?
> If so, which patch?

I left this a little vague, didn't I? ;-)

The problem is that the `git-rebase-todo` most definitely does *not* want
to be restricted to a single command.

So if you must have a patch that disagrees with this overzealous check,
the "revamp todo parsing" one is probably the first. But it is better to
think of this at a higher level than just patches: it is wrong to limit
the todo script to contain only identical commands.

> > diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequ=
ence.sh
> > index 7b7a89d..6465edf 100755
> > --- a/t/t3510-cherry-pick-sequence.sh
> > +++ b/t/t3510-cherry-pick-sequence.sh
> > @@ -459,17 +459,6 @@ test_expect_success 'malformed instruction sheet 1=
' '
> >  =09test_expect_code 128 git cherry-pick --continue
> >  '
> > =20
> > -test_expect_success 'malformed instruction sheet 2' '
>=20
> Hmmm... the description is somewhat lacking (especially compared to
> the rest of test), anyway.
>=20
> BTW. we should probably rename 'malformed instruction sheet 2'
> to 'malformed instruction sheet' if there are no further such
> tests after this removal, isn't it?

No, we cannot rename it after this patch because the patch removes it ;-)
(It is not a file name but really a label for a test case.)

Thanks for the review,
Johannes
--8323329-335878806-1472668614=:129229--
