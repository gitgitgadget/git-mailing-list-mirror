Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC3F81F915
	for <e@80x24.org>; Sat, 14 Jul 2018 22:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbeGNWgj (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 18:36:39 -0400
Received: from mout.gmx.net ([212.227.15.19]:43409 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731182AbeGNWgj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jul 2018 18:36:39 -0400
Received: from MININT-3BS5S37.fareast.corp.microsoft.com ([37.201.195.126]) by
 mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MdKkd-1fMWLC0Xqd-00IVjR; Sun, 15 Jul 2018 00:16:01 +0200
Date:   Sun, 15 Jul 2018 00:15:59 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller@google.com" <sbeller@google.com>
Subject: Re: [PATCH v3] handle lower case drive letters on Windows
In-Reply-To: <xmqqva9kurba.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807150015350.75@tvgsbejvaqbjf.bet>
References: <20180711175420.16940-1-benpeart@microsoft.com> <20180712154419.18100-1-benpeart@microsoft.com> <xmqqr2k8w9n2.fsf@gitster-ct.c.googlers.com> <BL0PR2101MB1012EDB64112A8805A2C3D82F4590@BL0PR2101MB1012.namprd21.prod.outlook.com>
 <xmqqmuuww7rq.fsf@gitster-ct.c.googlers.com> <BL0PR2101MB10122C1A2F038B61470A6994F4590@BL0PR2101MB1012.namprd21.prod.outlook.com> <xmqqva9kurba.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:I96Jn6nH7OFesI4GK9vWGGNmZmDGqbNmbJeeQa25oClAnUoGM/y
 JmwbhDJluYtxigJVDi9uQiJQSs+VXh87C1EAJ1I3ecOmg3nnFN5toc6Wb0wUj0jYVf2qAln
 02mCmns5rjTqvOzIIjVaGuEWMZ4AbARWb6cr+WS6gRvNlXZU9vQplTkBQbyF6bRAELHi7yh
 rlgMTyI/M4TlsdNj74JvQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BjIVKYj/E2Y=:eKx1JvByUPsGnHe0pBxh4I
 tc8QujJDeb8V7D3UJ+SmtN6l0G8hA8ZpTZNr05ov9kymBlMAJ6elfUbn/TTjP+QE/GM9vxQE6
 +ubg0ZvPXjzHMdyfa/Dmpiu4glho/GW3ai1I1kqIKz9moHFWw6Z73Kv2KqxhvIBBfy9j+yWp2
 4xErEB+BFMQTgdTwnpL6WzgcT5uqLspAvLpJ/9AEpFrZvKIoplwWSEfp/v2TPWH7iT+Q0sfip
 91jS/l0KwUpU1o+HAdUPxXbORFhpKpJrXv28Yl/IZ0/gXRHww64x/saBTDC5IgJtQARyHL/bQ
 osE0UlFgT2l23N4WJ9wiSLiWBomntQYFnef4J/4OvjbgiaU1vgrqQ8y1ucsPdxBx+xO8I0lcO
 HTZl6L/GtjibXOkKJHy24Vl+vGRojFIZODpYKd4IlunnEkkizWSZd3c2jffXBb/bexVxreLuz
 6AWLSYFAO7Va+c7SlOBWEw6nF8oWuOIB0LltveCTiecX1BlK9fER3nCPryLezoDNjA6d69fux
 q3jcjDUABcJZaHyr4dbodSYkK9yxGk+MMiGQIdHzE+M1/YJahSls0SDxiWoBiyGdjzk+/99li
 1L35RYSLhNYRbsrtb2RYX9ZsCLgmNbGDnCWMS2HVAhhdefI1Dl3ZgbjUb1aBltNPriOhbwrlT
 UmVqN6arSOHX4dQhtP2CogaUpcyRvI66T4oAn1wJw3vVQpDHEhH+3ou3/GP5IlCQzIH9ivAKn
 1smR7lzO4WUyJIUitTJAkBgLyQEbtxeF3fNmybjXic5zgqxTmQ5YvnS+BiIbm35ucWp16AAKx
 OsuSOzg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 12 Jul 2018, Junio C Hamano wrote:

> Ben Peart <Ben.Peart@microsoft.com> writes:
> 
> >> > Thanks.  I thought it was strange as well until I realized you only
> >> > see the error message if there _isn't_ a valid drive letter so seeing
> >> > the entire path makes sense as it will likely be something like
> >> "\\server\volume\directory"
> >> 
> >> Yup, that is why I thought Dscho meant to say something like
> >> 
> >> 	"'%s': path without valid drive prefix"
> >> 
> >> in my response ;-)
> >
> > I'm fine with that - want me to leave it alone, spin a V4 or have you tweak it?
> 
> That's "helped-by Dscho" patch, so I'd leave it to him by queuing v3
> overnight and wait to deal with the final decision by the weekend
> ;-) That way, I do not have to make a decision on anything Windows
> related.

The tweaked error message is fine by me.

Ciao,
Dscho
