Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 772352021E
	for <e@80x24.org>; Fri, 11 Nov 2016 08:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755882AbcKKIW4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 03:22:56 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35277 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753660AbcKKIWz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 03:22:55 -0500
Received: by mail-wm0-f66.google.com with SMTP id a20so7782667wme.2
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 00:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Q9E671DpI+XJ4/I2JCppW4iLo6aFVHgcM16DZ3WXP0M=;
        b=b94Fl/bMa0GrULdT7f7iLk4mhSzGJrYpHj8/tf03LF4w4AdhQ123R1HoQLSfQTzCYu
         m1/M7sWjnMMyk5wXnsVPAG2i1CHQiQFB8h5mN9b3Lhe+xgroXqETGkhxomJAdRzxqnU6
         eGTyOsGcDUVhHA6AwOl0dbUru6IHrCJz4bTcUpaMGG8v21IwkSRpuGfd5UytkGudYMR+
         6iTzA+9ZFTNsPv5ty0C8JgBilZLJ3Ci8jM09ERRmHfgl7SIIebkZNXmt4NAQ1RFmSHU4
         pVXNBlWlFtRPCnWMX0+xpxtNVj0xePVBhieyyYYNv4lETlZztIdHzHJMV4WzylzIIRmU
         yivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Q9E671DpI+XJ4/I2JCppW4iLo6aFVHgcM16DZ3WXP0M=;
        b=EWxhEjw4zYUuh0xbFnCWyWOv8z9XT62W+HEsqq1Umul48pT6I1Bfumw5yeiJvPaANs
         WHwgm8L8eN2Hm91g+v3wu7MvQLcQP2YjxEiwm8wgPAhxd8GHxkq9FPbhAOJHd+PfP8Od
         wGN/7/Wxire/e3bQpMIO87WeHKuaV80FFSc1fZXUWB8T9NfdlvmMtmrT+f9E/rARlgP0
         bidDvhHjUEEzh1Elds/L+r/RH8abU4Ud1zsu2eaEcw4n0L8zS2flqaWHZKrNBFwQ+Org
         lfgtXOQHMF29sP/BTbgz8WRQHflTnNldMWwh5Ttge9Q3RNprf5e7lE35b9PlfWLKjdY0
         FIbg==
X-Gm-Message-State: ABUngveRKjTFIcUK3dyDlUb1FeIH4GptSrJy3dPavhxS9764T1yiyu8DoKhcu1A6JunMVw==
X-Received: by 10.28.217.131 with SMTP id q125mr10872732wmg.95.1478852573610;
        Fri, 11 Nov 2016 00:22:53 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB4736.dip0.t-ipconnect.de. [93.219.71.54])
        by smtp.gmail.com with ESMTPSA id m9sm9786237wma.0.2016.11.11.00.22.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Nov 2016 00:22:52 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v1 2/2] travis-ci: disable GIT_TEST_HTTPD for macOS
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20161110161012.jube4bwbww2wa2ew@sigill.intra.peff.net>
Date:   Fri, 11 Nov 2016 09:22:51 +0100
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>, hvoigt@hvoigt.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <2088B631-4FE8-4232-9F3C-699122E6A7B0@gmail.com>
References: <20161017002550.88782-1-larsxschneider@gmail.com> <20161017002550.88782-3-larsxschneider@gmail.com> <203BDCB2-1975-4590-B4B8-3C5E9D210430@gmail.com> <20161107212004.x4y7bcl2p4chfkm6@sigill.intra.peff.net> <CBAF806C-7E1E-4490-A07C-F98DB7488F5F@gmail.com> <20161110161012.jube4bwbww2wa2ew@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 10 Nov 2016, at 17:10, Jeff King <peff@peff.net> wrote:

> On Thu, Nov 10, 2016 at 12:07:14PM +0100, Lars Schneider wrote:
>=20
>>> Using Apache in the tests has been the source of frequent =
portability
>>> problems and configuration headaches. I do wonder if we'd be better =
off
>>> using some small special-purpose web server (even a short perl =
script
>>> written around HTTP::Server::Simple or something).
>>>=20
>>> On the other hand, testing against Apache approximates a more =
real-world
>>> case, which has value. It might be nice if our tests supported =
multiple
>>> web servers, but that would mean duplicating the config for each
>>> manually.
>>=20
>> I agree that the real-world Apache test is more valuable and I really =
want
>> to keep the Linux Apache test running. However, I don't think many =
people
>> use macOS as Git web server and therefore I thought it is not worth =
the
>> effort to investigate this problem further.
>=20
> IMHO, the value in the http tests is not testing the server side, but
> the client side. Without being able to set up a dummy HTTP server, we =
do
> not have any way to exercise the client side of git-over-http at all.
> And people on macOS _do_ use that. :)

Well, I haven't seen it from that perspective, yet, but I agree :-)


To all macOS users on the list:
Does anyone execute the tests with GIT_TEST_HTTPD enabled successfully?


There would be an alternative way to approach the problem:
Someone (GitHub?, BitBucket?, GitLab?, ...) could setup a bunch of =
webservers
with popular configurations and a way to reset a clean test environment. =
Then=20
the TravisCI client tests could go against these servers.

I realize that this idea is probably unrealistic because too much setup =
and
maintenance work would be required.

Cheers,
Lars=
