Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 439D11F453
	for <e@80x24.org>; Fri,  1 Feb 2019 06:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbfBAGEf (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 01:04:35 -0500
Received: from mout.gmx.net ([212.227.17.21]:45927 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfBAGEe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 01:04:34 -0500
Received: from [10.10.1.35] ([195.130.156.138]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXDo1-1gcza93rmP-00WCOa; Fri, 01
 Feb 2019 07:04:33 +0100
Date:   Fri, 1 Feb 2019 07:04:31 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org
Subject: Comparing rebase --am with --interactive via p3400
Message-ID: <nycvar.QRO.7.76.6.1901312310280.41@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mtnCmtgDPg87ZvbQuiJeGT4LPe9mLh2xVGS20vh1w4iDNwLnTbr
 4FIGwEjUj0kT9vZb3fn8+CM2uPvOYvEXDmQ7Fu/8PeZ7A+5ndfgfiJpSAAUFkoKRp95vpU8
 xY6zhQ02dXzDp7WHZpl0qtrfv6RGYvavJvyXtZ0XBoV1dLNB/IFgKccaRNdcG/SVDos/sZ9
 zb+oHbow/kNPN2ScGa7Zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3EqOIxtMI2M=:olVGbVlaLQDI1sB5kzlMUz
 P7Zn5S+y8ZNsi0wvrIBHg8geAgxGLCyL5zw4ZhhEGzsytOPvmnjwT+fJ2Ikc2GVPJa51CNdn4
 SiEEVPi6HfH73EuVBQn+KEaX/oRcGKGFNBh20E+4RHqDpJ/ikGR3dhq342JvsPd34ih22O/bA
 Ive9tcHp93wNa56a2M2sFFC/fs59vLduKw6zMho+VBrbAdIHqwn3pLmzev+tqc/AfIL6PvnC+
 4/0vLiJRIBizYEkdoOa+ncdya/6vRAUliE5yjKsmb84Dj2tdVi0/5MsUY8mFg6K1TDT1glc3I
 p+mDCotoqelp31xDefcNkupmhWkP1TM3qADAg72oi2KMAMEWq3kn9MWNE2aTkvZTs44TiaZoX
 MTl/oCOyEDXCkzgDatgxXFe0KudG0wNDTdJOXk0HxdbWe7GS4/tqqFt/igpR6SG/jo0SlC2BA
 OV1sXizxB20iL3zqI19mD8Na8+TYfVEWBlctV4pTAWCrts7yX0lG1NLLcKTzvgur2otbk19NV
 cjMb/YWKDWsBqnYZAfD/URF+SRXVSv7bqGkUS8+RCEKUV6pbaJcj8aj3n/r4OGQgpa9+U+Arb
 qv1bvovSzeryS8xj6uo17BvPpTzk6jczG3xRnpxagDkueFl+ClTt5ERFV+SgeijRq5p7J0Rsh
 wo86WYgMPzA7ZjYjrsLGcHOpYqlG9Ppa5HfJLGaWhCv00VLmdqcOigEBzXIn7fe8xEgjaE3aE
 9r84nMiWCNI57sFb1sSLwLOgk+SsbDx32UBJvpYfhXo8J0o+a+wnBA7TMf9c6cEa8nspIEyQN
 y4y3DdosekJiT2nJWIN65wjAuHxrHTXS+hoMW54eg6ERCNx6qfeAh+H6B8r+XI0ldz9npDA8f
 OSPbXsuCh4HZbBa063WYHM0CRphBwPsZEhP5XuTA3l7WJNZtx1y6CNzZFFnq9MKua4aySgZa9
 nFMSjN8NH8w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

as discussed at the Contributors' Summit, I ran p3400 as-is (i.e. with the
--am backend) and then with --keep-empty to force the interactive backend
to be used. Here are the best of 10, on my relatively powerful Windows 10
laptop, with current `master`.

With regular rebase --am:

3400.2: rebase on top of a lot of unrelated changes             5.32(0.06+0.15)
3400.4: rebase a lot of unrelated changes without split-index   33.08(0.04+0.18)
3400.6: rebase a lot of unrelated changes with split-index      30.29(0.03+0.18)

with --keep-empty to force the interactive backend:

3400.2: rebase on top of a lot of unrelated changes             3.92(0.03+0.18)
3400.4: rebase a lot of unrelated changes without split-index   33.92(0.03+0.22)
3400.6: rebase a lot of unrelated changes with split-index      38.82(0.03+0.16)

I then changed it to -m to test the current scripted version, trying to
let it run overnight, but my laptop eventually went to sleep and the tests
were not even done. I'll let them continue and report back.

My conclusion after seeing these numbers is: the interactive rebase is
really close to the performance of the --am backend. So to me, it makes a
total lot of sense to switch --merge over to it, and to make --merge the
default. We still should investigate why the split-index performance is so
significantly worse, though.

Ciao,
Dscho
