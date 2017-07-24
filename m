Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 559C8203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 19:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755766AbdGXTCR (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 15:02:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34018 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755749AbdGXTCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 15:02:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id c184so1243230wmd.1
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 12:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:mime-version:in-reply-to:content-transfer-encoding
         :message-id:cc:from:subject:date:to;
        bh=5Ds4oYFFc0fTH52LynntvpNY1fZ1FSQxA7zTbE/7xJw=;
        b=qBCzcAjYUGBR7/MYWygdMy7aMehF51t4/9uvMsaLse9ZFfH7MZ+4Ow2/Ci6tGVmjpv
         Q07wbXHWW361sd21Y/pOula2D7SODz5YQVdGFMDIDJg7plZz0FuIVHYKa7RZ4wy1LF89
         YIOwLcIZsQS3s9XIEQ9MxUIMjpZziM6wcqODL9sIkzIwbO03L7wCIoSxFbhCFrZZcivC
         RObcjWd74D4AOC4NPnAU5AWZM/TBZA2Z+NLOhg4niyukW9w6kvXJtPtPYCWZkdW70/lI
         p3BshMvq7++C9ndaZJObNUkrwx6nhOcs7oJFTzibNatQ8kDQOd3oecDRoTzdzB8ov5Zt
         avBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:mime-version:in-reply-to
         :content-transfer-encoding:message-id:cc:from:subject:date:to;
        bh=5Ds4oYFFc0fTH52LynntvpNY1fZ1FSQxA7zTbE/7xJw=;
        b=cDIj9GwCp2PQy+1HaI28SDc4gNenZIOEzTCzffMhf4IUbDERRYNXsXQ7KVxYK9MoRQ
         q8EBtIFUA7TjtmNgND6KTOvmvPsw6ThVK+9jfaqxCeRKIM2zWzK1t2BdB8LIjGIOfFYN
         v6JoNuqHl6k716K/cYm1f7fflwjxyBgQGHrOtrlpO/UA8hvo5UV5qvfiU+UDToY4o01U
         JhAhZluYd2S33Se6BHy7uqeux2YeKMRz16aZHwncjBwaAf1Np13F6QriZvuGiJOLxmOB
         VbGSyqqJK8KNu1QMN2fYFWXCPV+U/WSr96SW93tcWgoJuAC8hk6cxAs7ew5u3aBZluED
         vK2A==
X-Gm-Message-State: AIVw113DJWWPeWIACe+nzKRIjfE7zT0ASpKQII9UGNGkPwqYZupgOlNq
        vdJ8UyXLxcOHVq7Tz70=
X-Received: by 10.28.141.142 with SMTP id p136mr5925288wmd.125.1500922934651;
        Mon, 24 Jul 2017 12:02:14 -0700 (PDT)
Received: from [192.168.0.8] (h081217003026.dyn.cm.kabsi.at. [81.217.3.26])
        by smtp.gmail.com with ESMTPSA id h16sm11940052wrc.89.2017.07.24.12.02.13
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 12:02:14 -0700 (PDT)
References: <CAEor4NHDNL4CQP_FpCuJ_3F86-A3P8i=yvp1AZr-NKt0i1=cXw@mail.gmail.com> <20170724181835.zo3lcv7pxmkif2jr@sigill.intra.peff.net>
Mime-Version: 1.0 (1.0)
In-Reply-To: <20170724181835.zo3lcv7pxmkif2jr@sigill.intra.peff.net>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <7DE91669-D603-4C83-9151-78F2D5676E36@gmail.com>
Cc:     git@vger.kernel.org
X-Mailer: iPad Mail (13G36)
From:   "tonka3100@gmail.com" <tonka3100@gmail.com>
Subject: Re: change the filetype from binary to text after the file is commited to a git repo
Date:   Mon, 24 Jul 2017 21:02:12 +0200
To:     Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Jeff,

Thx for your answer.

There is no .gitattributes file in the repo. I think that the git heuristic w=
ill also detect utf-16 files as binary (in windows), so i think that is the r=
eason why my file is binary (i have to check that tomorrow). If i add a .git=
attribute file i have the problem that git diff will treat the old and the n=
ew blob as utf-8, which generate garbage.

Do you have another idea?
Could it be possible to add only a space in code (utf-8) and then add the re=
al content in a second commit, so the old and the new one are both utf-8?

> Am 24.07.2017 um 20:18 schrieb Jeff King <peff@peff.net>:
>=20
>> On Mon, Jul 24, 2017 at 07:11:06AM +0200, tonka tonka wrote:
>>=20
>> I have a problem with an already committed file into my repo. This git
>> repo was converted from svn to git some years ago. Last week I have
>> change some lines in a file and I saw in the diff that it is marked as
>> binary (it's a simple .cpp file). I think on the first commit it was
>> detected as an utf-16 file (on windows). But no matter what I do I
>> can't get it back to a "normal text" text file (git does not detect
>> that), but I is now only utf-8. I also replace the whole content of
>> the file with just 'a' and git say it's binary.
>=20
> Git doesn't store a flag for "binary-ness" on each file (though see
> below). As the diffs are generated on the fly when you ask to compare
> two versions, so too is the determination of "is this binary".
>=20
> The default heuristic looks at file size (by default, if the file is
> over 500MB it's considered binary) and whether it has any zero-byte
> characters in the first few kilobytes. But note that if _either_ side of
> a diff is considered binary, then Git won't show a text diff.
>=20
> If you want a particular diff to show all content, even if it doesn't
> look like text, add "-a" to your git invocation (e.g., "git show -a").
>=20
> That said, you can also use .gitattributes (see "git help attributes")
> to mark a file as binary or not-binary, skipping the heuristic check.
> I'm guessing since you converted from svn that you don't have a
> .gitattributes file, but it's possible that somebody later added one
> that marks the file as binary (and so the solution would be to drop that
> entry).
>=20
> -Peff
