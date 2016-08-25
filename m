Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A1E51FD99
	for <e@80x24.org>; Thu, 25 Aug 2016 06:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757283AbcHYG2w (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 02:28:52 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:43509 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755279AbcHYG2w (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 25 Aug 2016 02:28:52 -0400
X-AuditID: 1207440f-e2bff70000000955-b4-57be901f293e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 28.66.02389.F109EB75; Thu, 25 Aug 2016 02:28:50 -0400 (EDT)
Received: from [192.168.69.190] (p57907590.dip0.t-ipconnect.de [87.144.117.144])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u7P6Si5S003210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 25 Aug 2016 02:28:45 -0400
Subject: Re: on Amazon EFS (NFS): "Reference directory conflict: refs/heads/"
 with status code 128
To:     Jeff King <peff@peff.net>, Alex Nauda <alex@alexnauda.com>
References: <CAMQLHmAraXPL=8SmMG4X_424FAzx4q2Byk8pva5wEOg7vNSqLw@mail.gmail.com>
 <20160824213900.gcnwxu46zvgpjr5a@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <67cde0aa-89fc-b574-d5f5-7e754d77b5bb@alum.mit.edu>
Date:   Thu, 25 Aug 2016 08:28:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160824213900.gcnwxu46zvgpjr5a@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsUixO6iqKs0YV+4weZ3uhZ37k9jtui60s1k
        8aOlh9mB2eNP40Mmj2e9exg9Pm+SC2CO4rJJSc3JLEst0rdL4MpYtvcMY8EqkYr/M6exNzDu
        F+hi5OCQEDCRmDOJp4uRi0NIYCujxO+9HxkhnAtMEgf+9jF1MXJyCAukSFx9848NxBYRsJNY
        dfsDO0RRF6PEy2svWEASzALiEuvmnmcHsdkEdCUW9TSDNfMK2Esca7kHZrMIqEocej4LbJCo
        QIhE+7L1UDWCEidnPgGbwyngIrHrcQ8bxEx1iT/zLjFD2PIS29/OYZ7AyD8LScssJGWzkJQt
        YGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRropebWaKXmlK6iRESpPw7GLvWyxxiFOBgVOLh
        FVi7N1yINbGsuDL3EKMkB5OSKC9L975wIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8kV1AOd6U
        xMqq1KJ8mJQ0B4uSOK/6EnU/IYH0xJLU7NTUgtQimKwGB4fAlYNHZjNKseTl56UqSfBu6wMa
        IliUmp5akZaZU4JQysTBCbKIB2jRbZAa3uKCxNzizHSI/ClGRSlxXi6QhABIIqM0D64Xllxe
        MYoDvSXMy9EPVMUDTExw3a+ABjMBDW65vxtkcEkiQkqqgbFs08UDXJ22senbzK5L73guszW1
        JM3radoTcZ4ZG3v9jhQIayytfBci3Thp+/5M9asFoRd4yvIO38vsf81ePOvBh0xj5+f3X+8P
        Wrn6r13rVe0ZP7cdkMjMsw0IFdBlDn/lLpi3zm3tqiXmDwQ915gYfjjPezu29vGP91sbHCrc
        dvlK5mjeP6nEUpyRaKjFXFScCAAyqNS8CQMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/24/2016 11:39 PM, Jeff King wrote:
> On Wed, Aug 24, 2016 at 04:52:33PM -0400, Alex Nauda wrote:
> 
>> Elastic File System (EFS) is Amazon's scalable filesystem product that
>> is exposed to the OS as an NFS mount. We're using EFS to host the
>> filesystem used by a Jenkins CI server. Sometimes when Jenkins tries
>> to git fetch, we get this error:
>> $ git -c core.askpass=true fetch --tags --progress
>> git@github.com:mediasilo/dodo.git
>> +refs/pull/*:refs/remotes/origin/pr/*
>> fatal: Reference directory conflict: refs/heads/
>> $ echo $? 128
>>
>> Has anyone seen anything like this before? Any tips on how to troubleshoot it?
> 
> No, I haven't seen it before. That's an internal assertion in the refs
> code that shouldn't ever happen. It looks like it happens when the loose
> refs end up with duplicate directory entries. While a bug in git is an
> obvious culprit, I wonder if it's possible that your filesystem might
> expose the same name twice in one set of readdir() results.
> 
> +cc Michael, who added this assertion long ago (and since this is the
> first report in all these years, it does make me suspect that the
> filesystem is a critical part of reproducing).

Thanks for the CC.

I've never heard of this problem before.

What Git version are you using?

I tried to provoke the problem by hand-corrupting the packed-refs file,
but wasn't successful.

So Peff's suggestion that the problem originates in your filesystem
seems to be to be the most likely cause. A quick Google search found,
for example,

    https://bugzilla.redhat.com/show_bug.cgi?id=739222

http://superuser.com/questions/640419/how-can-i-have-two-files-with-the-same-name-in-a-directory-when-mounted-with-nfs

though these reports seem connected with having lots of files in the
directory, which seems unlikely for `$GIT_DIR/refs/`. But I didn't do a
more careful search, and it is easily possible that there are other bugs
in NFS (or EFS) that could be affecting you.

If this were repeatable, you could run Git under strace to test Peff's
hypothesis. But I suppose it only happens rarely, right?

Is it possible that multiple clients have the same NFS filesystem
mounted while Git is running? That would seem like an especially bad
idea and I could imagine it leading to problems like this.

It's surprising that you are seeing this problem in directory `refs`,
because (1) that directory is unlikely to have very many entries, and
(2) as far as I remember, Git will never delete the directories
`refs/heads` and `refs/tags`.

Michael

