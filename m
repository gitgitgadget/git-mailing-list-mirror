Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8567520248
	for <e@80x24.org>; Fri, 15 Mar 2019 15:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfCOPuK (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 11:50:10 -0400
Received: from mout.gmx.net ([212.227.15.15]:43323 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbfCOPuK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 11:50:10 -0400
Received: from [192.168.0.129] ([37.201.192.41]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MPUlV-1h8xpV48Kv-004mxu; Fri, 15
 Mar 2019 16:49:57 +0100
Date:   Fri, 15 Mar 2019 16:49:40 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/7] gc: convert to using the_hash_algo
In-Reply-To: <874l84ber7.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903151649030.41@tvgsbejvaqbjf.bet>
References: <20190313235439.30439-1-avarab@gmail.com> <20190314123439.4347-3-avarab@gmail.com> <CACsJy8CikZt_WF79V6y2JRtR0jAosTPPmDBXN8uMRTjm4FAV-A@mail.gmail.com> <874l84ber7.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1372401792-1552664997=:41"
X-Provags-ID: V03:K1:hL/MdKIrgALqaujwyHlSZp8ELUPQZ6Q0EvTe31jBIZkmxbUNVyX
 fJHCfDz7SFqPmwWzifTaQkFO9kBLm63xAJc1Bcw9aMi2gRIQ8XnNvCXRNNQlIrDN3aOK2Jr
 u8zqCWRmpaRQd3AMwsQwY6CWUy5jWBj/NMeJ3sj52JvZifWrvpzWrwwrvcLBef/lJiirV2P
 LkF0eoDtVTtEJfb7f3VmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rlG0AWhdBCQ=:O7MgGzkpFuCyCno4+cAlub
 13pC0+01kjbsNPNKxyTwp5wi+02LS5uPiZcwY6PNf+K3L0CzmWMPDTfZT0QZj4URkEc7GcASx
 mbCQbpMlQVkisWPBAbyh7btqzdrONg3dHH+1JVsmDGIjNBqR7H4obr02eqj1HYz6qeNHUGBJs
 79dh0qt/xikt227ipefKWDU+z3B6J2fTJhVRxbUqS1pmE9fWIVSyH0myyhxInZmVjbQwe+W3A
 8Rslc7nmCtpk1tAmnGnCKr2RZYt3OCAbPKkhQGFceEpLxyDJODuxFqP540fjfkhT9fkh1BDAu
 p3df0mTQ1gvMso/ar8So8gCnrap3fqWKd9FHIfw+MfTiq9GDji9kCEzdVXLtRaoFEruDgK3R3
 69rQLarqHTt4ey8NaY9ndiOhjvywbmN6LxS/cAcsFN74XMLoaeBCbT0O8PgBAOxmSi/8nU5Gf
 cbrwve+HR5PRmTiXe4e1KQNmxcdEWfn0Qz6nJEyeLdmD75flO+q0xyAkIaPEsMO6SBWNriE/l
 VX9hwhFQeYKJUKudN5OG2BcgvFDFMuZ+D32QdI6ndwAFTZpxxKGU4h+FIKe8/cthVPoZGMBXW
 0IYOjjHGLH0psrtIppa6vcyH78vxnTv0E0J1fhAo75LLLi5ZzgXsf5asPggDBELK2qa8oz530
 XDnZ+jrCSwfkgSNvB1nIfl9gR9czN/pRdR2m3+HaVYUVZblqlI8m7e7KDCjPPLZkFtx1qAOlz
 z1nIvfoSLDDfL3FKb2scxcEFVrovBObaveYGyvDDw+q7048Wrz8xBR9eUm/Z00/Nkvur4gIKQ
 P7MIa6+IioOW66MsV08rudg4oVIfsePl8hMzhmevk7jEIHyG0gYL0Nz4toduvwvzrrhZkV8Dc
 hBFin0JDt03TV5Twj2f8bVUamAdkSvG2XLo2CdRqyE3oNvuJs3li1jjX2AfkkgEuvPpOTOH6C
 THXTCrt1FJrBQIcM9eh9ANo6C/x4cpc4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1372401792-1552664997=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Fri, 15 Mar 2019, Ævar Arnfjörð Bjarmason wrote:

> 
> On Fri, Mar 15 2019, Duy Nguyen wrote:
> 
> > On Thu, Mar 14, 2019 at 7:34 PM Ævar Arnfjörð Bjarmason
> > <avarab@gmail.com> wrote:
> >>
> >> There's been a lot of changing of the hardcoded "40" values to
> >> the_hash_algo->hexsz, but we've so far missed this one where we
> >> hardcoded 38 for the loose object file length.
> >
> > Wow. Good catch.
> >
> >> diff --git a/builtin/gc.c b/builtin/gc.c
> >> index 8c2312681c..733bd7bdf4 100644
> >> --- a/builtin/gc.c
> >> +++ b/builtin/gc.c
> >> @@ -156,6 +156,7 @@ static int too_many_loose_objects(void)
> >>         int auto_threshold;
> >>         int num_loose = 0;
> >>         int needed = 0;
> >> +       const unsigned hexsz_loose = the_hash_algo->hexsz - 2;
> >
> > Since you're removing hard coded numbers. Another option is a
> > combination of strlen(basename()) and
> > loose_object_path(the_repository, , null_oid). They should also give
> > the same 38. Then if loose object format is updated to use 3+ chars
> > for the directory part, this code will not need update anymore.
> >
> > The downside of course is a lot more code. Or you can just introduce a
> > new function to return this "hexsz - 2", keep that function close to
> > fill_loose_path() with a comment there that the two functions should
> > be aligned.
> 
> I think it's better to just keep hardcoding "2". We're very unlikely to
> ever change objects/?? in favor of e.g. objects/???, and if we were that
> would be a huge "hash function transition" of its own.

Of course, since it is *such* a common use case, we could also simply add
another field in `the_hash_algo`. That would also save on repeated magic
constants.

Ciao,
Dscho
--8323328-1372401792-1552664997=:41--
