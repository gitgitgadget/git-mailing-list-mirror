Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B011E20756
	for <e@80x24.org>; Thu, 19 Jan 2017 08:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbdASInm (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 03:43:42 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:35854 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbdASInl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 03:43:41 -0500
Received: by mail-qt0-f171.google.com with SMTP id k15so56504828qtg.3
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 00:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=0ipkqdojNlUGJDsajC8mzzUFfMdDMVrxE/aTt9KQgKw=;
        b=c52DydQnmmUoxnc5oHjUFYChKWlAUBKtNi8LEmOZXxJ/2pPO7MxS5VtcGS0JU7zf0z
         rXYXxtGZS3SSb4/JocunAx4pghrmQJicOFoxYfKhDU/hkFWJOiXn/gAfEv6R/1L6ShIf
         unez4DZOE2Uu83x2LdQp6ikl4ZSOo6WxU7lcwVrX9W23RET5+oKfNMgQTk5kGxZIF0r5
         Rd84Pq9oOhdIz2TktGYrTI6d74ODX0yEbrMFz4+HrFvAwL/7aGbRkml6hNKOJs8klLTK
         EyLUuz3X+WKbO+JDPSrsqc7UD4ygL2SE2hiY3PBzjg+wAwIkw3Fp2ZaqoOKTAg8Ytkqn
         lyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=0ipkqdojNlUGJDsajC8mzzUFfMdDMVrxE/aTt9KQgKw=;
        b=plryeXJBl2oPaBFCDJ6SIgYuILyU77rhXvFJdjy22nhOib9IuP1LPWm5848N83cGl0
         nEXj6QbGqZsTgnVQ6N/uQp9jxkBBEsixwS5laZJ+STaTQ+rLcbgOiSCqUZTeG8fkDcS7
         mBwswYev7bC1iDlJSKQcvnCPBklk95+0UtMLgzMJYJTTPCE6o35/+49dbcs8T4GNliQy
         BSzOrSdha3D+Fo5jVMBuW2limi2R7yeOkCmiKpS7DQRAA+TDfx+NVr3gnX8RYSgSGGB3
         btL+XtcyiVIjMpqRxJ/DLFJprT1ggt9/Llbq5s+Z7L7wxadECnDtC7NuCRkDIAb2UnH8
         k39Q==
X-Gm-Message-State: AIkVDXLkpC0PWdIp028h6e4M1Z1R7pUcxjWSapv/IJYBfk/qidwM33+BK72U/y+U79Wg0EnBLVPHOtWr7hJ14g==
X-Received: by 10.200.1.11 with SMTP id e11mr6344204qtg.85.1484815371841; Thu,
 19 Jan 2017 00:42:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.66 with HTTP; Thu, 19 Jan 2017 00:42:31 -0800 (PST)
In-Reply-To: <CAKcFC3ZN+=o_2t4AawCE0c4Tw+t_XJKTHtEq9d7bv-ht5euPbw@mail.gmail.com>
References: <CAKcFC3aqjLNUNKPDZ08rO_SBkY84uvHBerCxnSchAe8rH0dnMg@mail.gmail.com>
 <CAKcFC3ZN+=o_2t4AawCE0c4Tw+t_XJKTHtEq9d7bv-ht5euPbw@mail.gmail.com>
From:   jean-christophe manciot <actionmystique@gmail.com>
Date:   Thu, 19 Jan 2017 09:42:31 +0100
Message-ID: <CAKcFC3aHZP5-MJaNj4vv_qBwY3xNRodYnfw0P-G-Q+XfaRf=Cw@mail.gmail.com>
Subject: Re: fatal: bad revision 'git rm -r --ignore-unmatch -- folder'
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also some context information:
Ubuntu 16.10 4.8
git 2.11.0

On Thu, Jan 19, 2017 at 9:32 AM, jean-christophe manciot
<actionmystique@gmail.com> wrote:
> In case you were wondering whether these files were tracked or not:
>
> git-Games# git ls-files Ubuntu/16.04
> Ubuntu/16.04/residualvm_0.3.0~git-1_amd64.deb
> Ubuntu/16.04/scummvm-data_1.8.0_all.deb
> Ubuntu/16.04/scummvm-data_1.9.0_all.deb
> Ubuntu/16.04/scummvm-dbgsym_1.8.2~git20160821.bad86050_amd64.deb
> Ubuntu/16.04/scummvm-dbgsym_1.9.0_amd64.deb
> Ubuntu/16.04/scummvm_1.8.0_amd64.deb
> Ubuntu/16.04/scummvm_1.9.0_amd64.deb
>
> On Tue, Jan 17, 2017 at 4:30 PM, jean-christophe manciot
> <actionmystique@gmail.com> wrote:
>> Hi there,
>>
>> I'm trying to purge a complete folder and its files from the
>> repository history with:
>>
>> git-Games# git filter-branch 'git rm -r --ignore-unmatch --
>> Ubuntu/16.04/' --tag-name-filter cat -- --all HEAD
>> fatal: bad revision 'git rm -r --ignore-unmatch -- Ubuntu/16.04/'
>>
>> git does not find the folder although it's there:
>>
>> git-Games# ll Ubuntu/16.04/
>> total 150316
>> drwxr-x--- 2 actionmystique actionmystique     4096 Nov 19 13:40 ./
>> drwxr-x--- 4 actionmystique actionmystique     4096 Oct 30 14:02 ../
>> -rwxr-x--- 1 actionmystique actionmystique  2190394 May  9  2016
>> residualvm_0.3.0~git-1_amd64.deb*
>> ...
>> -rw-r--r-- 1 actionmystique actionmystique 67382492 Oct 13 09:15
>> scummvm-dbgsym_1.9.0_amd64.deb
>>
>> What is going on?
>>
>> --
>> Jean-Christophe
>
>
>
> --
> Jean-Christophe



-- 
Jean-Christophe
