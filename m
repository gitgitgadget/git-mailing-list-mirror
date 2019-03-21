Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E6F420248
	for <e@80x24.org>; Thu, 21 Mar 2019 16:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfCUQ76 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 12:59:58 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:33833 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727921AbfCUQ75 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 12:59:57 -0400
Received: by mail-lf1-f53.google.com with SMTP id y18so5145596lfe.1
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 09:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=cAezpT08/+VeyDAXBFx9Dcr9YmxPhXMaLvTctJMx+Uc=;
        b=RBTbce/7I83w1EzomXwsiQ2Gy5y2Ul6+FCp0p3izMQLKqGFI6Jvp6STzdWZLC6wdRo
         jj4t9F1ewGLpOzD523o+JwCN9u4+EJx+6KJmuCQt54+qPp4BlDW7BvwOjfXoW0luAREh
         yDx6DPSvVhW2Y/DDL7ryRHZ4Rh3GFdcK8Rz4L5hB+j7LmaS/1WoIsfzcSKWdmWTPuNWv
         LYi3QNkfal5LQErht1xBBDhNj02EezfVOrfWwE3TI8J/jPGDQpBuTW9LlVvnhd+E5Fki
         Fex886WYTYEopnzn1oqpQw18/qdZv1ma9zFc01ZUuq8NmlLJexiAUCGkhbhgaKi7JrX/
         EcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=cAezpT08/+VeyDAXBFx9Dcr9YmxPhXMaLvTctJMx+Uc=;
        b=uPoncTTAZvlXZwyufoJBZar1flCyy4exkWZFeu3Dj+crdlC6jJgwJ8yYyNzKgDLPqo
         S4QMnlp7rqhfKYb9aEVF5SxjDcB5VDMOoBNLx/kcd8GieksrWlrgpwPxAZabfPpXqtKx
         bMti/XHdzzqGAapwX+19ByPN/Y4Dypxlfm6zDDvW3dOhZGunT+AO2tsIcglDgvaKXjlv
         9+bQR/1SchjJeR2enfW2pr9rH8yAFMz+vd7SSgI0OhxiUdkKydpEH4u5WCpr8Fwgx0ir
         qRaSuI2TkSwt1CSihognb0bsldqJUbHcPLjEobhy+r0vOnzdihDHWUz6jjxz8mvSWBrh
         +lwA==
X-Gm-Message-State: APjAAAXWbCuzj8Ji3mjwegBobi+elxrfIABphr/YeBWzJ7tIOyy+LbyQ
        7dMLcvIkW6YTqZ0NJo5SBbYNh0mU5gTVEh3owVTsVlqB
X-Google-Smtp-Source: APXvYqyzqRKOIetJFBPuN4V5Yumu5Dvv7ls6+8QiY4oSCtc+cOeJIT177N2QyBtBy2G+OmACQTvcBgJgqGY68xPkeZQ=
X-Received: by 2002:ac2:4154:: with SMTP id c20mr2543016lfi.74.1553187594725;
 Thu, 21 Mar 2019 09:59:54 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Thu, 21 Mar 2019 11:59:42 -0500
X-Google-Sender-Auth: BWbQ_nMc7s2VPDZ1-rLXzo2DpP8
Message-ID: <CAHd499BM91tf7f8=phR4Az8vMsHAHUGYsSb1x9as=WukUVZHJw@mail.gmail.com>
Subject: Strange annotated tag issue
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a particular tag in my repo that shows 2 annotated
descriptions, which is very confusing.

The command I ran:

```
git show --format=fuller 4.2.0.1900
```

And the output:

```
tag 4.2.0/1900
Tagger:     John Doe <john.doe@domain.com>
TaggerDate: Fri Jul 18 10:46:30 2014 -0500

QA/Internal Release for 4.2.0.19

tag 4.2.0/1900
Tagger:     John Doe <john.doe@domain.com>
TaggerDate: Fri Jul 18 10:46:15 2014 -0500

QA/Internal Release

commit 2fcfd00ef84572fb88852be55315914f37e91e11 (tag: 4.2.0.1900)
Author:     John Doe <john.doe@domain.com>
AuthorDate: Thu Jul 17 11:20:17 2014 -0500
Commit:     John Doe <john.doe@domain.com>
CommitDate: Thu Jul 17 11:20:17 2014 -0500

    Commit description
```

Why does it show two entries? In my `packed-refs` file, it also shows
a strange revision for the tag (I expect to see just 1 SHA1). Not sure
if it is related:

```
66c41d67da887025c4e22e9891f5cd261f82eb31 refs/tags/4.2.0.1900
^2fcfd00ef84572fb88852be55315914f37e91e11
```

Note I'm checking all of this on a bare clone (used `git clone
--mirror`). Can someone help me understand what is going on here? I
found this issue because I'm trying to do `git lfs migrate import`,
and it isn't processing my tag because of this.
