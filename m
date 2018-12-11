Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9871920A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 11:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbeLKLZu (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 06:25:50 -0500
Received: from mout.gmx.net ([212.227.17.20]:58013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbeLKLZu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 06:25:50 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M2L60-1hMIol0pnQ-00s71g; Tue, 11
 Dec 2018 12:25:43 +0100
Date:   Tue, 11 Dec 2018 12:25:42 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] mingw: allow absolute paths without drive prefix
In-Reply-To: <11b17e5d-e843-463b-77da-263e8e3b7598@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1812111134250.43@tvgsbejvaqbjf.bet>
References: <pull.96.git.gitgitgadget@gmail.com> <50ac31ef7f4380f37a0e2d3b75e82b324afee9e3.1544467631.git.gitgitgadget@gmail.com> <11b17e5d-e843-463b-77da-263e8e3b7598@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rKKiE/CpY8wsYGAImQH7oIKIFxPsfTGqzRXk7iPW2diXggVWjb2
 PRVgqcbPMklmicEKQInrKud8iSQpg9yhSYkjZumfRwy+PmiTUL40z+jVo8XySearGrmJR3o
 AdGC069JJx2Vx8aJMamFlkBjf79OrSISh/kdhKyZUJso3ftj21h506HljiyHySdR6u/FW/5
 E/u5f+NUqXGHmoyA0OqgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F0Efuh1uNyE=:+BnvBqI1E8G50IMeg2Ybri
 jmIBaolCI/4+IbGEjADLz+83JdxjVmkvsNpqGc1/ITMwg1tj6l9l3KvbojLQXUZkkp4pnrAgU
 slRc/KG69LUcdxLcXFwvMp2r84F67o5YuTyUj79bLUTZHINl1WSWXwaz86hng2y732kmsgz65
 8++zjATRFfI5xlnrNpK+RUepZl+YqIOFIB+S9Shaw3q0ChvD3+vvLwOT6GNgDVovzW1caNhLY
 hhZS8plg/zl1z+d2ADQOb/KRs/M4L78gbToF5o/vd51VTKLuaaeUwy8t9PjL/Mj2Cgll/oUaY
 btvdaw/1i0dK38xzZmNSVBDUXRyEOtFMffra/S6XHIEyG/FB6/UEImkBQcvp7L6f6BYQSDYSt
 I/MsIDUzn9Tm06AVZ81kOH43PEjangxoNkv9XliZUxddExmjfIA26idJPS52i9rJkaL6tOGsd
 vqVm+hW1J9YJ29xH2FvhipYaWKiYzesxT9ATVv0trQlAYeePr7Lz8AVWA9s0CimkrWhjYELyQ
 +4Gs8fFKVfcoOZptlJG62uyQu7L7e+qpU5Jm+sWkPDR8iwBqL1KR4yjQP0Pw+mOR43nAxO1PZ
 nvLMzEBiuXr/KfqtZmPleN7a6zj52TWko9BfiSBqbZ8TVIfKb7EemZvujafTJ1GUeGux3FZ2T
 P8Z30NQw8szd8FdUkfzq0KHKYt6feXCQxseW3vjjbVq1ncUXj+Wbz7uCjViJ7CI8k1prrXtPO
 dieCuP0P0X5H4t1m7GjNXBwOpIWt9a7evNXrw5NlzHEwk6nwFHK2Ey0g2SPc3bes8toUx3+BF
 y69ENC3KW0zAeXmjl9+NL5Kv5i4u5JWeHAtsn6SGTpfWiT4KV5lfymabZagYS5G2qL9o5gvcZ
 pMSJieqt9duICdzGOmVb1V4E4R++WwKjoOfsCrQpvXKakzujAmHAbo++/zO2VmeoBt0XkR9SL
 6xWQLfIT/eA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Mon, 10 Dec 2018, Johannes Sixt wrote:

> > diff --git a/compat/mingw.c b/compat/mingw.c
> > index 34b3880b29..4d009901d8 100644
> > --- a/compat/mingw.c
> > +++ b/compat/mingw.c
> > @@ -928,11 +928,19 @@ unsigned int sleep (unsigned int seconds)
> >   char *mingw_mktemp(char *template)
> >   {
> >   	wchar_t wtemplate[MAX_PATH];
> > +	int offset = 0;
> > +
> >    if (xutftowcs_path(wtemplate, template) < 0)
> >   		return NULL;
> > +
> > +	if (is_dir_sep(template[0]) && !is_dir_sep(template[1]) &&
> > +	    iswalpha(wtemplate[0]) && wtemplate[1] == L':') {
> > +		/* We have an absolute path missing the drive prefix */
> 
> This comment is true for the source part, template, but I can't find
> where the destination, wtemplate, suddenly gets the drive prefix. As far
> as I can see, xutftowcs_path() just does a plain textual conversion
> without any interpretation of the text as path. Can you explain it?

It is legal on Windows for such a path to lack the drive prefix, also in
the wide-character version. So the explanation is: even `wtemplate` won't
get the drive prefix. It does not need to.

> BTW, iswalpha() is not restricted to ASCII letters, I would rewrite it
> as (wtemplate[0] <= 127 && isalpha(wtemplate[0]).

Very good point! Will fix.

Thanks,
Dscho
