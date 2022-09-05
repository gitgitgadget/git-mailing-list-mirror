Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9078FC6FA83
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 10:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbiIEKW3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 06:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbiIEKWI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 06:22:08 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACEDC6F
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 03:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662373278;
        bh=MxgzR60GwKIZv4tAg3FnpSCOhrovjfwG7FRFA+D8eNM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Yb94YKtx9Mj8fEzpYkQc9Z9XwePcB1n1Xlt2wOCxyEpFZTo0SCdh/AzPR3IO+lRkZ
         aDAuW3x1gfNHhKPWr4lc+Vp5/FCefJLotYHlsibZYXdhn11c7H/h2g84KBiwNExz/K
         rxIjLpCdclDHa808vToACpx00jUnBqjRSMkkJJ28=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N17Ye-1pXJbj3Zxi-012aSY; Mon, 05
 Sep 2022 12:21:17 +0200
Date:   Mon, 5 Sep 2022 12:21:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
cc:     git@vger.kernel.org
Subject: Re: status on security of embedded repos?
In-Reply-To: <4e9ad5486e8a887f1e92cc4e401ca61be5f2bb9a.camel@scientia.org>
Message-ID: <6sq30r84-1s65-91n4-5qoq-23s9q433sno1@tzk.qr>
References: <4e9ad5486e8a887f1e92cc4e401ca61be5f2bb9a.camel@scientia.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-417331040-1662373279=:189"
X-Provags-ID: V03:K1:NZW/75zq9lsVm0awlSTYLIXWlGjw2BQrUeJVVzK6z6DM2QmmQDU
 njw89hYbQGGQJDEdCwyFceyl2apzvhRnXkX1bi7kG3wYeTPk7ADgsht6ReMIZXShPFIs9JX
 8AxnRGGS4WAJtL4TC/I5eNiY+1E8EsBOtnW9SXaI5/MuEZmaFLV3Y/SceGCG6+UgGlQCKzg
 FbcGYYcj7APRLrwNUtM+A==
X-UI-Out-Filterresults: junk:10;V03:K0:WY/PwrGYtaE=:hWsdEEn3cYwnVe4gQosqYzoS
 zDKaJ/bga3Ejc6xwlUbol89VLg6mKuy8GALjwidvgIiVmbRUr87kK6PZ4DHaUGVAT9JWSSgvr
 rUHrusMnnE1vFYQ+iGovlp/dR+ymoi+cuRfMALhT+5PsJ46HnKBBINIuzwz0TwJokWMTqIiDc
 6Y7FMdWgb5aPfgKnyumeWWtFtfyXbNhawoh/GnUBE9jKHDuWrhCtk0pMlCQzjAMEPBplNcAJG
 aDHTxbkI7TyOjYa5lAijDEHABJEQQAGt8Qjn3r1RZ7Agrvn0x71Ef6uNYuJ7b7jRBGsoP2PsQ
 /z/UXl4yP6mQnT7jWYI3NNQHqWZ+qq1GLnxunkfu4pwHPlVFQOTrfagVGRw1R+Kf5VfXU0iPF
 ZU60VZbaeB5GnKYCrc6qVYG1ZxtoxMMxMXlq4jZlFlFEndnaEREggQu/aGFBEUfyjn2MWeJah
 f5KaVsqIQZsHD73NuI1s4+gEZpSIEL1m1bNhhsvnTyGWTwY180SUgr1NkAYGhMwwNPZWhpL+C
 UCsDjVkgtug9zn7XbEm0F3rYLXiepiKD1MESsY3qDMSS8J53KOsqRi+HCB3CpZdPRozkPsv++
 fu+aKW54BEvuMrs7DuwaW2ymtJzzHCax/xpeY/A8NYBjH+xdgv978MwbxrWxgOCEKOrlJWspN
 W6+Rhdfx2oR3DEugxP00CvkUuh4HZj3lT1dTHQKKSCBClqhgjo4Gws1DWOaFzfUl2qeobd3j3
 M6fELWarsHlj1wvcqemr48w2XGfIbcB/7BJVhf2KogR4IN6pTDzb7UboF+gYZ1PJKxFnAyo1A
 hh3j9wszkSMp2+qtbRTKIG5RHlAk3FFTmyQlXbaioJ+t8K6Pif65lFCYkIGHmHCUrKhgVzO/1
 exg96bnsmdUUE2XvIHvcDQ5o4FNi5UHZoGPOZRXpOi1AIwWgXO+4fXPfUY9B3WwGgxBxHRIwf
 ysIAKhBn0XR/ba/VskB1eWeZI1giDLHAvftKr2Lvf3yMSOofKihR4MthJxivNW7NWvcWVPeuG
 CgU/N650TdoZJF6g0jhuZb322HwL5b0itPgBwJU+U18m6Q71hQQ6duXcIy9zxOmGRag9aI/sb
 MYigIigWBUUpb1os48KCAfMEqDKB7WHpQZXlZXNAFlnmWFIhBYbnVC5RBn11WjrBtrd65OzyU
 WyyN9ihDlB1lz8RDZB1KBgdqqfscj6nRRxSHfLy7Fhj474jBcsvzyQI2yO+mONZpSZfBmcW6i
 3XYiz8XjOhueUr47JJh/H/9W5U1hSfxlIUxNTbwcRXIRR0p7WD4odYG940yCbQ7gNFBABa4kH
 A/5wkD
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-417331040-1662373279=:189
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Sat, 3 Sep 2022, Christoph Anton Mitterer wrote:

> A while ago there was this discussion about security issues with
> respect to bare repos embedded in another repo[0][1].
>
>
> I just wondered what's the status on this? Was that fixed in a way that
> one can clone untrusted repos and navigate / use git commands within
> them, without any risk=E2=80=A6 or is it still open?
>
> Saw proposed patches like:
> https://lore.kernel.org/git/pull.1261.git.git.1651861810633.gitgitgadget=
@gmail.com/#r

As you can see at the corresponding Pull Request, the patch series has
been accepted:
https://github.com/git/git/pull/1261#issuecomment-1193004345

If you follow the link to the commit
(https://github.com/git/git/commit/18bbc795fc52), you will see that it is
not yet in any official tagged version (otherwise you would see the list
of tags below the branch name).

This means that it will be part of the next release.

The current timeline for that release can be seen at
https://tinyurl.com/gitcal, the projected date for Git v2.38.0 is October
3rd, 2022.

Note: The default will still be at `safe.bareRepository =3D all`. I forese=
e
myself setting this to `explicit` via my user-wide configuration.
Potentially a future Git version will add deprecation warnings and an even
more distant Git version might switch the default. This is still up for
discussion, I believe.

Ciao,
Johannes

--8323328-417331040-1662373279=:189--
