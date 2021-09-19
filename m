Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0E8C433F5
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 20:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C810610A8
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 20:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhISUm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 16:42:27 -0400
Received: from mail2.pdinc.us ([67.90.184.28]:34878 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhISUm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 16:42:27 -0400
X-Greylist: delayed 873 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Sep 2021 16:42:26 EDT
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 18JKQQxJ016092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 16:26:27 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 18JKQQxJ016092
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1632083187; bh=w5HhDZ19EJKsOoKE+UvSt5uK4MAgeHAL5bBIyIg4814=;
        h=From:To:Subject:Date:From;
        b=Shxqoj8e8fZt90qkuc/nNpLKJrSsjqe/PHBvweAO1PdD+lNhTRJxqJ/6fLcDMH6Hk
         qnfingHLdUJteKP+dNslNjUVxY46/cLm8Y9Cr24XCm8dB4wtMv4PyYs7N6Ql+CRFta
         1Kb2NJazDce8oV0cXmpkGys+w2tA02ANy6XNyAcfTcax4Kj+dXrAsZ6iwrKb8Aa+8z
         OSqRox6bzjOqh/1cIR3ESJnPXaX2DZIFpP2karv2XSgcZ4wbyq7rRM10OkTKAH2eIO
         jYEBlSp7gh8l9mi+oTtpjA1XJQ16naHVV8ztX5JTjswsQvH4H7FiblDudcZ7NFbLWs
         7TfJ9zzPLdaog==
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Subject: nice to have, just sharing - cannot pull with rebase: You have unstaged changes
Date:   Sun, 19 Sep 2021 16:26:25 -0400
Organization: PD Inc
Message-ID: <375601d7ad94$9eccb5a0$dc6620e0$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdetlDFJ7udNxqy6RY+Cb4NG28GuBw==
Content-Language: en-us
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It would be nice if it did the fetch to discover the Current branch =
master is up to date before failing with You have unstaged changes.

If someone does it, send me a bill for a nice dinner - bounty offered. I =
wish I had more time.

$ git pull -r
error: cannot pull with rebase: You have unstaged changes.
error: please commit or stash them.

$ git stash
Saved working directory and index state WIP on master: 2134bc6 corrected =
acronym: ACCIDENT: Assessment, Compliance, Correlation, and Incident =
response for the DoD ENTerprise

$ git pull -r
Current branch master is up to date.

$ git stash pop
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)

--
Jason Pyeron  | Architect
PD Inc        | Certified SBA 8(a)
10 w 24th St  | Certified SBA HUBZone
Baltimore, MD | CAGE Code: 1WVR6
=20
.mil: jason.j.pyeron.ctr@mail.mil
.com: jpyeron@pdinc.us
tel : 202-741-9397



