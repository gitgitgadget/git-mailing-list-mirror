Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C284202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 15:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751290AbdJ2PSu (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 11:18:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:60007 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751152AbdJ2PSu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 11:18:50 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgNGi-1dL98a3mfU-00nkBt; Sun, 29
 Oct 2017 16:18:44 +0100
Date:   Sun, 29 Oct 2017 16:18:43 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2017, #06; Fri, 27)
In-Reply-To: <xmqq7eve9gw4.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1710291614020.6482@virtualbox>
References: <xmqq7evhc7nw.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1710291409390.6482@virtualbox> <xmqq7eve9gw4.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MlF2+4kERHh63cnOszOJdj9S31ItM4CVe2g0GyInEXNmn3rdEN1
 I01aCiJjP9Cia0b8ZIHk1D/CdMRUS3APwPfnbVi6fZglttolyAkQr/3EgUKlWUdMFLGNzE+
 9ZFNF3Gu7Pf9glla3cfA9lXFZIlR8XizTrA89c4kZv3d720AAXNHWm0HzOVp14u7EAZzg2m
 kXvE9nL489cwDBUjIipAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ChMBUmSL/is=:vGqsdJ71FTnysrQmK4S+Se
 aw6lJeo3DM/w4cnAwAXOkFfoh4FnEtXovCXMD+/2cws3KILZDm4lz1Ky0PrAHVY4QrROeBBMk
 jCR2VBIsOeEmx+nLWYHNpkRvcBCa3TZFaS+i0DmIEtHvJjPkzOgrmmQOoh63e0NwomjJSaidR
 90BFDHiR4+zi+QZj5eadmohK5+tH1fp2OJZ+OkEO7gC5s5PmqVvoujtFT0sDykAleJDZ5IiyQ
 IjDR8v8WnMsQtDyWRGGrDvxre3onmnwN5XKw/Y+bRSIfOCimx1sbX1QOVRMSMBRbGLsX69v49
 56RxGaSjfN55TPciafw7cxu36Viac2QBdCr3NPMU6ia09kp77gfxGCNulOve5MW67j1+2DLR0
 FecxXu2ML+jtsrx160YKczyA8xYFJtqPh7f1Z1fKsLIx9ItK3Sas29zFUMXIdfLJbKiQg5hM9
 xiHoywX588qI65l8GvKX5J7HAsFxNG1pHQ+gXs6JIu6pbYGMg3hMIA0nG6HtxN4Zk/m7ktDb5
 jC5sWBhQp+XEEcdEUtoVkNGddB+Ieyq4RSrUi7bGDhRyRaCSRcWMeO3jm5oNfDRNW8gMcwPyR
 4DUHWR21KKqMayjidSeOYgRJd9eWyfPNsYt7/k73w9U6dlHVabqG3TM+vNQD7HTFmFU4lUFfp
 kTWftOd+Z0oOFLFIG5HNVA1lS33dBOMzmxPncrCCVlH3Gzq5EJ+fykL8MwngUEhj1kkBcnmxE
 37Tvp/R+u1Vl4Fu6YPmPAfeRa/GkZCD6QppCE0nVHPhhsqlTlGwG0pKMGoOV/ccNkNezSzlkU
 6cvt+GbPy+60y4xQahpWqnMdrCKFTll+ifK//DM/OYdQMxUlFLfNEojbCluVBMQHZWPdVXJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 29 Oct 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Would you terribly mind adding a SQUASH??? with my suggested fix for
> > PERL_NO_MAKEMAKER?
> > ..
> > Likewise, this needs a SQUASH??? to remove the uplink$X before
> > (over-)writing uplink, to pass the test suite on Windows.
> 
> Surely I don't mind; please just send me something I can "git am"
> (or something I can "git apply --index && git commit -m SQAUSH???"
> would be sufficient) for these; letting me construct and/or type a
> patch from pieces of discussion messages is a sure way to introduce
> further issues for Windows, as I don't have a way to test any such
> change before I push them out.

Let's make this more convenient for *both* of us. You can find one fixup
in the `jr/ssh-wrappers` branch at https://github.com/dscho/git, and the
second one at `cc/git-packet-pm`. Both should fast-forward from your
branches of the same name.

Ciao,
Dscho
