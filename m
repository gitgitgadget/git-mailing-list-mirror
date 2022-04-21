Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC95C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 17:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390999AbiDUR4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 13:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiDUR4H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 13:56:07 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E46C4A923
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 10:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1650563575;
        bh=mXrrcZ0OwN+YVlfc9/I9MGoWvcFlQL2PQz/rs961EbQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=LElmvSgXK6R7eFeooctoRqqV/fBXQPjZLbqc+w+IrZoXxZ4sSckO/oUW6WGHujWpc
         QaDiqjO61BKg3Xvi3mRXPBNCDu7CZAejE4mZjXlnvMoVsuodpk6tdXR1WQXYK4ZY3m
         hqx/umP1W7NeJRRL7Q+U4wd/BYGRzEngE0O3YPhk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MhWor-1oLJW018d9-00eaeq; Thu, 21
 Apr 2022 19:52:55 +0200
Date:   Thu, 21 Apr 2022 19:52:54 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Daniel Habenicht <daniel-habenicht@outlook.de>
Cc:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug Report
Message-ID: <20220421175254.54y7dzxhtu33wu6w@tb-raspi4>
References: <f1647260b37d492d96ac92f8ef30a087AS1P190MB1750B08CC923A45E2C959250ECF59@AS1P190MB1750.EURP190.PROD.OUTLOOK.COM>
 <YmB7gvfKY/0njjZy@camp.crustytoothpaste.net>
 <017001d85506$bee0adf0$3ca209d0$@nexbridge.com>
 <AS1P190MB1750C249B4857371132C5DF0ECF49@AS1P190MB1750.EURP190.PROD.OUTLOOK.COM>
 <20220421143931.o53dm2qnfcpsido7@tb-raspi4>
 <AS1P190MB175022A7F1264807ECA464A8ECF49@AS1P190MB1750.EURP190.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS1P190MB175022A7F1264807ECA464A8ECF49@AS1P190MB1750.EURP190.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:ROQNwf+xZ2Oza7r/+bWFLsh9WSCvfVpQi08rME0/N0S+JI+cser
 WSO9s+3rFS4KZVAZELt/uiTH+ANz6rtuDXPvS6WOg0nRPucZyUE3iIgKbdFsmdEIBW/kmFn
 IAewRFFUYVNjyc/3CW5S75FLbYuEmwTjpjqZe2GSLXPkbdecBN1ZwgVcVng78K783yNSoKn
 KHmqwnQpdYDfc+McBul9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aYXqgfKWncs=:juQIClqvJRG9ODmVRebD9Y
 u08vsHEEfNYXaPQJNeoiFFjdQM1VRTIQPnCSgIaRf/sN7xTcAnQCNYCLTeNGZW74oBPkHW9Uf
 u7O/hdJP6/svW8b2lplnc8IEt/DwLNaL8RSoGwUhibHYxCSJ7MStK6zPNt9OJbhXWh7IdUjz0
 rwXXIK45rhb2caJjxWC0BpMGlSflwlMQUKcnUJZjfMs7kx9vt/jRpI2t7aOBXkzUhmuJPITi2
 BQAUNz0ix+nMGA7afDmObFwgyB+s5v1+WA39pZZDcXYlzEH8+VydqS5zlDdmEkLz9y5Zmay0U
 qfLzUllsHsWy6+nu+uOUs5k+RWeq9G/EAo5YzKOHe3zrJsjNZYxflWuJ/vwglilw9loR/iG+q
 78cpgtQZGKevDOjv1cga1MPVscXAl4yDm3PneJaH080L7N5ALUTdkdmI2Fsn30c1xcyudaDVR
 n335Nhr3kOneAW7SlYJeg/2TxCRuQOmlB3+2u4wegDafTxOD5z7HXBV6bM33RLOGdmcMLeolU
 sWgQC9EZ5m+UrvzdQFKw/LCHbjcrEjFZIxOo9Ct/6HMoK/Bac3i4l993ovZ8VNAuS2i45bE/b
 1SEVwDeSB3Jt7ekwOumdLb3E5GEWIIUGSnhRqMqKEufAgaZHDN4/06co/mNS48fd+SoAESqFM
 +hLkMep30NOSH/bm/nlVPH51IgQIDnYqxCNd9XsNo3ke7grWdOBwPHUXensh1QA6lJiywrJ/Y
 90JQJI2IhVsVlJHgA2nHzi3E/kBPn8GIY2h/WlD7qFR8NwUx5agGFO67wJ0sQc1XhdI9qJFak
 8kGfz8vaL7V3Eda3HLIFpU0Uc/ay3f3eEAM5X41zqolNXOjVuj623UMFJR/vejWAZIHgLndE5
 TYLPS0Xk/0MJVPQF+VDLpv3BjGbwn/EUX9XBLur7jElWLqRSjiNuGvRQ5CWAWGRO15CRju4bA
 3iuJ8oSyAix23cPb+Z+QKVu8B3voIFptQL5G6yVzGTYcuKDm1NtJRvHxKJKfcQlzLm0dx2wJB
 RQGZARGyOQRbWLOR/Ob7WiiO7WoEtESDG32LB0LgfsU2hjGqQVyOlkK5ihsaqgD8QW35I8tcD
 9+DW9dkwerffKw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 21, 2022 at 03:29:20PM +0000, Daniel Habenicht wrote:
> Hi Torsten,
>
> thanks for your answer.
> As I explained in the reproduction, I now know why this is happening and=
 I successfully resolved it for my repository.
> I just wanted raise awareness that it is not self-explanatory to non-pro=
fessional users.
>
> I would suggest two changes:
>
>   1.  Warn the user on commit of the .gitattributes that he also needs t=
o renormalize the repository (or even better, do that by default).
>   2.  Include the information about the need for a renormalization commi=
t on checkouts/restores/reset if there are still files not updated (shown =
as modified).
>
> Regarding the "Users which are confused may put their frustration aside =
and read the documentation".
> I think most users won't make the connection for the first 3 google sear=
ches, if the problem arises only several commits after the gitattributes c=
hange, or if the repository gets cloned by a new user.
>
>
> Cheers,
> Daniel
>

(Sorry for the top-posting before, this list uses bottom-posting)

I still hope that users who are able to find the feature of the
.gitattributes file(s) are able to find out about the renormalaztion as we=
ll.
And you are not the first one who runs into this problem, if that is of an=
y
comfort.

Now, back to your suggestions:
The way Git works does not seam to allow a reliable detection of files
that are "modified" after a checkout/restore/reset when .gitattributes
change. (Someone may correct me if this is wrong.
It is related/connected to the timestamps of "the index"
and the files in the working tree and the fact that "git add" will
need to store a new version of the file in the repo e.g CRLF -> LF)

Automatically doing a renormalization seems to be an impossible thing:
The commit as such is atomic, including all files in the working tree
with their line endings and the .gitattributes file itself.
Changing things here seems the wrong way to go, at least for me.

Showing a hint when a .gitattributes file is commited may be more feasable=
.
I haven't digged which part of the code would be the best place.

Patches and ideas are welcome
