Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31ED61F424
	for <e@80x24.org>; Tue, 24 Apr 2018 19:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751165AbeDXTKq (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 15:10:46 -0400
Received: from mout.gmx.net ([212.227.17.21]:37333 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750778AbeDXTKq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 15:10:46 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQdAP-1eynGU0faH-00TyTO; Tue, 24
 Apr 2018 21:10:39 +0200
Date:   Tue, 24 Apr 2018 21:10:32 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Philip Oakley <philipoakley@iee.org>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 09/11] technical/shallow: describe the relationship
 with replace refs
In-Reply-To: <52C2C5A51FE7400E937F06B7641F4319@PhilipOakley>
Message-ID: <nycvar.QRO.7.76.6.1804242106220.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1524125760.git.johannes.schindelin@gmx.de> <cover.1524262793.git.johannes.schindelin@gmx.de> <853b0a445ab1d78e8cbe19dacd09e70892b34b03.1524262793.git.johannes.schindelin@gmx.de> <52C2C5A51FE7400E937F06B7641F4319@PhilipOakley>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fZaxyBTySixoDRNTaWheycHYUNt49I7/t6y9t+5b9Q0wukYle8l
 TAFuIsdO9SlPAJof2QxA3kOocwZmFXcTfdXUiR34kMNVITu6e59wAWaiFQRWW7xS/vghgoz
 2cwylNt0WfnEm+DWSDNkamRMeOa/4yQnPgz7xtQpzzAk1BctqAuM13x/j5G0mrZwHBqYVui
 PBnP4I14vSU9BOP7FpzAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0Pg9SpOfpMY=:WoKXxh+NhoKW0AxgVD7fFu
 2Yq6pHZG5VP9oSJmshQqByp663XwqnsWbb5jqbI7JKqtS+PyJ5rFX/R2BCRilQiKIZPtZtL71
 oGhHDyFKMxQsAw2JTCvCtu2D6/Wwfnj+ugvjrnoAoRW3iWV40/Z9Bwj3H/38SqEQ0fZ6XUKKW
 FInnRBxJksMwzpCMpU3rVGuSJBJJW2YLyFWzdzVW1PFdeyUR3OEOGN/Kb0vASGF+bu2HteRIb
 dN4rmi0WQN1Aur5i5WRVnZoPpF8Qgg/DAR2lsotGOodrfDid8dDn6S1eOJG/2Rp8WUKsQNa4P
 O8oPsVtrF83KntyzsWfZ4I39JrP48rI7lQm6avH9uMvuXob4AD1EcIM7U9STC/m0lYtRWwEas
 4wAnJsTJohVgJxVCj9K5rR9LMDt4n2cM1WUPVm7wwYxmXGrcz5zAtXQRVQCpVdsyDvpbj0yQS
 6Rg8tOMDxfD9TGpeJRO5JNOCHN7sTcxRxjR1iu9eAUOWI0+GbGRUivx9UVOaUINUL4t6sGQqe
 6srb8WLL2J3//LZP8p7AIICPSrT0oGb8j+AKuFzGb9ouEFyH/EkP3cBzvkyQ6Q8qO4TFJryRj
 od9AcY7HzuCU+MZI/RfWvKyGqc4U4FGlYJx+RiUoIv8YbHxM9NWVW/Y+nuRD0WwfLqmNVIgxs
 LQdAxQ5CTemnTe4xK3NRXAndHkKIZ4lOj9TTp3KG0bQRCPwH4Y12Sye4O+scykHE4bvb+AlvR
 zdySFWI3MQ9c+QgjMrm8YLG5OYlKo3M4E+yon1LxnkudjajESF13k8nagy78ZBXwGv610VOnn
 Sy591kqNBTIeMwTJK7vZHdGJQdf6WkiSTQxf5BPm0KXN0fucTA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Sun, 22 Apr 2018, Philip Oakley wrote:

> From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
> > Now that grafts are deprecated, we should start to assume that readers
> > have no idea what grafts are. So it makes more sense to describe the
> > "shallow" feature in terms of replace refs.
> >
> > Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > Documentation/technical/shallow.txt | 19 +++++++++++--------
> > 1 file changed, 11 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/technical/shallow.txt
> > b/Documentation/technical/shallow.txt
> > index 5183b154229..b3ff23c25f6 100644
> > --- a/Documentation/technical/shallow.txt
> > +++ b/Documentation/technical/shallow.txt
> > @@ -9,14 +9,17 @@ these commits have no parents.
> > *********************************************************
> >
> > The basic idea is to write the SHA-1s of shallow commits into
> > -$GIT_DIR/shallow, and handle its contents like the contents
> > -of $GIT_DIR/info/grafts (with the difference that shallow
> > -cannot contain parent information).
> > -
> > -This information is stored in a new file instead of grafts, or
> > -even the config, since the user should not touch that file
> > -at all (even throughout development of the shallow clone, it
> > -was never manually edited!).
> > +$GIT_DIR/shallow, and handle its contents similar to replace
> > +refs (with the difference that shallow does not actually
> > +create those replace refs) and
> 
> If grafts are deprecated, why not alse get rid of this mention and simply
> leave the 'what it does' part.

Internally, shallow commits are implemented using the graft code path, and
they always will be: we will always need a list of the shallow commits,
and we will always need to be able to lift the "shallow" attribute
quickly, when deepening a shallow clone.

So it makes sense to mention that here, because we are deep in technical
details in Documentation/technical/.

> >                                               very much like the deprecated
> > +graft file (with
> 
> >                           the difference that shallow commits will
> > +always have their parents grafted away, not replaced by
> s/their parents grafted away/no parents/ (rather than being replaced..)

But the commits will typically have parents. So they really will have
their parents grafted away as long as they are marked "shallow"...

Thank you for reviewing!
Dscho
