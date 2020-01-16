Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216D7C33CB1
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 11:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65E12077C
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 11:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="fhUq8UBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgAPLaV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 06:30:21 -0500
Received: from mail-40130.protonmail.ch ([185.70.40.130]:62990 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgAPLaV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 06:30:21 -0500
Date:   Thu, 16 Jan 2020 11:30:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1579174219;
        bh=aSAHua+62O3g9Cko3fi8Eul01uVNXgQztgC0Hk/VUiY=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=fhUq8UBUP7jBXESLC9m8/7RlXJnn81FltRVvLboTbRvT+4YjAxPmtVsR/o7ZQOYO/
         7xz7qFPNcK4OrYoTrWIBrpcTCnyMsr912+gpNaT8wZJMWOaYptEndorEjXwRMW0tOI
         vOApeE0whqMZ7b/HK/VSH11B3r4XF4/nJBkJ6Hac=
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   gritzmann <gritzmann@protonmail.com>
Reply-To: gritzmann <gritzmann@protonmail.com>
Subject: How do I change the AuthorDate and CommitDate of all my commits?
Message-ID: <Ogtz26tj4ZgCMamF3jprc21AvPiEvWlYS9IgAwPDAPOJHd0THDCaNSwNi6qjUxE9ZknGw-87P7wnnQUkH3khrFnEXoAy8VvmEuBpVLpQ3Qw=@protonmail.com>
Feedback-ID: alRbSGp8IdM2v-yEknPK_zIurd3U-KEt5aWGvEavlKO18j8LuqtY6bgibnvWg3tcO5Aaod6sSp7W_XMaibKHWQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I*m looking to completely anonymize the timestamps of my files and repos Fo=
r the files themselves I changed their access, modify, change and birth tim=
es like this: `touch -acm -d "1980-01-01 00:00:00"`.

But how do I do the same for the AuthorDate and CommitDate of all my commit=
s?

Thanks!

Sent with ProtonMail Secure Email.
