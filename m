Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FACC05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 16:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjATQgK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 11:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjATQgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 11:36:09 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BB9BCE1C
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 08:35:36 -0800 (PST)
Received: (Authenticated sender: robin@jarry.cc)
        by mail.gandi.net (Postfix) with ESMTPSA id E05EC240003
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 16:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jarry.cc; s=gm1;
        t=1674232494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jkjrPDc22hA08B3vaFeVoww3TJbIOjAScJA3sJtxCXY=;
        b=M/3SWGoyHrR/f6gY5oM8gUIHqbx+fA58PhGV4cN2wzgv473MOWtcvyGZDlPM6q5YZbYZ15
        ZqWVbpFQK+2RjL9AmfueoipSakaCN66yC0hecIy+0x5lVL6tJI+5hkHI8OfhWIRrWlRNAu
        gSmuD7OOkN5JlZj8b5Gy26b4FabILPyjEKZpAqjyHvQxBQeU9Rm9o8tH0Cit8QCuCztHie
        QdfatD6BN2A+Yn7xHApJ68i87h7rQ5WHwB/54hcQL/4EHtMlUHmyI3Ll6JcHc8PdoC7Xcd
        GoyftK5Ks03Q/fCyRd7X1CeEAXl05wC0MtnHAb4DutA0VbXsgINpyDAYzEjZSw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 20 Jan 2023 17:34:53 +0100
Message-Id: <CPX5VXD0CIF1.20UPXAWFLGISQ@ringo>
Subject: Re: [PATCH] hooks: add sendemail-validate-series
From:   "Robin Jarry" <robin@jarry.cc>
To:     <git@vger.kernel.org>
X-Mailer: aerc/0.14.0-30-g6a278ab48b1c
References: <20230103231133.64050-1-robin@jarry.cc>
In-Reply-To: <20230103231133.64050-1-robin@jarry.cc>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

This is a gentle bump to see if that feature could be of interest for
anyone.

Thanks in advance.
