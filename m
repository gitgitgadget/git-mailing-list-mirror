Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB05720248
	for <e@80x24.org>; Sat,  9 Mar 2019 13:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfCINMc (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 08:12:32 -0500
Received: from mail-it1-f170.google.com ([209.85.166.170]:55544 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbfCINMc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 08:12:32 -0500
Received: by mail-it1-f170.google.com with SMTP id z131so501332itf.5
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 05:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=EJsIKy9WcAR61D97aWNI0JSmSD0CGeSRxwpei4pgGw8=;
        b=RzJ4P2tptPVc9L8MtFeziNAHeqEUbJ5OM8U36jiMsJX3Orr1r6SdYyz+vbyc3TVj9w
         pkR1YvVbbonPpCUs8G4GL1LN7fWBIUX1NkVBq/xCF5GeJu0JoMKXzC+GNr7AdILDnAsG
         0v1H2q5LDziG8rHMKfR8yuzHo1EFOtrTXrMVpLacfCFG6HhVcGoPz74yB291PSQLPEXO
         qGSYZQQEwK+2eRGnNLEne28buYVQsu5twc6rV9nS8Lt2hoykpxXrJSEMQuf7bhEzbKkF
         G71dl+jwBdYpdewv4m2Dkgu5u4HmxHzn1Q5dqr23aDh8Hu4S4685eI4WTrC1sdnw9SfY
         /v2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=EJsIKy9WcAR61D97aWNI0JSmSD0CGeSRxwpei4pgGw8=;
        b=Gv1PyzNgKlGi8dMEkjC8J97Kf0wlESyzzGsy3qWsfsom6VL8b9XT3MuoNxnFfKffhQ
         d9c9IH03Xk1Wsu0qwRZbjciE0BpDc55GfDjCTBKxMCDF4Pb2AVYWS/lByFODqhpXwPCT
         TVwAKzdqx3i+N1MqzsOq774aFsFICZUaZbzyo/RhqDJDfOhcQ0lMhD7oPljSsVowcTtm
         dVEImwb16OgqIo7EacofhQohNvRgW/R/AsDXqcvN7JvHU6ymF8levnUPwYCn3+UBX0ku
         4OxGvzJngaT4+tnT9y6LKO+E5aU7IZuuRurtEPXMLauIBtraj6yFeS0gyrniuFbYefua
         mCgA==
X-Gm-Message-State: APjAAAUwZjqafBuu6GaHnm/AWO3Sj3jPDVXXak+bV+Yk83pkMgLDDmiw
        iUQsq96lLIY05BlDmKlalEj0hMygFoWVtUDXAxoqoMz4
X-Google-Smtp-Source: APXvYqwoxHnHJv0JC+zgRqPfGxkVVTv4u+9eO+4b8mwKie9aWkPTcan5karz1bGYsJsgLeh+XDaNyQQ1sWbd19a0O/s=
X-Received: by 2002:a24:3a12:: with SMTP id m18mr10251006itm.5.1552137151049;
 Sat, 09 Mar 2019 05:12:31 -0800 (PST)
MIME-Version: 1.0
References: <CAH8yC8k_Zyi89uxTWTrjN65UAAc1L+jLho+P7O7UyvE-LvZuzA@mail.gmail.com>
 <20190308174343.GX31362@zaya.teonanacatl.net> <CAH8yC8mg3vjPoof5SDemQ_YiL+7e1ak535U2nFnPbaWJ8xSWOA@mail.gmail.com>
In-Reply-To: <CAH8yC8mg3vjPoof5SDemQ_YiL+7e1ak535U2nFnPbaWJ8xSWOA@mail.gmail.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sat, 9 Mar 2019 08:12:05 -0500
Message-ID: <CAH8yC8kn=EmEm_UPrnpwaofv97S42Se6FC+hWcm0EHCX-4rewQ@mail.gmail.com>
Subject: Re: One failed self test on Fedora 29
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000008818c90583a91783"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--0000000000008818c90583a91783
Content-Type: text/plain; charset="UTF-8"

On Sat, Mar 9, 2019 at 7:34 AM Jeffrey Walton <noloader@gmail.com> wrote:
>
> On Fri, Mar 8, 2019 at 12:43 PM Todd Zullinger <tmz@pobox.com> wrote:
> >
> > Jeffrey Walton wrote:
> > > Fedora 29, x86_64. One failed self test:
> > >
> > > *** t0021-conversion.sh ***
> > [...]
> > > not ok 13 - disable filter with empty override
> > > #
> > > #               test_config_global filter.disable.smudge false &&
> > > #               test_config_global filter.disable.clean false &&
> > > #               test_config filter.disable.smudge false &&
> > > #               test_config filter.disable.clean false &&
> > > #
> > > #               echo "*.disable filter=disable" >.gitattributes &&
> > > #
> > > #               echo test >test.disable &&
> > > #               git -c filter.disable.clean= add test.disable 2>err &&
> > > #               test_must_be_empty err &&
> > > #               rm -f test.disable &&
> > > #               git -c filter.disable.smudge= checkout -- test.disable 2>err &&
> > > #               test_must_be_empty err
> > > #
> > [...]
> > > # failed 1 among 26 test(s)
> > > 1..26
> > > gmake[2]: *** [Makefile:56: t0021-conversion.sh] Error 1
> > >
> > > Does anyone need a config.log or other test data?
> >
> > It would probably help to know what commit you're building.
> > The verbose test output would also be useful, e.g.:
>
> I built with CFLAGS += -fsanitize=undefined. It looks like the
> misaligned accesses generate UBsan findings, which is causing
> t0021-conversion to fail.
>
> git-2.21.0$ grep -IR 'runtime error'
> t/trash directory.t0021-conversion/err:sha1dc/sha1.c:392:2: runtime
> error: load of misaligned address 0x0000024fc245 for type 'const
> uint32_t', which requires 4 byte alignment
> t/trash directory.t0021-conversion/err:sha1dc/sha1.c:397:2: runtime
> error: load of misaligned address 0x0000024fc245 for type 'const
> uint32_t', which requires 4 byte alignment
> t/trash directory.t0021-conversion/err:sha1dc/sha1.c:402:2: runtime
> error: load of misaligned address 0x0000024fc245 for type 'const
> uint32_t', which requires 4 byte alignment

I think this is the patch for sha1dc/sha1.c . It stops using unaligned
accesses by default, but still honors SHA1DC_FORCE_UNALIGNED_ACCESS
for those who want it. Folks who want the undefined behavior have to
do something special.

Jeff

--0000000000008818c90583a91783
Content-Type: application/octet-stream; name="git.patch"
Content-Disposition: attachment; filename="git.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jt1id9do0>
X-Attachment-Id: f_jt1id9do0

LS0tIHNoYTFkYy9zaGExLmMKKysrIHNoYTFkYy9zaGExLmMKQEAgLTI2LDE0ICsyNiw2IEBACiAj
aW5jbHVkZSAic2hhMS5oIgogI2luY2x1ZGUgInViY19jaGVjay5oIgogCi0jaWYgKGRlZmluZWQo
X19hbWQ2NF9fKSB8fCBkZWZpbmVkKF9fYW1kNjQpIHx8IGRlZmluZWQoX194ODZfNjRfXykgfHwg
ZGVmaW5lZChfX3g4Nl82NCkgfHwgXAotICAgICBkZWZpbmVkKGkzODYpIHx8IGRlZmluZWQoX19p
Mzg2KSB8fCBkZWZpbmVkKF9faTM4Nl9fKSB8fCBkZWZpbmVkKF9faTQ4Nl9fKSAgfHwgXAotICAg
ICBkZWZpbmVkKF9faTU4Nl9fKSB8fCBkZWZpbmVkKF9faTY4Nl9fKSB8fCBkZWZpbmVkKF9NX0lY
ODYpIHx8IGRlZmluZWQoX19YODZfXykgfHwgXAotICAgICBkZWZpbmVkKF9YODZfKSB8fCBkZWZp
bmVkKF9fVEhXX0lOVEVMX18pIHx8IGRlZmluZWQoX19JODZfXykgfHwgZGVmaW5lZChfX0lOVEVM
X18pIHx8IFwKLSAgICAgZGVmaW5lZChfXzM4NikgfHwgZGVmaW5lZChfTV9YNjQpIHx8IGRlZmlu
ZWQoX01fQU1ENjQpKQotI2RlZmluZSBTSEExRENfT05fSU5URUxfTElLRV9QUk9DRVNTT1IKLSNl
bmRpZgotCiAvKgogICAgQmVjYXVzZSBMaXR0bGUtRW5kaWFuIGFyY2hpdGVjdHVyZXMgYXJlIG1v
c3QgY29tbW9uLAogICAgd2Ugb25seSBzZXQgU0hBMURDX0JJR0VORElBTiBpZiBvbmUgb2YgdGhl
c2UgY29uZGl0aW9ucyBpcyBtZXQuCkBAIC0xMjQsNyArMTE2LDcgQEAKICNlbmRpZgogLypFTkRJ
QU5ORVNTIFNFTEVDVElPTiovCiAKLSNpZiBkZWZpbmVkKFNIQTFEQ19GT1JDRV9VTkFMSUdORURf
QUNDRVNTKSB8fCBkZWZpbmVkKFNIQTFEQ19PTl9JTlRFTF9MSUtFX1BST0NFU1NPUikKKyNpZiBk
ZWZpbmVkKFNIQTFEQ19GT1JDRV9VTkFMSUdORURfQUNDRVNTKQogI2RlZmluZSBTSEExRENfQUxM
T1dfVU5BTElHTkVEX0FDQ0VTUwogI2VuZGlmIC8qVU5BTElHTk1FTlQgREVURUNUSU9OKi8K
--0000000000008818c90583a91783--
