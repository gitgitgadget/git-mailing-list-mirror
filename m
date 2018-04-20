Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFD4B1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 13:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754966AbeDTN6J (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 09:58:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:44475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754872AbeDTN6I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 09:58:08 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LkBPy-1eYY6K2raE-00cBwk; Fri, 20
 Apr 2018 15:58:02 +0200
Date:   Fri, 20 Apr 2018 15:57:46 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Christian Couder <christian.couder@gmail.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/7] replace: introduce --convert-graft-file
In-Reply-To: <CAP8UFD3cH4JkKo97o4k+BW=sdaFviJR06R1V_JqS9FkwuP7ZKw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804201540310.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de> <cover.1524125760.git.johannes.schindelin@gmx.de> <cecb82973f80fdd2db940410db2a7c3b23107c4b.1524125760.git.johannes.schindelin@gmx.de>
 <CAP8UFD3cH4JkKo97o4k+BW=sdaFviJR06R1V_JqS9FkwuP7ZKw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:S6i1MKN2Uezg6eNviVfS7YiiA9kcSB3nPnGxGX8JwZPZY5O3H1z
 TihV3WVN9icLuNzE87mhrGdy09ovyLWtdUJA5dq9QwD6KcTZ7g9P/JLym/9REHveFOmTAwd
 AZ0QcixwUBpPPRBtrbOXYd3UR4P7QPrglVZaK4mlSF3yoqvDX6Kt6Ux3qK24qnBEKz/0Xdk
 oI98xR801HTg0m5Gxabrw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cTN824LsShY=:aSJ2/6auq4K5o9MomClqq1
 bw5rMAG673+YvK+/ycpcpwgldVJkaWEBarOOH780017ISqf2R/n5orFFAhS+RHSJ7ODcCjyhZ
 TtsWiwutXTqEACJNmNtQPto6YjxA3YQhezxLJnf5sH0XJjVNL2OfvAKU4UMhULnu3tka+4dDc
 oq7L6cpzIehEEdHwnHsAF1Z3fmskA+5RJueZZkh+zbviw97bfBIQ+LwJvgOBnaeYa6ljSYIiS
 nmLGsZAp2ifoltNOcpbxO83VsmKjs24sKqyFxskXlkJn1LtAXg+WDPGcMYI1TCftuy8rFcmZU
 ovsZqXMQEa5hpHOm/x9ggvOEh9v9eLwRJHBhS9v5Ody1vbx80qlNWHn7ziA+BRXJdsRLTOLVT
 8EYc+00eCt1SYnsL5gTFRzpYwjbcy+sSZ6riwxT0LP4tuFoy2KPUKavNZokT9VSvCUlJn5Ws/
 OUqOwlluDqgoasXivaG35eqfMk1yBdXD0ow+0vvaek3VTOaw71+7TECCHIG0dpeOjb0KDITPt
 Lrz085Wr24QpyM6h02b2s1yB1thhSAh7iEKev3eH+yhKdPVwS5Zi0tJ7ZtiQVdpwueTUMif2y
 rR8XMwEbvj4XDMb50DK0wAPKnZ/74JCWqVkPb4neYmAv22ng9zDyZCEFynDfcmFagm5GN31h5
 GGCvny6vQJffomGtJNB1QpfzzuQ/HYHdVshAm+VB8mtF468S3TRp9LzuVdIYuQGkEPMyvPSoR
 SZ7xkVSJZc4qYaun/VmyF0Cchx7jECOc9bedtUL8wV9axFFQ4WBqFDNlnn3N1RUY18H1f1Drd
 Ap7L1HjgXCc5XxChMtHvty6aF0Co3sr0gDjQXJvCIWwW5GGaYI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Thu, 19 Apr 2018, Christian Couder wrote:

> On Thu, Apr 19, 2018 at 10:17 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> 
> > @@ -87,9 +88,13 @@ OPTIONS
> >         content as <commit> except that its parents will be
> >         [<parent>...] instead of <commit>'s parents. A replacement ref
> >         is then created to replace <commit> with the newly created
> > -       commit. See contrib/convert-grafts-to-replace-refs.sh for an
> > -       example script based on this option that can convert grafts to
> > -       replace refs.
> > +       commit. Use `--convert-graft-file` to convert a
> > +       `$GIT_DIR/info/grafts` file use replace refs instead.
> 
> s/file use replace refs/file to use replace refs/

Ouch... thanks for catching this!

> > +--convert-graft-file::
> > +       Creates graft commits for all entries in `$GIT_DIR/info/grafts`
> > +       and deletes that file upon success. The purpose is to help users
> > +       with transitioning off of the now-deprecated graft file.
> 
> I wonder if it would be better to rename the file to "old_grafts" or
> something, and perhaps tell the user that we renamed it and it can now
> be either deleted or moved somewhere else.

I do not think so. Those old_grafts will only lie around uselessly... and
are no longer necessary.

Ciao,
Dscho
