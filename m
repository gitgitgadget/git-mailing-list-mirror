Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B66B1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 21:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387813AbeKFHPH (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 02:15:07 -0500
Received: from mout.gmx.net ([212.227.15.15]:45319 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387672AbeKFHPH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 02:15:07 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LaXEN-1ffjZG3hPD-00mK5N; Mon, 05
 Nov 2018 22:53:14 +0100
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LaXEN-1ffjZG3hPD-00mK5N; Mon, 05
 Nov 2018 22:53:14 +0100
Date:   Mon, 5 Nov 2018 22:53:12 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Duy Nguyen <pclouds@gmail.com>, Ben Peart <peartben@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [RFC v1] Add virtual file system settings and hook proc
In-Reply-To: <87ftwf7nwa.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811052251520.86@tvgsbejvaqbjf.bet>
References: <20181030191608.18716-1-peartben@gmail.com> <CACsJy8DbiVZYmY11Nt4c_+egSi5tz0iVq7rNv2BiVdyJ4htgvw@mail.gmail.com> <1f7efd07-4881-daa7-cd1d-145bbf3ffcc8@gmail.com> <CACsJy8BqWu0YG_Q8EFNeDgrRhYCCKBU+zPJjrhAWFU_gTDCoXg@mail.gmail.com>
 <87ftwf7nwa.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1433069517-1541454793=:86"
X-Provags-ID: V03:K1:l78oLsNs6jMxpfan9uCc4N3optLi5QrzoyxlX4Xx1F1Tl5KnuLa
 8HgBBjpKHM51ugQ2yrEy4Kpz7MjLocEAWTTXwRhaF8xAvaiDfkfzi/BbBQ5A4U/+XHpMRZH
 DHthtItdwUOCJlzVi7A1DAahPQKUJJaPw3wX2VZopMq+Reln1NLqLtp7rTvMN6YiSkeicHY
 tEtPwlqAlfYmXF2b8cXPg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Wf6W2TwGG7I=:TufRe/eNwudKdCs2nWIbjo
 jczJfWhbCTvsE2zVVqzLqQHAlSVPWcUs161o4dFPzn8HKE85IS/ZttUB3IrP3/6LIzAv9aVu2
 OS1MKR1iQ4FJ0gdZklTVtcpJEsI7+cuJczmSHj9G+gG+3Gw+W6Rv2wof24WhDKS+1h9IcmGXP
 gluGqlbqJXFoKp1l1dANbwYvLnVZtfq8F0TIiiW8VxrQ3sr9EhHyxLnd2chRs/YeVNxfQ4fpJ
 g85MGuJ1VVUC3+A8Pz9q7qgfF2D0qLrc0duQKn4/FQWhzBj6naYnqYXsl9nreQMl4/Bzx4gUw
 UCCLXSRGqWLya8fjNfh+r96pNlgR4dKHK9qkD4s/VHdRNwkimhfeO0NctH7cBygwCLxP+MR0e
 rqrKeF4dWCss79rPQG0gt0krtByzD83Pdbp+GIO50auST7Fse8APUJZPt/ebNn4HTd8O8tmI8
 rXv526QAubIP/bhz3wDcYBoPU9Za3Q7XuhmRJMTPDAvc97sboq09eXhY/64pIg2pbfYW+d6G5
 Npf0xyOzQEwTeFxmowX0JHn61JVfPd+UtenzhwoiRvj6/0R26ny2geeYAn+kUOITzRBvMcQeS
 68PmzBVQDH0OBc/3r/GM5wHJfNLjpXcv1jya+Pvc+ARq2pCPcXxmSUdqt5TEFIxtNBzvqKhEW
 NpEz4aN6TzSyQIY5hijDsO+E3Volu6bXxYouTCs0hUw+DB3DyQ34w3pRPx2yQdo+UHo13ZdwV
 t98zR1+OMLYpE6Uc5qPxS95I+7VqkTP6xpoNlgs4wJWs72P23P62OI+DSaVKg+5yj9hE3emIf
 7JqIGeZN5/MfZog08xuCmIwo7mXuM64/zmPGdgaVjaKOD4VoBY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1433069517-1541454793=:86
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Mon, 5 Nov 2018, Ævar Arnfjörð Bjarmason wrote:

> The only potential downside I see is that there's currently exactly one
> implementation of this sort of thing in the wild, so we risk any such
> API becoming too tied up with just what GVFS wants, and not what we'd
> like to support with such a thing in general. This is what e.g. the w3c
> tries to avoid with having multiple browser implementations before
> something is standardized.

It is my understanding that Ben is quite interested in ideas how to make
this *not* tied up with VFSforGit.

I'd think that he would welcome any good ideas you have in that direction.

Ciao,
Dscho
--8323328-1433069517-1541454793=:86--
