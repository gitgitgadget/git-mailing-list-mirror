Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ABF220A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 18:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeLKSzn (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 13:55:43 -0500
Received: from mout.web.de ([212.227.17.12]:57605 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbeLKSzl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 13:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1544554539;
        bh=FtZk97tdohOB1Z+KWnk/Rz+dlA2zKgO0S/34yM3TqmM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=QbFcEL97O98MkiBHsyY39GUPu55WAsvccZxpU/4/hfIbpqT+Mc969zdTzGCrsuvDi
         sNtsy7bmrN510okFg1kUkMGbTz4zNbySwmIaQg7LOizGTNiKJrymO3oUZ6/cwR46FI
         OtUqIiaPauOuXE4NTpbF51lQ8ms7FMka13peNhdo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MRUFI-1gzU950kB6-00ShKX; Tue, 11
 Dec 2018 19:55:39 +0100
Date:   Tue, 11 Dec 2018 19:55:38 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, svnpenn@gmail.com
Subject: Re: [PATCH v3 1/1] git clone <url> C:\cygwin\home\USER\repo' is
 working (again)
Message-ID: <20181211185538.GA23362@tor.lan>
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
 <20181208151109.2097-1-tboegi@web.de>
 <nycvar.QRO.7.76.6.1812100931390.43@tvgsbejvaqbjf.bet>
 <20181211061204.GA1130@tor.lan>
 <nycvar.QRO.7.76.6.1812111420570.43@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1812111420570.43@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:ckDkZq1QDgUMZP3vQfXRrymM/9nh+KGLXofoVJNHQEhAPz+vHRj
 T7Kqav3pCevEtQcfzl2VZ+TYdVNMEmjiosu7Z/EcXi5TGcVQMAmo50GS5HIldvGQJ5fHCWr
 BJ/6kJu1REHk4E8xrY2CFiRidXFXurLVJ6eyP9mBerC/rmnLPr7e5ti8QBpqjrIQilqbpKb
 0LFyo/hDLwgcVBPNIWdOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5QdxBsGO7kc=:mAusInehjKkZcX/lfzcvi3
 ChsMuLjLhcLrlt7X4HnNEYmSkRev35zGttC5hGVY48Fm/i0K76U+nOKNPvxxT+iKqVCu3mDsc
 JNt0OvV1z6hRa+DmP6mbTOj1ILhJnlLxXSl6a6hMiPa7kyOlkJ5xI9Q6z5H8tmoPjH84e1D3Q
 3qse6lVMHd6A1XW1zKeVef9tkzD6nYtZJK2V5HlAuMDUhatpzzwSkjuPQzX/s0O9LT4uzEuLg
 BWrg6lEhOMcy0GJO5LnJJVst/gYzulo1po7qf4yI1itg/AF2ye/MagedqKsgQvuf6SrXoSzoo
 J0xTbxj5dg9PJbN3tLZB2bX3OBJKajZKAMHab97Z3tFwStvB7p+l64ZT9la3Xu2Flw5mNWqYG
 oVMcL7G5RATeR5hkBRnHuOoC3YnrTdPUfMzxPlVX+hchdHhxWpsYHwVM36MgJovfcJ2b07nxk
 euqVH3wBYcubR/Fkqh075K2UMh6cwN+ttGmqUfLDCEo6b644Nxg64EBxusxWjSyRMG0pKvawe
 kMnjBPbusM4dVaEPM4iU3jkj3uq+d6YvKHSfTyCw4vqFeKunD8FTeKcpfqjT+wMIkzk+j503r
 TJ/F1Vz/OM1on/aYOsqpu6PbjuxX2Xs55rMqr8riqjLoJvPl70y6AiR3t1pRunnNqy5DkniHM
 QypnhsiILBS4NGyf2j20nZJd0Qpow1QKcQR3pndLGNnw9ajxSJIuiFDYqToCvVG3NLv2rIIpV
 MYIyjhLdJXE8NJJo+geh5nFjTgJjkiLCrFhR34x65uiym5M1QMahJMMAurkFgrGYD5U2KXI/A
 XyJaBfC9bv23FE0x8BbsKI313QL8ghRnYRu50RNg9NsdyVg/2dHsGEiGlbB/yjExLSlOWRv6e
 XYXikfane7DdWwaDpeu+KeSrrOqBFwXKoj+r15W8Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> 
> Can you please replace the rather unnecessary, very, very long
> `win_path_utils_` function name prefix by the much better prefix `win32_`,
> to keep in line with the current, already existing, surrounding files'
> convention? Thanks a bunch.
> 

That makes sense - thanks for the suggestion & testing.
