Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A17131F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 16:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752634AbcIIQmr (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 12:42:47 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36798 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752151AbcIIQmq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 12:42:46 -0400
Received: by mail-oi0-f50.google.com with SMTP id q188so36752364oia.3
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 09:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IlllhD/YWW023vnaRE8MsGCWmRCjAaRiNkGao2Ri+3w=;
        b=KgdS7QAmzqFSc7ATQBYEH5A1zstwMPEA6NuF945WWFLyojNn6pE1BsH8+EDWy9JF+R
         nsObpBmjwPGnCJ4dPCVjxRW9dJF3UhZJopdaKbsE94oJQrgO0dvCiTW4ys9LEApKBda3
         VV9eMThgE8Lgc7hJYMShi99kq0BTN5v1Kjk0yQXsankI2xveTJ7riMjRK+5W0PjYMMvz
         kVPpApCkPpO7VmfqKpLc5fWz5Hfg8yOBWVEFJxEtmfpCyIWRLVNaMDcsnk0/GinOTN5z
         Jp8zjwoq5vDTr/8LsJxRF7bCMfz6yVYDAI0kj/qPW+xufPDjnafactHQ4Mrv98X3nQcX
         90jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IlllhD/YWW023vnaRE8MsGCWmRCjAaRiNkGao2Ri+3w=;
        b=baVON9qGNx+WptdWzKAHI8rDGfqDfwPwd2l66e9b7NwnYwfTchOawyvDvSTp132gqy
         mch2wpMycPULrOYvLwXQtdIPouuLxk27NDvaOjeqhbYpLqR5MkplYWLxZMcxcX3cog4a
         /2VAg/ieM5AHo8Dd4Qhm5kyJ5nR/IfHXTn0tpnSOx2KJEifjfoAe+SOmDVefvwM6Y/Kr
         iB6dj7pSZ9zMx796BNrMYXIL0YqgMoa/Ie1Irpdj4iwEFcbcQHFWGcznuVpDZO2smHFj
         dpubFQ5H3DUoQ/h5LBzHcZrGOaNeAkoq54H49XKHAawTcRCMr23ES1bJkO8jsvdHkGEW
         fQNg==
X-Gm-Message-State: AE9vXwOmC17TwZi3xeIK3KvCOa9VCJYEwaav7axVHQaPfninfqy2is7QZMlkwzXU7As/gcKUu83Q3svAUqIfTwRt
X-Received: by 10.202.195.1 with SMTP id t1mr7443670oif.144.1473439365871;
 Fri, 09 Sep 2016 09:42:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 9 Sep 2016 09:42:45 -0700 (PDT)
In-Reply-To: <4c42a1f4-4f03-0fdf-8bd2-8a7f1f978073@accelya.com>
References: <4c42a1f4-4f03-0fdf-8bd2-8a7f1f978073@accelya.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 9 Sep 2016 09:42:45 -0700
Message-ID: <CAGZ79kYu=0ik9W9g5yCbc5142_a2fb1er45TFEZ6RrekZRZM9w@mail.gmail.com>
Subject: Re: Missing RPM spec file in tarball
To:     =?UTF-8?Q?Sergio_Mart=C3=ADn_Turiel?= <sergio.martin@accelya.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 9, 2016 at 9:19 AM, Sergio Mart=C3=ADn Turiel
<sergio.martin@accelya.com> wrote:
> Hello,
>
>
>  I am trying to build RPM packages from tarball (release 2.9.3 and 2.10.0=
),
> and i do not find git.spec file, in previous releases i can found it (e.g=
.
> 2.8.3).
>
> O.S.: CentOS 7.2
> Command: rpmbuild -ta git-2.9.3.tar.gz
> Response: error: Failed to read spec file from git-2.9.3.tar.gz
>

We deleted the rpm target as it was breaking all the time and not reported
in a timely manner, i.e. the impression was it was always broken.

See https://kernel.googlesource.com/pub/scm/git/git/+/ab214331cf8c73f8f7754=
0aa996eb8b4938237f2


> Can you tell me what I'm doing wrong?

Not crying out loud when that commit was discussed on the
mailing list. ;)

>
>
> Thank you very much and best regards, Sergio Mart=C3=ADn.

Thanks,
Stefan
