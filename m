Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 819A11FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 16:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002AbcHNQ3z (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 12:29:55 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34980 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbcHNQ3y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 12:29:54 -0400
Received: by mail-oi0-f54.google.com with SMTP id 4so37635112oih.2
        for <git@vger.kernel.org>; Sun, 14 Aug 2016 09:29:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=eLA/IWpi+XT2hI2jwn871YyFD0AJNa61ztcc7fUtCic=;
        b=oi26an9/TtgQjU6rbfBydMimvaAcLX2Jdielzw329ly1ZVgAxUKUtOfooI24ATQCz8
         a/z2+wzx/UnYeUdXSW9NdMBEdInLkOdZuEbR5DbmbuUkdv1a7eUQFALaIt/ffWTHPIoU
         2st6TcBbdVY+xGQSgKbNrZoJ2olqQ/Yj9kXYErVfOK/FguI3SSlYQGRY0MQAm5NQfzV9
         zkQdWlTUqbEaYPla0DYkfyb7G5iPoqVEVyYxLRvpFB/po2yE90nCv/8qTC/XlSylMb91
         8Y5BeXY8paVxJLc/deyj8LItH5OGFx9kg4Bs2SZ4IX2IYLRvgzWYTS6qZZcFfUjNGelp
         LtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=eLA/IWpi+XT2hI2jwn871YyFD0AJNa61ztcc7fUtCic=;
        b=PCdn7NqZj+ulaIa/pU3fqN8SX7kORUFZtBRl+c7IkMX89e3yR+QeYXOVuYveMklLVQ
         lMxgRlJdH0uWKoLmatgcNSvm1H3UJgRl+734mOS+6sbBNkogU6zo/yAjgwW8noxwrwIw
         lnwAz1qUyMa1IxzLHvgkNC2QbLmNwA03cquog3BF5BFwTce9J1fn1YTnFjPcJag8fkgV
         ywABvh8hpKIUCwQJnMWWgFTOorj0SIPVUCoNWk2TWwUHrWqP74Hjbv0+9q1h/n/rnoPH
         +xIsBTp35LuF1Nd0uWuBjujp7356YCfrOtLUJUxJVqbCCaY8JmyfCrnumba26DAf0o/O
         n4zA==
X-Gm-Message-State: AEkoousgQXmkVdjHafCm+r59vVvQTEmiTbMiFuPnFdmKNq4hjazOKSyAag+kkYlaO/SBMwe4VblUJQIOWKKo2w==
X-Received: by 10.157.19.85 with SMTP id q21mr11062583otq.139.1471192193579;
 Sun, 14 Aug 2016 09:29:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.245.203 with HTTP; Sun, 14 Aug 2016 09:29:33 -0700 (PDT)
In-Reply-To: <CAKkAvaxWk6SK4EYPaWXHQoVBh9qLgHoEqAh9+dgOrjncsi5QyA@mail.gmail.com>
References: <CAKkAvaxWk6SK4EYPaWXHQoVBh9qLgHoEqAh9+dgOrjncsi5QyA@mail.gmail.com>
From:	ryenus <ryenus@gmail.com>
Date:	Mon, 15 Aug 2016 00:29:33 +0800
Message-ID: <CAKkAvazV8umqbs+rTEG2399Ox0pGL1YAXsgLqHusb15RhzyH7Q@mail.gmail.com>
Subject: Re: [PATCH] make rebase respect core.hooksPath if set
To:	git@vger.kernel.org
Content-Type: multipart/mixed; boundary=001a1139216418e1b7053a0aa0f2
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

--001a1139216418e1b7053a0aa0f2
Content-Type: text/plain; charset=UTF-8

Patch attached.

It seems gmail ruined the white spaces.
Not sure how to stop gmail from doing that.
Sorry for me, and for Gmail.

--001a1139216418e1b7053a0aa0f2
Content-Type: application/octet-stream; 
	name="0001-make-rebase-respect-core.hooksPath-if-set.patch"
Content-Disposition: attachment; 
	filename="0001-make-rebase-respect-core.hooksPath-if-set.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_irutrnsg0

RnJvbSA2NzQxOGRkOGZmYWQ3YzA3ZWQ5NTQzN2Y3YTRkMTM1OWRhOWQ5M2QyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiByeWVudXMgPHJ5ZW51c0BnbWFpbC5jb20+CkRhdGU6IFN1biwg
MTQgQXVnIDIwMTYgMTk6MTY6MjcgKzA4MDAKU3ViamVjdDogW1BBVENIXSBtYWtlIHJlYmFzZSBy
ZXNwZWN0IGNvcmUuaG9va3NQYXRoIGlmIHNldAoKd2hlbiBsb29raW5nIGZvciBwcmUtcmViYXNl
IGFuZCBwb3N0LXJld3JpdGUgaG9va3MsIGdpdC1yZWJhc2UKb25seSBsb29rcyBmb3IgaG9va3Mg
ZGlyIHVzaW5nIGBnaXQgcmV2LXBhcnNlIC0tZ2l0LXBhdGggaG9va3NgLAp3aGljaCBkaWRuJ3Qg
Y29uc2lkZXIgdGhlIHBhdGggb3ZlcnJpZGRlbiBieSBjb3JlLmhvb2tzUGF0aC4KClNpZ25lZC1v
ZmYtYnk6IHJ5ZW51cyA8cnllbnVzQGdtYWlsLmNvbT4KLS0tCiBnaXQtcmViYXNlLS1pbnRlcmFj
dGl2ZS5zaCB8IDE0ICsrKysrKysrKy0tLS0tCiBnaXQtcmViYXNlLS1tZXJnZS5zaCAgICAgICB8
ICA0ICsrKy0KIGdpdC1yZWJhc2Uuc2ggICAgICAgICAgICAgIHwgIDcgKysrKystLQogMyBmaWxl
cyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2dpdC1yZWJhc2UtLWludGVyYWN0aXZlLnNoIGIvZ2l0LXJlYmFzZS0taW50ZXJhY3RpdmUuc2gK
aW5kZXggZTJkYTUyNC4uZThhZjcwZCAxMDA2NDQKLS0tIGEvZ2l0LXJlYmFzZS0taW50ZXJhY3Rp
dmUuc2gKKysrIGIvZ2l0LXJlYmFzZS0taW50ZXJhY3RpdmUuc2gKQEAgLTcyNCwxMSArNzI0LDE1
IEBAIENvbW1pdCBvciBzdGFzaCB5b3VyIGNoYW5nZXMsIGFuZCB0aGVuIHJ1bgogCQlnaXQgbm90
ZXMgY29weSAtLWZvci1yZXdyaXRlPXJlYmFzZSA8ICIkcmV3cml0dGVuX2xpc3QiIHx8CiAJCXRy
dWUgIyB3ZSBkb24ndCBjYXJlIGlmIHRoaXMgY29weWluZyBmYWlsZWQKIAl9ICYmCi0JaG9vaz0i
JChnaXQgcmV2LXBhcnNlIC0tZ2l0LXBhdGggaG9va3MvcG9zdC1yZXdyaXRlKSIKLQlpZiB0ZXN0
IC14ICIkaG9vayIgJiYgdGVzdCAtcyAiJHJld3JpdHRlbl9saXN0IjsgdGhlbgotCQkiJGhvb2si
IHJlYmFzZSA8ICIkcmV3cml0dGVuX2xpc3QiCi0JCXRydWUgIyB3ZSBkb24ndCBjYXJlIGlmIHRo
aXMgaG9vayBmYWlsZWQKLQlmaSAmJgorCXsKKwkJaG9va3NfcGF0aD0kKGdpdCBjb25maWcgLS1n
ZXQgY29yZS5ob29rc1BhdGgpCisJCWhvb2tzX3BhdGg9IiR7aG9va3NfcGF0aDotJChnaXQgcmV2
LXBhcnNlIC0tZ2l0LXBhdGggaG9va3MpfSIKKwkJaG9vaz0iJHtob29rc19wYXRofS9wb3N0LXJl
d3JpdGUiCisJCWlmIHRlc3QgLXggIiRob29rIiAmJiB0ZXN0IC1zICIkcmV3cml0dGVuX2xpc3Qi
OyB0aGVuCisJCQkiJGhvb2siIHJlYmFzZSA8ICIkcmV3cml0dGVuX2xpc3QiCisJCQl0cnVlICMg
d2UgZG9uJ3QgY2FyZSBpZiB0aGlzIGhvb2sgZmFpbGVkCisJCWZpCisJfSAmJgogCQl3YXJuICIk
KGV2YWxfZ2V0dGV4dCAiU3VjY2Vzc2Z1bGx5IHJlYmFzZWQgYW5kIHVwZGF0ZWQgXCRoZWFkX25h
bWUuIikiCiAKIAlyZXR1cm4gMSAjIG5vdCBmYWlsdXJlOyBqdXN0IHRvIGJyZWFrIHRoZSBkb19y
ZXN0IGxvb3AKZGlmZiAtLWdpdCBhL2dpdC1yZWJhc2UtLW1lcmdlLnNoIGIvZ2l0LXJlYmFzZS0t
bWVyZ2Uuc2gKaW5kZXggMDZhNDcyMy4uZGY1MDczZSAxMDA2NDQKLS0tIGEvZ2l0LXJlYmFzZS0t
bWVyZ2Uuc2gKKysrIGIvZ2l0LXJlYmFzZS0tbWVyZ2Uuc2gKQEAgLTk2LDcgKzk2LDkgQEAgZmlu
aXNoX3JiX21lcmdlICgpIHsKIAlpZiB0ZXN0IC1zICIkc3RhdGVfZGlyIi9yZXdyaXR0ZW4KIAl0
aGVuCiAJCWdpdCBub3RlcyBjb3B5IC0tZm9yLXJld3JpdGU9cmViYXNlIDwiJHN0YXRlX2RpciIv
cmV3cml0dGVuCi0JCWhvb2s9IiQoZ2l0IHJldi1wYXJzZSAtLWdpdC1wYXRoIGhvb2tzL3Bvc3Qt
cmV3cml0ZSkiCisJCWhvb2tzX3BhdGg9JChnaXQgY29uZmlnIC0tZ2V0IGNvcmUuaG9va3NQYXRo
KQorCQlob29rc19wYXRoPSIke2hvb2tzX3BhdGg6LSQoZ2l0IHJldi1wYXJzZSAtLWdpdC1wYXRo
IGhvb2tzKX0iCisJCWhvb2s9IiR7aG9va3NfcGF0aH0vcG9zdC1yZXdyaXRlIgogCQl0ZXN0IC14
ICIkaG9vayIgJiYgIiRob29rIiByZWJhc2UgPCIkc3RhdGVfZGlyIi9yZXdyaXR0ZW4KIAlmaQog
CXNheSBBbGwgZG9uZS4KZGlmZiAtLWdpdCBhL2dpdC1yZWJhc2Uuc2ggYi9naXQtcmViYXNlLnNo
CmluZGV4IDA0ZjZlNDQuLmM5YmE3NDcgMTAwNzU1Ci0tLSBhL2dpdC1yZWJhc2Uuc2gKKysrIGIv
Z2l0LXJlYmFzZS5zaApAQCAtMjAzLDEwICsyMDMsMTMgQEAgcnVuX3NwZWNpZmljX3JlYmFzZSAo
KSB7CiB9CiAKIHJ1bl9wcmVfcmViYXNlX2hvb2sgKCkgeworCWhvb2tzX3BhdGg9JChnaXQgY29u
ZmlnIC0tZ2V0IGNvcmUuaG9va3NQYXRoKQorCWhvb2tzX3BhdGg9IiR7aG9va3NfcGF0aDotJChn
aXQgcmV2LXBhcnNlIC0tZ2l0LXBhdGggaG9va3MpfSIKKwlob29rPSIke2hvb2tzX3BhdGh9L3By
ZS1yZWJhc2UiCiAJaWYgdGVzdCAteiAiJG9rX3RvX3NraXBfcHJlX3JlYmFzZSIgJiYKLQkgICB0
ZXN0IC14ICIkKGdpdCByZXYtcGFyc2UgLS1naXQtcGF0aCBob29rcy9wcmUtcmViYXNlKSIKKwkg
ICB0ZXN0IC14ICIkaG9vayIKIAl0aGVuCi0JCSIkKGdpdCByZXYtcGFyc2UgLS1naXQtcGF0aCBo
b29rcy9wcmUtcmViYXNlKSIgJHsxKyIkQCJ9IHx8CisJCSIkaG9vayIgJHsxKyIkQCJ9IHx8CiAJ
CWRpZSAiJChnZXR0ZXh0ICJUaGUgcHJlLXJlYmFzZSBob29rIHJlZnVzZWQgdG8gcmViYXNlLiIp
IgogCWZpCiB9Ci0tIAoyLjkuMwoK
--001a1139216418e1b7053a0aa0f2--
