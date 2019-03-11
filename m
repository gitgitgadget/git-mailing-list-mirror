Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5122E20248
	for <e@80x24.org>; Mon, 11 Mar 2019 14:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfCKOME convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 11 Mar 2019 10:12:04 -0400
Received: from elephants.elehost.com ([216.66.27.132]:53091 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfCKOME (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 10:12:04 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x2BEBxg4027662
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 11 Mar 2019 10:12:00 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Elijah Newren'" <newren@gmail.com>,
        "=?utf-8?Q?'Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy'?=" 
        <pclouds@gmail.com>
Cc:     "'Git Mailing List'" <git@vger.kernel.org>,
        "'Junio C Hamano'" <gitster@pobox.com>
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-12-pclouds@gmail.com> <CABPp-BEVMc+k7fTtZqqAf=WdpFi3W-Tcjw+Ah57bcetOXVwxkQ@mail.gmail.com>
In-Reply-To: <CABPp-BEVMc+k7fTtZqqAf=WdpFi3W-Tcjw+Ah57bcetOXVwxkQ@mail.gmail.com>
Subject: RE: [PATCH v1 11/11] doc: promote "git restore"
Date:   Mon, 11 Mar 2019 10:11:54 -0400
Message-ID: <000b01d4d814$64907000$2db15000$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJZsKhk774AtQtLn4+AXkgD5D0bxwIgnJeHAiQnBe6k2qBUgA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: git-owner@vger.kernel.org <git-owner@vger.kernel.org> On Behalf
> Of Elijah Newren
> Sent: March 9, 2019 14:38
> To: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> Cc: Git Mailing List <git@vger.kernel.org>; Junio C Hamano
> <gitster@pobox.com>
> Subject: Re: [PATCH v1 11/11] doc: promote "git restore"
> 
> On Fri, Mar 8, 2019 at 2:17 AM Nguyễn Thái Ngọc Duy
> <pclouds@gmail.com> wrote:
> >
> > The new command "git restore" (together with "git switch") are added
> > to avoid the confusion of one-command-do-all "git checkout" for new
> > users. They are also helpful to avoid ambiguation context.
> 
> s/ambiguation/ambiguous/ or s/ambiguation context/ambiguity/?
> 
> > For these reasons, promote it everywhere possible. This includes
> > documentation, suggestions/advice from other commands.
> >
> > One nice thing about git-restore is the ability to restore
> > "everything", so it can be used in "git status" advice instead of both
> > "git checkout" and "git reset".  The three commands suggested by "git
> > status" are add, rm and restore.
> >
> > "git checkout" is also removed from "git help" (i.e. it's no longer
> > considered a commonly used command)

Just curious: At what point did git checkout become not commonly used? Git switch and git restore are not yet in git as of 2.21.0, which is rather current. Maybe I missed a thread.

