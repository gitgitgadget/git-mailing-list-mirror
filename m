Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9676820248
	for <e@80x24.org>; Mon, 11 Mar 2019 17:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfCKRz1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 13:55:27 -0400
Received: from mout.web.de ([212.227.15.4]:33689 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbfCKRz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 13:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1552326920;
        bh=j6S+CBslGGcmGdKv4gAHRldUeAqBMeD3kKgKAfgL4uk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=PE7jm2RMLHn8chCo4DhHpifi73eGeNJkF9p1gZrG50OeA45ypq302aiOggeO/r0OK
         Npkc5osNGMH2PP99tK6hrn3jV04BARntHwAYcJtGvOdBOLDQ9f+9eYQnxpJJwmnH5d
         ndC9/V6XK0RFHe7qltvcTDkr/zvW8U+/KuYqGZXw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LbrTY-1gbjuG1ElI-00jMix; Mon, 11
 Mar 2019 18:55:20 +0100
Date:   Mon, 11 Mar 2019 17:55:19 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: `git add <<windows 8.3 path to file inside repo>>` results in
 "fatal: ... is outside repository"
Message-ID: <20190311175519.6lbppv5u44w2u4sj@tb-raspi4>
References: <CA+dzEBkkbQj0rCjvPfcET2Uvt6fP_v+wQE52ZkAND2Mps08SNQ@mail.gmail.com>
 <10972e0e-7fe1-437f-efe6-cff82a1205e0@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10972e0e-7fe1-437f-efe6-cff82a1205e0@kdbg.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:JLZwysBt7JbqOp3Dg8qAxh7ojlqmxIjSKWBeqTIPKkO7e29TF0B
 9YI1CScMYjd/+nBASRoXoaMgzC1tdRaMk1WfhhO6hXOXn9Itnw1hG+nbKWNNad3hQq/4s5J
 F9/yO8os1PKNgdeA5pIII/KaYgxYNNdQsyrEei0D5BxK6ci6n7PAQfv1nVDEZ6iCtksZhJE
 a9S3VZi6YLTPtAwfvG1Bw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G8Q95BZ0juo=:otgY+qU32NVItwwBj7QWti
 GuA++F2cRzr+OKi8whAtwZGlPjuCZjIbLnq1SkFpMtpQhBEbh1mMpncMz07hdNQqwrqpLLaSH
 tXFfaIHCQEWEdNt0v709QZas1UfHbKhyLY++DrgnXKyYAN3CTcmY+WUBWrkNhSqwvU5aO0fIE
 j1keb5/rqhbCezSHrPfdSSJ24GpXiCEMd8LuPKq2okorlsuLfJqvov2YNzQ72i+RW5puDnwOs
 fOyqzFVZslKz9Wh9+cg4kwAexbqH8+yHkAI8zGts4uzlCfG3+I4KSRGJ4OzG8YbpyS2dlw72/
 ZAO8mbmxKaOp5RMLBcPd2dHljMrnClcCWq7Rs47r5UfO58MhYU1XCPsUjrXj8cUbL1iyhHJU4
 s8fC8RfWP35OxX6zrDKB/Vn29wCh2e2zADSQAOb7O3hhXIrUCRLja5iif1EVBmH4DAaxBfTe6
 +6wZERyTYsh020kAuRTNsnVdIh2doWgVS7YIuQzyr3fRFpM90xusFzT/kkG+bB0Cx/W8dkp0r
 q5KAnQ9/z7VrFvfZTvr2ENyL7n4NXk/e3K2Jh/05r1i4oC8r41hFW+g5lVSfJyow/RjZEU0e0
 UlIhTAs+LzEU+5pOJJzlBmMrahy/zYhnzCcW2HoNGczcDRDcRLwGD5ExviPf2DrP423iMO/BD
 V1HRQep0T2ayK17Bv7UniFR9u+eBpXo3eoowai6YorjLNoBH4hbpaCzywv03vewRAF1/gAdzQ
 aruCDMDisISKkM7Iklk8ZmzMKlXqRB3I2ixco+Xb8p5B7KBL8EyDjr5Y7DaMA9hVzrwhbnTSO
 o+fKebvsgvUAuxyLI3uU5qcytcpVngmReT/KJ9JDflQC1+wvo1U8sQJfUZMFa4a+MgMGmkMku
 PzEoSnQBTM4kG8CCQHVU/SHdoqnLrBCLAQqM59slCRPwQdL+W1BGvP1nOqfd5o
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 06:48:11PM +0100, Johannes Sixt wrote:
> Am 10.03.19 um 23:41 schrieb Anthony Sottile:
> > git init longname-repo
> > cd longname-repo
> > touch f
> > git add ..\longna~1\f
> >
> ...
> >
> > C:\Users\Anthony\AppData\Local\Temp\t\pre-commit-hooks\longname-repo>g=
it
> > add ..\longna~1\f
> > fatal: ..\longna~1\f: '..\longna~1\f' is outside repository
>
> This has nothing to do with long vs. short path names. It would report
> the same error when you say
>
>   git add ..\longname-repo\f
>
> -- Hannes

You can probably do another test:

 mkdir longname-rexxx
 git init longname-repo
 cd longname-repo
 touch f
 git add ..\longna~1\f

And now nobody knows for shure if "longna~1"
is longname-rexxx or longname-repo

It may happen that it is longname-rep at this point in time,
at your machine.
It may happen that it is a complete different directory on another machine=
,
or even on your machine.
For that reason, to avoid that someone tampers data outside a repo,
"../" (or ..\ under windows) is not accepted by Git.
