Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D12C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 09:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADAC020663
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 09:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ojq4xqOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfLJJqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:46:44 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:42170 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfLJJqo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 04:46:44 -0500
Received: by mail-io1-f43.google.com with SMTP id f82so18081982ioa.9
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 01:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/ve3gGVB1Cw/WBbGYxx0p1NsH4duZNxfNFOIjn0nu6I=;
        b=Ojq4xqOrBMtuPj+L0QvTyQvR2KpKg52FC1qSZvOMlp6BbyZy2yGG4W2IeHxAbW8lOL
         0bTVYTvZfcyLuwUBSO8WLfJEodKEr+FSOPC1KU7tTw66FQap8exdXVLVsY7GFMxNAu+7
         5WIHIU5nXkNxMseQFBfiM63aRElxL+VJIr4fTkMVQAmck5rgs8M5Ea6ntMRL/iPT9aso
         mvdVWlQqoPGOLa33FBeN90DzlcfrS0AWZNPVICnertD3eIHHFSmQ/0FD7d6ic67oLbW/
         gFaqnGTSfl9lFv+XUwNb0nnLUgUd9Nhefp2PpZ0ul22kw9nfz9iRYabNuYGplxsxlQgj
         U3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/ve3gGVB1Cw/WBbGYxx0p1NsH4duZNxfNFOIjn0nu6I=;
        b=XEb/Hz5/uL+h6j4eED6SquZYXMJ5HesPIYqspQZr32ukSFyZ0bZ0QKGCQUVhyrhdD2
         stsqsupdIphiBcr4DdcYaOsupTItocwKl6nMzdMJawXQNCwjiZQtSMEIudJUlMVGA3g/
         io22ftGfTEygds1UrBrdrFOgTL+OQJI33a3XYpxkgoxeZA5eJqVJHTkayl6PSuTtUhKL
         45uYI1YMPOhhBl3tvJea1RCqazjpycwFkUKhZKhKhG+ddo6cml8IZejpHKc+1dMmmXd0
         R/MpnYfZ9enpoPVl+Z6gO4yi58URiWhv7TJ9Z44gY26GRJcdepcNUzzSldT8CKSwSsqB
         +Hyw==
X-Gm-Message-State: APjAAAUcWt3BUIkpVBQC/hBF3ou6lQKTs3YGKugnsEpuwAHLR69r2dh6
        LWZJeXvCPL127i2Dx0PChTte5RwN+Z5rdVROt3Wg+6T01JA=
X-Google-Smtp-Source: APXvYqzLf73iat3w/rWy15eHzwMt43l8y40gvsvnXICxJk429rWYRbWDWlGfhAGZpT+1i8E3qSNbiS7KllDgDD7BNYI=
X-Received: by 2002:a6b:ed17:: with SMTP id n23mr4093695iog.99.1575971203901;
 Tue, 10 Dec 2019 01:46:43 -0800 (PST)
MIME-Version: 1.0
From:   "Miriam R." <mirucam@gmail.com>
Date:   Tue, 10 Dec 2019 10:46:33 +0100
Message-ID: <CAN7CjDAu8-q6BR7sT4w_AccciGyk81AON+wyMjce+YJ_nc3WgA@mail.gmail.com>
Subject: [Outreachy] New Outreachy post.
To:     git <git@vger.kernel.org>
Cc:     "Miriam R." <mirucam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear all,
as an Outreachy intern I have to post on an experience blog during my
internship. This is my new entry with the first week in Git project:

https://mirucam.gitlab.io/outreachy_blog/post/week1/

in case you find it interesting for reading.
Comments, advice or insight about the topics I am writing are always welcome:).

Thank you,
Miriam.
