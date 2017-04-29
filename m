Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5A091FC3E
	for <e@80x24.org>; Sat, 29 Apr 2017 15:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3000070AbdD2PQ4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Apr 2017 11:16:56 -0400
Received: from mout.web.de ([217.72.192.78]:57769 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2997445AbdD2PQz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2017 11:16:55 -0400
Received: from [192.168.209.79] ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MaJng-1dOLLn3JP6-00JnxZ; Sat, 29
 Apr 2017 17:16:51 +0200
Subject: Re: Bug: Git rename does not work if folder naming was changed from
 lower to upper case on OSX
To:     Robert Eisele <robert@xarg.org>, git@vger.kernel.org
References: <10d4f73b-b4bd-4cf8-5727-cdaf10ab713a@xarg.org>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <0f4f39c3-5c8f-8b3b-999b-57b9e3f27ac6@web.de>
Date:   Sat, 29 Apr 2017 17:17:33 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <10d4f73b-b4bd-4cf8-5727-cdaf10ab713a@xarg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:IcHsnSPBUNF8P9R75qECQEO9Kk3fwBYncvVUkxOhuA/yZsyJ0qS
 SIy/2/CUvY0pDby7F+joN+Vj+LbTxpIkiUyirQw2Wc+dGviJ9PxIfNl64gZAx1hbfflks0E
 JoSXIBy+QD4OOFR6LakZ62xz0xETOKdnk0OreRNiWB6KwuHD0ghUybfR32K2MJdQfYXanyX
 hLqd5bPw8ajP3S9tmuQlg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BUe/6ZaQTiU=:MmTVHlVkh2r1oDpEQNNPeK
 2+Lmu9gUtXvbPaGMgOS0uikdCJXf7WSk3AfYBZBOuc+cJP+R/2A4NiyyCO1cly7hR6VU7aNcA
 w9ntR3JD6Z8vZY03sdn8qB+3K0ROfqdYVc/a+GBdmBD6JeJYB8V+OLf+OeOpJ1UCnjiuoPVF9
 HhOqVbBgr2WmRi6ZlXw0ZmjXBy98GQr67E8rRwaMgiy0QKxNRRDojE/xOt7ioud84pncoh7wP
 zjQ43aACoGqFUKh+IplON1Qg2QS29CNKqEv4bo1LzKssdO5Xfzl2jupdSnBj+nkUaLKtYUe+g
 O1HA2uW5nTj+DhaLaiE3227W5kvSw6pGMWDvgUrAEO5GMe50K2MhT47cnWLeD7xqn/4ZKAEKl
 Enq/f6CQezAoLH4qlZfYITLFPnt/IvVmyiw3LK5Z8zh47zhe0UDC7wyhWXp8SNurmWn7eNWsM
 5Zv65cdqIT7/CY8c5kOkL1hG+wpqVe27tOaGVrDfsWMNwSA6amdDNZAUjY1bb127BAC2maKXv
 RSQm7jvkxNwAl9nujJkAupAD3S3SNVwn9TRAk7enjBuReLMYWy8PTyTFL1KvvfomV08Rt7ZrH
 eYLmPmLg1KK8USg2+Ppcm/opRaZl3ug6wve1iWVPbdu3QKsJfI2MNae9RGUDYB3G/NenJI+4S
 u3aNuv+Yf2EttWSBhnJDELdGRhVCWdrUDb7cD1hBeQOhvqJHwo0YZDcTjstdXw4iNI5ymLJeN
 js9JEOp9ZaYPqd/B2RUF/zh7+tgEFx0D/0y7djcw4mEU1wWHi+SGt2PvLYoWfXnkf8StLgMnB
 A/W9FFO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


>
> after having committed folders with lower case naming, I decided to rename them
> to upper-case names. Expecting git to detect them as renamings, it started a
> new parallel hierarchy with new files, which I had to add/commit.
>
> It was a kinda strange behavior, which I fixed by rename the folder to
> something completely different, commit and rename the folder again to the
> desired value.
>
> Is this an actual desired behavior or is it a bug?

It is expected (but may be unexpected), I hope these hints are not too harsh:
You can blame the vendor of the OS,
who decided to design a file system which ignores the case of files.
(Or yourself, because you use it)
(Or yourself, because you can install a HFS+ partition under OSX which
is NOT case insensitive, but few people seem to know about this or use it)
(harsh mode off)

The correct way to rename a file under Git is to use Git:

git init
Initialized empty Git repository in /private/tmp/ttt/.git/
user@Mac:/tmp/ttt>mkdir dir1
user@Mac:/tmp/ttt>echo File >dir1/file
user@Mac:/tmp/ttt>git add dir1/file
user@Mac:/tmp/ttt>git commit -m "add dir1/file"
[master (root-commit) 14d3862] add dir1/file
  1 file changed, 1 insertion(+)
  create mode 100644 dir1/file
user@Mac:/tmp/ttt>git mv dir1/file DIR1/FILE
user@Mac:/tmp/ttt>git commit  "mv dir1/file DIR1/FILE"
user@Mac:/tmp/ttt>git ls-files
DIR1/FILE


>
> Robert
>
