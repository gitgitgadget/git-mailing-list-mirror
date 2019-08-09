Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7408B1F731
	for <e@80x24.org>; Fri,  9 Aug 2019 03:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404787AbfHIDeN (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 23:34:13 -0400
Received: from mout.web.de ([212.227.15.3]:60845 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727611AbfHIDeN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 23:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565321647;
        bh=XskiSfKAg86hZL8WHfYbdtOpKtGWUKRS6u5IQ206gqQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=DDrtTLknWj9G4HRFiqSqYiH2gObtRCnNMb8ntgtGy+EWWIfLRHplUzzOORqx5lDGO
         U0WlZfewGDQokpKaK17MfJbiS+e84pJ1RXvnwEzG++txph8Y+5jTXLdd1lqU+1p1LA
         g2fwZCPyYBxvqRLn4HYxm35pOHVV+aGmSagl1mC0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKr7w-1hvvfL2Aam-0000Jc; Fri, 09
 Aug 2019 05:34:07 +0200
Date:   Fri, 9 Aug 2019 05:34:06 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     "Yagnatinsky, Mark" <mark.yagnatinsky@bofa.com>
Cc:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: Re: suggestion for improved docs on autocrlf
Message-ID: <20190809033406.5t5ag3qmh36ideec@tb-raspi4>
References: <9c79d35e48df4d28baf995ad3f5b0153@bofa.com>
 <20190808205631.e2647kxq74thotjb@tb-raspi4>
 <3269668c03a8482d8d854ec19dd43907@bofa.com>
 <577a66e0c26545aaa4795de3c5189c9d@bofa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <577a66e0c26545aaa4795de3c5189c9d@bofa.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:mjeH0EISjciAJEe22HPVe9voloPXXlB5XMiXvvaqRRc1KVSDKcL
 7Zd2oiXmZ56bfBkkmFtp6OhryTDEnbdRiunH+3fbFcFvYTPYmmxL0fk3rvmSQmqKF2xFr/p
 iEM3w0d7Vn06TyAKlBYtXl2DhPYIIBxDDX3e0oTf3dFwwUB58aR6sDC6rDPW+f17AGsRLJw
 MlqlcWpots+bxmCX3/4Cw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pYSi+Io2zZA=:7/yTGEAmUCpSjFrDN4pkDK
 /JXLrhABNXkfVN8Hg/GRj5DyCRgcFaH0OQWsIWt2Wzp5ifDe9hMtNWDPC5snmWrgtOChg4gCI
 MjBndsJbwny+A7Yw/Q1spSdIkNVwjn6l/eJJR1Ugv2qEcnt2dMtbmK/q+3DjXzZPgLScEPlC7
 /eF0LkHSQIQhlYwVPl3QLCqPj8GRueIhUvjAbYzTR2dFYOvWeLtc5JpTjkEYpGFRDkv71dZhS
 ju7z4pUlomOzf3UWOaikKkS0ecJfKPKd0xLTwdBUzLm/FWNHKzevmgKIJYLBxLh4AAjZWPskU
 5aq7CZSHXDC7dSjUdrFOflyLqMgTUo03dr6nWhFLoO3BBV2E6AhBqEimrcHlrn70urEylk0Ce
 iTs0HqbUytxC0AmHTTkE3x7yY0ZSiXg9T6/Sz9lpv1V7DRhbm8Iez1xu8Bm8Q8tZ1/acxfrvG
 XWriiGqO5MHcveATO510PGHfiHG7+Bhtz6gkpNPiBQ1MJlZS+dADF7vfLIow710cPlYU7TeL9
 2ib7WVDazEKEVgNijyBXQop4aXUuuct1epYNjx8Dm3TuiHLAxv1Kq1rqPuCJBf/HcOrki8Uh8
 IvwN1LLER5B6nUDsEew47op6nxPiL44+npTt5xs9ELeZoZ69SrU2qu+t7dBtcyzfElnP8Ncx/
 F6qA9GfoxemN4AzlX8DTcfOukiP5GqiF9/fdLcoEDTH3NFQgBrJ1zBNXxqbDn7gQhXuI5UgHw
 R8SQnVwn83HwY/2AzNwDBBbQiSygIqzWNBP1OwjXHtYgewKdaHzPtf3CjKKCtugRUdfSA1rHP
 PHHfBZ5MuruiJOMDEne2ggB8C9kms6cK4+rEp9L0gAH09MnA1K0IL0IrhyTykD/zWEvDOMcVj
 kaXGUiZQ20pSetWl8Uu/ncz12bRifba+Uwol5Wkb1MBHwwc7M0CAwLi8+THbZ+59saRFAchdM
 F/D7k4YtmpjZVyO7U4FX47/GSsTTYkiEUJJRVZpF4DpJ5Wh6HkSFQ/+f1VT5hkM4S+3GLcSor
 x6PreC38O53f31rKjPLvbVv58KgOn+5uCRwldvu5kyyJt43yJkJwyrBzv1xpwPyHbwNmn290w
 6Jk/SJscMchf4G2hqLq0QP8FOUgt7yCH8wv3Q+2omaLXvh6fKAQEXZ6Ow==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 08, 2019 at 11:08:14PM +0000, Yagnatinsky, Mark wrote:
> Okay, my attempt at better wording for the docs is not going well, becau=
se it turns I that I still don't understand the behavior here!
> I thought that "input" means that CRLF will become LF on "git add" but t=
hat seems to be true only sometimes.
> For instance, consider the following 11-line shell script:
>
> mkdir empty
> cd empty
> git init
> git config core.autocrlf false
> echo -e '1\r\n2' > test.txt
> git add .
> git commit -m test
> git config core.autocrlf input
> cp test.txt t2.txt
> echo 'a\r\nb' > test.txt
> git add .
>
> The output from the last git add is:
>
> warning: CRLF will be replaced by LF in t2.txt.
> The file will have its original line endings in your working directory.
>
> Which is a very good warning indeed, but why does it only apply to the n=
ew file t2.txt?
> Why does the existing file test.txt retain its CRLF line endings.
Because there are no CRLF ;-)

This line
echo 'a\r\nb' > test.txt
should probably be written as
echo -e 'a\r\nb' > test.txt
or better
printf 'a\r\nb' > test.txt

> I am so confused.
Please run

od -c test.txt
and may be
git ls-files --eol

>
> Any pointers?

https://git-scm.com/docs/git-add

What happens if you run the following:
mkdir empty
cd empty
git init
echo "* -text" >.gitattributes
printf '1\r\n2' > test.txt
git add .
git commit -m "Add test.txt with CRLF"

echo "* text=3Dauto eol=3Dlf" >.gitattributes
cp test.txt t2.txt
printf 'a\r\nb' > test.txt
git add .

git commit -m "cp text.txt t2.txt; change test.txt; eol=3Dinput"

git add --renormailze test.txt
git commit -m "Normalize line endings in text.txt"



