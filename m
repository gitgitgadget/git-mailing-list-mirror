Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A567D1FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 16:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759928AbcINQ1f (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 12:27:35 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38693 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbcINQ1e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 12:27:34 -0400
Received: by mail-wm0-f54.google.com with SMTP id 1so41587078wmz.1
        for <git@vger.kernel.org>; Wed, 14 Sep 2016 09:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KajBOBeHbeY71MkntuZeCX1r0DkaijEV18pd3ejOFqA=;
        b=f/qd6WfWG1cDxiWlZopma/ZukCIqGyrPYZaqXHiBL9Pywf6+3HmUoXH1ZQWrws32Qr
         8QgLmYJcufhRu1d25T2cN/22VrmcHpmkck3ohgYbYuznXfCyyxXYHSQGBf9cGDYmUFgL
         2DyxK+7CyHlfZhKIN0x0Zad0wCpUPTOCCiPsY0d7+DUykN4dfAYF8e/RXfCjZp+OMakK
         xYdXEyms+cwVF+2O7s8BiI3rqrsxKBSwZFOPYzWzC9SzR85rgSV6Q41AmagwR7AwWK3u
         XxnusZrfxrwkwgXZ4KV9rVjBsFdmxpqMDCxuMBhxQShOgJ/gfU8hxJlHUOTNh80LAbAc
         i4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KajBOBeHbeY71MkntuZeCX1r0DkaijEV18pd3ejOFqA=;
        b=Sjj1W/SQ3atAe12T2Xg9gD6yt7z6xIV9FuQVqE/k/7voPMGb2G23+GGjyluJPYxl6F
         ixz6ebmejlgHtaYQuQJ02Q2d76yZgGPguq6xvib2UsvnJ6A9STgW9zBr1QAeHkHer+VF
         gRswo1+sK4ENL2zWk0sp7eA8N+TR45AkItKEWimHS4PFoVmZBaDsijm/AA50J+sua41e
         jHLya8QTbkqNOUnqDfV+4RWE7fNzAL3UQY4jyMJbcn9N1WTah/gNl3PKwqA4q6JtbiO9
         ecExe2VnHoVazWWpYp03cD/39nXyjsXHvY10DG5nvMlYUmC2RHhap/LCoXt3IlkqwbsI
         0eog==
X-Gm-Message-State: AE9vXwPPqT+oJW8mZKhT6QXhjqYM57cUVafKw08GF419fr8PdjtHPN/yMVRLVNqQXCA09duCHPaUomqgbfA70w==
X-Received: by 10.28.86.8 with SMTP id k8mr4099670wmb.33.1473870453320; Wed,
 14 Sep 2016 09:27:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.38.132 with HTTP; Wed, 14 Sep 2016 09:27:32 -0700 (PDT)
In-Reply-To: <1019E7FD-0AC0-4BCE-B810-BE20968DFEE9@gmail.com>
References: <E1bhKNo-0005m2-5z@mylo.jdl.com> <20160912004233.qh6uf35v5ylrboz6@sigill.intra.peff.net>
 <E1bjRLd-0005k0-Vb@mylo.jdl.com> <DB5PR07MB1448B5EDFE2E2D84C42A8AFCE2FF0@DB5PR07MB1448.eurprd07.prod.outlook.com>
 <E1bjVfp-0006sG-89@mylo.jdl.com> <xmqqeg4o27zw.fsf@gitster.mtv.corp.google.com>
 <1019E7FD-0AC0-4BCE-B810-BE20968DFEE9@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 14 Sep 2016 18:27:32 +0200
Message-ID: <CAP8UFD0M8MDs-0UAFgx288XVdWg_XP=bOwAWoXdY=5Sg7pMFsw@mail.gmail.com>
Subject: Re: Git Miniconference at Plumbers
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jon Loeliger <jdl@jdl.com>,
        David Bainbridge <david.bainbridge@ericsson.com>,
        Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 13, 2016 at 1:14 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 12 Sep 2016, at 21:11, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> [..]
>> properly; supporting "huge objects" better in the object layer,
>> without having to resort to ugly hacks like GitLFS that will never
>> be part of the core Git. [...]
>
> I agree with you that GitLFS is an ugly hack.
>
> Some applications have test data, image assets, and other data sets that
> need to be versioned along with the source code.
>
> How would you deal with these kind of "huge objects" _today_?

I think that Junio was saying that this problem and other problems
like this one are indeed itches for some people, but maybe not for
kernel community.

About this specific problem, as you probably know, I started working
on adding support for external object databases, on top of some
previous work that Peff had started some years ago:

https://public-inbox.org/git/20160628181933.24620-1-chriscool@tuxfamily.org/

So if you want to better deal with huge objects in the near future,
you are welcome to help on this.
