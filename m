Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCA101F454
	for <e@80x24.org>; Sun,  3 Nov 2019 20:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfKCUhz (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Nov 2019 15:37:55 -0500
Received: from mout.gmx.net ([212.227.17.21]:42657 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbfKCUhz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Nov 2019 15:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572813463;
        bh=NqJi5sls7gMvvP2ptt+REEh4lIi4y9Pe39mZyxX+/Vg=;
        h=X-UI-Sender-Class:From:Subject:To:References:Cc:Date:In-Reply-To;
        b=FBZo+pL/RFGik44fuFNJ5SyMhDJxGJWMTkaoHuOi5mbPBwjCJq/WgCOjsPo3BXL5Y
         e/gn9LWRDiZg/bqBpUt5v5DoFrJ+QKudMaQz7DKP4Y+Q9ypeZC7hCG1rz7vTPTmXck
         wGJx0q+aVosknRDqD7xcqZtJH0Oy1ZioxACuc1Ws=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.3.68] ([77.183.241.151]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N79yG-1htPsR05eu-017VxI; Sun, 03
 Nov 2019 21:37:43 +0100
From:   Ingo Wolf <ingo.wolf@gmx.de>
Subject: Windows Git Status doesn't see files on WebDav, everything else do
To:     Git List <git@vger.kernel.org>,
        git-for-windows <git-for-windows@googlegroups.com>
References: <6c355683-726d-c497-d5df-bb7f8ea770d2@gmx.de>
 <20191027175850.b6le5r3jf3cxtnah@camp.crustytoothpaste.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Message-ID: <fb194341-f7b6-d036-95f1-441c0cb59ed0@gmx.de>
Date:   Sun, 3 Nov 2019 21:37:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191027175850.b6le5r3jf3cxtnah@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:sWkXtwmmB45NnjOe7qTtiA56exlfxXaGbs1QdymgW77Jv9YHog3
 Gb+C+Tel36c9CZqcqULpGy/ytobqjNCDrcQZcB4gds4roxJKyAXV32iNlIwMWALb93etMAm
 z5ETHsyaIkLNL48pzwwQW+Ku+p3ey11N90WpnDi9/JmcOZU5dCAwm4UxCgzQv+hlOc0Xv7Z
 EttYGYYCT4zlANXngbBoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dxcNCSDOVsk=:p0pmzHlrDGhsiPWx5UdiYg
 eJU/iGpKhgxy4AKovrYnUf4HfrcsxQyiYPoTHyng9GRx0yFXP/JKt0p3w1RBLMbSUMbnllbBJ
 dIfFihwbsdnDqZXcl4kolL4mrgLfQ1ljIfvD9u0NOy8rYZVBKbKH8movqu86ooaa19Ie8kQ2h
 ttc8se1FAUocZkKASPfDd4dMb82pZPy/8il3Ran2m46zsPB/qWF6Y7Gdb3PpjzkuTl1NgP5tx
 lwTnxZ5kTuIBNUmWvd0NxIQ8AaIAYas3IZ8Y+KYsYnUcBU3tPnmLkZj+NQIbIir9SO9OQxd4T
 Uec5Jhhx32ibdIzlNNc7TTc7P8FmvSQhXj5Rf55CvQeUvY/2N5bbFMLydjXFE8p4PzgAxAI+X
 ZgY/A1imqzpStWNOSlC09WaL8T2Gz4XL6W86HYRorRu/p8w8JcjqLWj1YWz7ldyfpcxkzSmws
 NfaPKkTSXthrQxMj0o7itPAF/1yrN7io8ZuufU2LcXjnZMDgyvJRHF9rEXfRHXFhPhGTU82Ze
 ZsQPzTJj5D8eYE1XSUMyEgXiDRcQ32+ko+BzAsO/eZdNIANnh8pdeeGltZKDoomUPpgghHWb5
 7KEN+mYf7MaCebENjTWY/TMQ2ti4VesNSHqdOe+7vaYDEKVICrpioufYqYyI3gFM+Ohed3jmz
 1dePd0LYPZOPoVqz7AI4ipR2ZkMUKO1cEf3CJx8F0PqLBJwHNkcqSgI1wE9QIru52IC4he3In
 /VHjF91Zq+7uGylM1jxIUA4y5sAwMYdVRlefYORwo0hXmk5NchmdyPKcGMItjZ4V0pJL8TZNH
 fZkIXo8N3llkt0TTShC+/IdleRL2taRAakb7Oej8h61zYrmjp2vFLJO6f+09041sGEdvoQVy/
 Fo4Y8oLSHZuJrBHfZ3dIU/yhtK1zyo0s3psVvm2iy8RJ4Z+7gmYfj3SQwlCP0znIosyVHkdB8
 6xU2qL0ieiiAs+sD+iRaz0sTnBJ35N3a7XM8YgXw1WkX9+4+VXQ6+pMCayNlpEeIQXYD7avkd
 XnKzyitbIOY9VJTPJ0ATr1a/5AtrJA5d7TtgpZMV3DwN8fOR5k/ezRsTBVSIz0zr3Oc6yxOwx
 V5pYlWuImbCDsCaiaKAmeOv/u2ko6hSSF/T7EVRlbKqRJ6p+hOGIQ5d7xnMG7UyXyuJMwpN2M
 KljSlTM2K1uF9nkKS5wyZ7CaQqD9k0Qp3IRxHnFKB33sUtLhkjoqqj9XqKA8I9+n4gAQLThzC
 x3jxkZ+FJVUMjCB7f2Sblvs89SKoSp2FtdyuQecjHOopkyx9+kA05Udt5keA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Are there any more ideas what git configs I can try to make

Git Windows Status see the files in a WebDav workdir (and not as deleted)

like any other program, even git commit commits them and
checkout doesn't checkout prompting already there.

Settings recommended by brian haven't helped yet.

Am 27.10.2019 um 18:58 wrote brian m. carlson:
> On 2019-10-26 at 03:07:39, Ingo Wolf wrote:
>> Hi,
>> Git Windows somehow does not work with a Webdav Workdir even wenn
>> connected to a Drive-Letter.
>>
>> brian: Knowing how WebDAV works under the hood, I'm not entirely surprised that
>> you're having this problem.  You can set
>> core.trustctime to "false" and core.checkStat to "minimal", which may
