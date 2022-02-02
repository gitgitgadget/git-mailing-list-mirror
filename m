Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9776C433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 18:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244932AbiBBShE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 13:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbiBBShD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 13:37:03 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9788DC061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 10:37:03 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 4so16932827oil.11
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 10:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=delphia.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=zV33tqQ5BlCO65PDauzFNyC36oWiKrIXxiNE3e8TmG0=;
        b=J7MGt6nWlU38IQhG6Se1Pe2ADQvL1JUhRAMH3clBoli8FRMfMGIbBJpbeAubToF1uP
         IGMc8wCSwiA0iookUva7SMc/vhgX7WT2Mj4DTl4ExiAmMs2bqnX4PFyVeH3SHScR4ciN
         MdCqmQiVphIjKbcYJWkR6GS1CHbG5xWBZwkTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zV33tqQ5BlCO65PDauzFNyC36oWiKrIXxiNE3e8TmG0=;
        b=7GpgSX5mKOy8BXXUVgQ4hKMWUDqidmU9hCvUhGsh2l60oz6f15NSH/iLY4kUyvEmv+
         mn4L0BX9Qq2S4Dqk7Qs6/elP1Di1I/c3zTVUmKzJZqtHxxDtHzqhKlAjh8u+HqHCMZD+
         KzxAyK2SWJ9gX2NLbbSY5JRjvi6UEsyXAFujjz0Ni48da8X97w+NDOICemwRnALQRbXK
         WsEngi8yaPmyndekwHRfMYhEMg/AM205kNXKdUgDluHJ7GPDNizF8bp8rQqf+F+bxhsE
         lILPJ7P6OfdO1qyMTZqrZiTAdhygb1vPJHGB+HklHulwwNUKn9/fb//YTMy7mvC3Y1A+
         yTBQ==
X-Gm-Message-State: AOAM530d5NrBvT97hRxY8DOGJL7zAHE+NBLeaqrh/j2RvXVKOnTkrFe6
        Kg1E3OPt+6tF6JtPgfBTOPfJ+WJDrZXjhtUzJMA1BKa5XUG/
X-Google-Smtp-Source: ABdhPJz8qqnTj1dJdTF8vaqIIh4H+7ECstBbNw0aBtfLI4PIWyI5iaKKjzcC7elY/WRa5bus5oZto/8lgnJaO0gFMQE=
X-Received: by 2002:a05:6808:f05:: with SMTP id m5mr5135840oiw.337.1643827022396;
 Wed, 02 Feb 2022 10:37:02 -0800 (PST)
MIME-Version: 1.0
From:   Zhuo Cheng Du <zhuo@delphia.com>
Date:   Wed, 2 Feb 2022 13:36:51 -0500
Message-ID: <CA+RO+X5sxqhB3ONx7JseHEyctYBLrzCtwofyQ4+z5cgDzQROoQ@mail.gmail.com>
Subject: Git Bug Report: 'git stash pop' always put new files into staging
 area, regardless of '--index' option
To:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000be214105d70d4d60"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000be214105d70d4d60
Content-Type: text/plain; charset="UTF-8"

Hi there,

Please see attached for a bug I encountered while using 'git stash'.
Also, is there any bug tracker that I can subscribe to to keep me
updated?

Thanks,


-- 

Zhuo Cheng Du

Software Engineer

Delphia

1 833-335-7442
zhuo@delphia.com
www.delphia.com
300-501 Queen St. W., Toronto, ON, M5V 2B4

--000000000000be214105d70d4d60
Content-Type: text/plain; charset="US-ASCII"; name="git-bugreport-2022-02-02-1318.txt"
Content-Disposition: attachment; 
	filename="git-bugreport-2022-02-02-1318.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kz5w5qm80>
