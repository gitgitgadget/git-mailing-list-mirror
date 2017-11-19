Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A607202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 17:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbdKSRjr (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 12:39:47 -0500
Received: from mout.gmx.net ([212.227.17.21]:50441 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751015AbdKSRjq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 12:39:46 -0500
Received: from bedhanger.strangled.net ([188.193.87.84]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MarAM-1ealbB12Py-00KMcJ; Sun, 19 Nov 2017 18:39:03 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH v2 3/6] diff: diff_aligned_abbrev: remove ellipsis after abbreviated SHA-1 value
Date:   Sun, 19 Nov 2017 18:38:38 +0100
Message-Id: <20171119173838.8820-1-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
References: <20171113223654.27732-1-bedhanger@gmx.de> <83D263E58ABD46188756D41FE311E469@PhilipOakley> <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com> <20171113223654.27732-3-bedhanger@gmx.de> <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:d8qXLWna7cjXHEkmVfk3B62Hp2esFpxTtmnGlEhs55klygzeta8
 JpL+VuRiYb94m/WbNVDXIt8KQkCjuZh9Bj+j8tVeXlqftk0IzR0KZAZmqNkTq1hGaExqClG
 hb/XWDF58MKhFQYQMdvmGQfeTnmT4abvhT4d9Zje7aYcIBLLJXtcUtv+lrsd3zT93n8DYtT
 xvpHgRAaD/TjufORwqLHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XED6Qu3SC0E=:rDo6QI04cET5dlsbh1sTOr
 8c3s1pDFbcJ8gCAq3s/dx+ToNuTC1HdaUIq67wRymPFGxzukQwjD+lF8ulthLm2vsuW7+HX89
 xoQm2B37dc2YgxpmZbrCAToPicgA/6MLKaQRpsTOW8lhpI3XB86FHKpgKC7RZn689IDkZYtBd
 T4atdfm3+X+vQntbd1lYxsyahIZOaAfE951d5CPQjcjhbjcOpvDWX6TVOhnZrdm/XzOGTeEVS
 11H2CUZ/EVlQRFOSa2qQtnUnhiH2vg0UOx4eSsXUYvSUzq2yVcgQ1suBFJj2G2UbLBBuj4wYl
 ZMkZTjpuaczJca83//YWT9dsXvk7Mam8ZyOUlP3fOCR0CPBqIPmzE+DEKjGQn2igIlSHbL4fs
 5iFO9F1rxbH5asHqmYgS1ZHO0aGbdbVdX/lJ4hLJkDVIN6oJdDIvwwLL3OpYe5ucvpwufwvLh
 x5PN0lvueGM2fojKtEH2Q/7O7eLbUvQNmzrzoVCyz8KtxWjP9y6yl2u+0Jd20fKkX2OFyduRP
 jdjXIFCQyTaDv3f3j0o3FsPRSiTr8hMDGUTtjQ+gyvpiz4sU/VPeI6KYlqUb7lFkJIjUdBvqX
 ZrKxUCIgQHScwK3fMRr9ReCfwqsXnJ2eY5Tu9UtoLqWg9pjwddI/P3djfIYptwOQQXcUZhjqs
 7hHdDKPkEasACY8N/FUm1gIz5oexFQnSsxSbHU49nxLm4P5cWnvtovZX7m2ztghJjZwwXE10G
 k/L+Gtb7Zo3vM/TU2Tbw/AjVHGb00bSHAy82petUrUsncqJ5tuRwJDfNOsDtV3ttvNdjqrX6J
 gEwfIQO2dZnNi5Dza+JLKmk4fhQNA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> HOWEVER.

> Notice the name of the function.  We no longer even attempt to align
> the output, and in general the output column length of each line
> would be shorter than the original.  I am wondering if the change
> would be of less impact if we try to abbreviate to len+3 and then
> chomp the result at the right hand side to len+3 (only if the result
> is unique) when print_sha1_ellipsis is false.  Of course, once we go
> that path, the code structure this patch introduces (not the one I
> mentioned in the previous paragraph) would be necessary.  Essentially
> you would be enhancing the "else" clause.

Sorry, but you've lost me there.

I'm in the process of producing v3 of the series (env var
instead of config, comments, indentation level), but i can't get
my head around the above.

Would you care to elaborate (then based on v3)?
