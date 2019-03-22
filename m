Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7873520248
	for <e@80x24.org>; Fri, 22 Mar 2019 17:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfCVRnC (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 13:43:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:51055 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfCVRnC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 13:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553276569;
        bh=xuQQnuWeY5klk4m3PtBTx5qGAut5jtXnwbQ0rV+1CBk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gDSoYWn5IJVD5A6c1tk73yU0nsNiph9qhHOSOg9B8tkZKqy9wPWlrE+qf/M1fm9hH
         5qzua0c4+LCP4K2swL4E/e6kle/IVmEyqiAtQ8hPnbGAxiwqDj3Bg5LlFmjqmYzoPl
         FG81PGCvRmpVQrLwRuXYDIW1n5Kap8sfHGYOYDTM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.67] ([84.118.159.3]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LejNC-1geNdP1gPG-00qVbP; Fri, 22
 Mar 2019 18:42:49 +0100
Subject: Re: [BUG] Cloning with git HEAD fails for some repositories
To:     Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>
Cc:     Wolfgang Denk <wd@denx.de>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Takahiro Akashi <takahiro.akashi@linaro.org>
References: <7e4a2f1d-2b3a-eb83-d3f1-9ac63d68991b@gmx.de>
 <20190322005107.GL9937@linaro.org>
 <017964a9-bd75-5e36-0de7-57d4467d6a7e@gmx.de>
 <20190322071231.GA26114@sigill.intra.peff.net>
 <20190322082114.BC19924013C@gemini.denx.de>
 <20190322093132.GA17498@sigill.intra.peff.net> <20190322165034.GA23124@dcvr>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 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 Eg==
Message-ID: <3d8e8de3-9ae6-94be-7739-cb8ea79b228e@gmx.de>
Date:   Fri, 22 Mar 2019 18:42:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322165034.GA23124@dcvr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:24LwUAxg7aaeeqovHNu35INLzDkyJRPQTlj83crwhKu1e4cKHYt
 GGY48XNvxIWW+GwdgB6pwfw7EDeP1LH6LCjg46NXuVb+utqzdNucmFv3KamcX1WzHHaJO45
 bTVw8Lhq1UfMIy+ZzqwVIj0hMZbx01nmGHogjoYttsDEKr2Zp8SxrPhaXGaOOQvpFZ9OjAU
 sUZJMhrvbY0n8QjqVNVZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Td0rKCIMBAA=:8oL+tIMAtC8liZFdM87a/6
 U9wpp21l2v15EN06lVZzLV3yfGzID1iiQn1c/IqHNv2X9r5ehg5B+CgoZAFt3HOAcADkJT4ZW
 Zw8GcXjQFB39w46JNEJzTwHe/8Yz0teGug6fBxS+tUz7j0+U5zeG9tLpvAvcbqY+l3mA+yi7p
 eOQJ6M5s/KxStgVtvKBFpZXfjD7AKX5QRc8jpFqR4CROyJ7/bviSj9AY4BSv/GH0Z6iF5rTK4
 gGmi2SPdA0udJlGVoS7SIP8G2QbikoyQzKJfyzABsgZ69/BhLBarJx/z0xwthVV1xYWMZDHBq
 61Q//QO+WVRnopoJz0fENMBKupROEF3ZZjhatAlKlj1O1OYtKemrV9mxAU17ofzW8g3NCdalR
 DOy93FzoFEoCsuRabbDaf5yGnb9zHn83AuKAcE/26/VC1FhYR2GmNv9jqNrdHkOMau58lyGLa
 aYtE0K9fQoZGTQNOz1cSIa1SWLo+eLAUcdWx4erkKui6JfL0/UlWiMT71YZwO9w52HUPU8+g2
 kZXuB764W1vP5qjmAsMc/YQ+FOT6xvrwQAog+9fayx5wFvSLfeeiqehP7ADK+gtm1zRszJ/SS
 PvHqfOYK73uswNy4NwIHOcKSGa3QhIoo2j+iaV85eHs/FPtullkbvxS8RBSLAfZTR48Ed1Jay
 dB6DeBqfolv7XXaKPZddDJ4ycEKZhRxaXD2POfejkEcAfYk3J2uTn9xn/UAi0GUGCgtpZeWXc
 eXxXQz+MDcBTO5njhjktuwKzPNv5kdqE0vJ634I8TURMBRHJjhY7rrwakVbnW99wuyW0RmUEV
 SmwWcrXSJVBq0nyrpwn6yLzpjee8cnpRXenb9POGuUR7Za2OwYc8jBTX27UsByH2eO7N9MSeU
 9c6ni5P6Ke1M5u5lffAARv3NHil//ilh+IrRPq0gFkLvhMUpudbRQu1aQSRO9c3T0fLCGyKdG
 DDI9ub18CmQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/22/19 5:50 PM, Eric Wong wrote:
> Jeff King <peff@peff.net> wrote:
>> On Fri, Mar 22, 2019 at 09:21:14AM +0100, Wolfgang Denk wrote:
>>
>>> Dear Jeff,
>>>
>>> In message <20190322071231.GA26114@sigill.intra.peff.net> you wrote:
>>>>
>>>> However, so does the parent of 17966c0a63d. So I don't know if the
>>>> u-boot-efi repo is just broken, or if there's some other different bu=
g
>>>> at play.
>>>
>>> git fsck reports a number of dangling tags, but no other issues:
>>
>> Weird. I had set http.maxrequests to "1" to give more readable output
>> from GIT_CURL_VERBOSE, etc. It fails with that setting, but not with th=
e
>> default of 5. Which certainly seems like a bug, but one that has been
>> there for a while (at least since v2.9.x, which I tested).
>
> I couldn't reproduce an error after porting your patch to
> master (commit 041f5ea1cf987a40 "The third batch"):
> https://80x24.org/spew/20190322163449.25362-1-e@80x24.org/raw
>
> So you might've hit an ephemeral error (bad connection,
> HTTP server restarting, etc).
>
> GIT_CURL_VERBOSE=3D1 git \
> 	-c http.maxRequests=3D1 -c http.followRedirects=3Dtrue clone \
> 	http://git.denx.de/u-boot-efi.git
>

I applied the patch to https://github.com/git/git origin/HEAD.

But unfortunately it does not solve the issue:

$ git --version
git version 2.21.0.197.g3845f293e6
$ git clone http://git.denx.de/u-boot-efi.git
Cloning into 'u-boot-efi'...
warning: alternate disabled by http.followRedirects:
http://git.denx.de/u-boot.git/
error: Unable to find a00d15757d7a513e410f15f2f910cb52333361a3 under
http://git.denx.de/u-boot-efi.git
Cannot obtain needed object a00d15757d7a513e410f15f2f910cb52333361a3
error: fetch failed.

In Wireshark I see a lot of '404 Not found' codes.

Best regards

Heinrich