X-Attachment-Id: f_kz5w5qm80

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCjEuIENyZWF0ZSBhIGJyYW5kIG5ldyBmaWxlLCBlLmcuICd0b3Vj
aCBhLnB5JwoyLiBBZGQgaXQgdG8gd29ya3RyZWUgd2l0aCAnZ2l0IGFkZCBhLnB5JwozLiBzdGFz
aCB0aGUgZmlsZSB3aXRoICdnaXQgc3Rhc2gnCjQuIHBvcCB0aGUgc3Rhc2hlZCBjaGFuZ2Ugd2l0
aCAnZ2l0IHN0YXNoIHBvcCcsIFdJVEhPVVQgdGhlIC0taW5kZXggb3B0aW9uCldoYXQgZGlkIHlv
dSBleHBlY3QgdG8gaGFwcGVuPyAoRXhwZWN0ZWQgYmVoYXZpb3IpCkkgZXhwZWN0IHRoZSBmaWxl
ICdhLnB5JyB0byBiZSBpbiB1bnN0YWdlZCBhcmVhIHNpbmNlIEkgZGlkIG5vdCBwYXNzIHRoZSAn
LS1pbmRleCcgb3B0aW9uIHRvICdnaXQgc3Rhc2ggcG9wJwpXaGF0IGhhcHBlbmVkIGluc3RlYWQ/
IChBY3R1YWwgYmVoYXZpb3IpClRoZSBmaWxlIGlzIGZvdW5kIGluIHN0YWdlZCBhcmUgYXJlIGFm
dGVyICdnaXQgc3Rhc2ggcG9wJywgcG90ZW50aWFsbHkgY2F1c2luZyBtZXJnZS1jb25mbGljdCBp
biBjZXJ0YWluIHNjZW5hcmlvcwpXaGF0J3MgZGlmZmVyZW50IGJldHdlZW4gd2hhdCB5b3UgZXhw
ZWN0ZWQgYW5kIHdoYXQgYWN0dWFsbHkgaGFwcGVuZWQ/Ckkgd2FudCB0aGUgZmlsZSB0byBiZSBm
b3VuZCBpbiB1bnN0YWdlZCBhcmVhLiBUaGUgJ2dpdCBzdGFzaCBwdXNoJy8nZ2l0IHN0YXNoIHBv
cCcgY29tYm8gd29ya3MgYXMgZXhwZWN0ZWQgaWYgdGhlIGZpbGUgaXMgYWxyZWFkeSBhZGRlZCB0
byB3b3JrdHJlZSBwcmlvciB0byB0aGlzIG1hbmV1dmVyLiBJIHRoaW5rIHRoZSBiZWhhdmlvciBz
aG91bGQgYmUgY29uc2lzdGVudCBmb3IgYnJhbmQgbmV3IGZpbGVzIGFzIHdlbGwuCkFueXRoaW5n
IGVsc2UgeW91IHdhbnQgdG8gYWRkOgoKUGxlYXNlIHJldmlldyB0aGUgcmVzdCBvZiB0aGUgYnVn
IHJlcG9ydCBiZWxvdy4KWW91IGNhbiBkZWxldGUgYW55IGxpbmVzIHlvdSBkb24ndCB3aXNoIHRv
IHNoYXJlLgoKCltTeXN0ZW0gSW5mb10KZ2l0IHZlcnNpb246CmdpdCB2ZXJzaW9uIDIuMzEuMApj
cHU6IHg4Nl82NApubyBjb21taXQgYXNzb2NpYXRlZCB3aXRoIHRoaXMgYnVpbGQKc2l6ZW9mLWxv
bmc6IDgKc2l6ZW9mLXNpemVfdDogOApzaGVsbC1wYXRoOiAvYmluL3NoCnVuYW1lOiBEYXJ3aW4g
MjEuMy4wIERhcndpbiBLZXJuZWwgVmVyc2lvbiAyMS4zLjA6IFdlZCBKYW4gIDUgMjE6Mzc6NTgg
UFNUIDIwMjI7IHJvb3Q6eG51LTgwMTkuODAuMjR+MjAvUkVMRUFTRV9YODZfNjQgeDg2XzY0CmNv
bXBpbGVyIGluZm86IGNsYW5nOiAxMi4wLjAgKGNsYW5nLTEyMDAuMC4zMi4yOSkKbGliYyBpbmZv
OiBubyBsaWJjIGluZm9ybWF0aW9uIGF2YWlsYWJsZQokU0hFTEwgKHR5cGljYWxseSwgaW50ZXJh
Y3RpdmUgc2hlbGwpOiAvYmluL3pzaAoKCltFbmFibGVkIEhvb2tzXQo=
--000000000000be214105d70d4d60--
