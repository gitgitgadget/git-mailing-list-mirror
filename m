Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56ECF1FF76
	for <e@80x24.org>; Thu, 15 Dec 2016 07:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753581AbcLOHbv (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 02:31:51 -0500
Received: from mout.web.de ([212.227.17.12]:53050 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752428AbcLOHbu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 02:31:50 -0500
Received: from [192.168.209.58] ([195.252.60.88]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LmLoU-1cqD1V0gaY-00Zu3y; Thu, 15
 Dec 2016 08:30:59 +0100
Subject: Re: [PATCH v2] fix pushing to //server/share/dir on Windows
To:     Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
References: <2ff2613c-47da-a780-5d38-93e16cb16328@kdbg.org>
 <20161214173034.inbyakdykjv5j7ua@sigill.intra.peff.net>
 <787a421b-8b7a-14c5-768f-06c3dc183cf4@kdbg.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <c8501e28-db8a-5b6e-717c-5bda1e63c2e7@web.de>
Date:   Thu, 15 Dec 2016 08:30:52 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <787a421b-8b7a-14c5-768f-06c3dc183cf4@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:DUEeXcKNX1l4+bxCeCI8zacEfBhjUQmCOsRB+6BJfHY4XYn8n7E
 tjusLIxWvxlccwIX5c0Jj2Xf8PyrmY4C801ERHgrgnS0m8JmYuR4Bp6w1upd21IgRdqlGq+
 OxNKYY7hau5Yog8ZwMYfgQmSB1U9MVThs+ilpcNJ63liZYwNFp1vpDpbVe4BrSiYZ4pHGu+
 FaaZY5dne1i+7iTaUbLuA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AP5YHhyOo90=:oYxMyDFNvv8peMcf4d5gs6
 LiNJ9y3FLwbo9IHlAQ7899Ley35PKvcDifh5mk/5RpoCngDtgIjVKWzu8JWqXejXxei7jTtvy
 XRdKfRdC3RrYdWWeFpmF/Ur0/iGK1F9dOfmtibXXAvC+HYAlZ2iCsxxEcwaVg7WMfIUPqOSPR
 YHAc19dj8y6GUAR9CtreUHf7VwIKESXNM9pF99CfJdFm4D5O+uIDzl0Cerh1+DjZEB09fmpJi
 chOU+s7U3FbdRRI8PRxkmyTPaD/FB7AHlsKEadr7DVYxDU1ZIATNg7/39ZNS/v7tsZSyuESWQ
 BiZHOQiDWV5Tv6RERaIGVflWamIlRqtS/Khkzj8WAt2Emo4C1RRAkjn6/pMyx2KdLtTGi3o5C
 sj9jcUYftFI7vD6V2Eu1sSSawUezs6maMbNsYhW4qCFVe+ZhgNQ7V/0vd8P14lD2XkWj1tMyj
 0mtSvDo9ANrWOPGxS9e13jLf7LvwORGFckk1Jmbtx+YqT5Z9+bfQkTdpYE9vm3uUHOdWGuOi3
 +W4rqy7ACNsNVR7aPKW5oOM643nNRxDIuoKOfyWeGL0ZZ9ManUfoZEpUNtdx2fd5rekrSGopk
 G8FgIQA6k5ZlIsoOgbTjOajmcRKBCRDLcLepKINU7pwb0rQD9z3tpyPPtdYSvJ+iOqujc+vVS
 c+9T4g87Y6Fgq9S3yjnazmp1nOBG5lQ2TM5m0zZmdqn0um3b6hm1O2SWWWOZ/k1FK1BbELXjp
 7HN+ROAAZjXrjx+sl23pbLxV4DSqKykSzeVypt0So2YmsVF0nao6FSMNxz7uoPJdmWiIQ3jf6
 GIdwR2b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 14/12/16 20:37, Johannes Sixt wrote:
> normalize_path_copy() is not prepared to keep the double-slash of a
> //server/share/dir kind of path, but treats it like a regular POSIX
> style path and transforms it to /server/share/dir.
>
> The bug manifests when 'git push //server/share/dir master' is run,
> because tmp_objdir_add_as_alternate() uses the path in normalized
> form when it registers the quarantine object database via
> link_alt_odb_entries(). Needless to say that the directory cannot be
> accessed using the wrongly normalized path.
>
> Fix it by skipping all of the root part, not just a potential drive
> prefix. offset_1st_component takes care of this, see the
> implementation in compat/mingw.c::mingw_offset_1st_component().
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> Am 14.12.2016 um 18:30 schrieb Jeff King:
>> Would it be reasonable to
>> write:
>>
>>    /* Copy initial part of absolute path, converting separators on Windows */
>>    const char *end = src + offset_1st_component(src);
>>    while (src < end) {
>> 	  char c = *src++;
>> 	  if (c == '\\')
>> 		  c = '/';
>> 	  *dst++ = c;
>>    }
> Makes a lot of sense! I haven't had an opportunity, though, to test
> on Windows.
I'm not sure, if a conversion should be done here, in this part of code.
To my knowledge,

C:\dir1\file
is the same
as
C:/dir1/file
and that is handled by windows.

The \\server\share\dir1\file is native to windows,
and I can't see good reasons to change '\' into '/' somewhere in Git,
when UNC is used.

Cygwin does a translation from
//server/share/dir1/file
into
\\server\share\dir1\file

In other words:
The patch looks good as is, and once I get a Windows machine,
may be able to do some testing and come up with test cases


<https://msdn.microsoft.com/en-us/library/windows/desktop/aa365247(v=vs.85).aspx>
[]

