Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0557D1F454
	for <e@80x24.org>; Mon,  4 Nov 2019 12:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfKDM30 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 07:29:26 -0500
Received: from mout.gmx.net ([212.227.15.15]:54595 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbfKDM3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 07:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572870558;
        bh=a9kzuKRMfYJL2Sh8h/sQe3+6lScsMQq8c56N/TzgzeY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=V38FMPGp8A0sztj7rYobWhKVN2BbqI4OnCE20Y7tThBiTlUJLDpZlW6JiGuxatTYu
         uLo9LjXK+w1xdMit2NNkRbr8/CbS6Kk91ZNxQccFNNvrv3jsWIMqi+bXuOTbnYbK1e
         5EWwod8DZ0dPI9Sy7L4mwc0hCUYqVo67oUnJMXcc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSbxD-1iLNAt1Pnl-00Sso9; Mon, 04
 Nov 2019 13:29:18 +0100
Date:   Mon, 4 Nov 2019 13:29:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ingo Wolf <ingo.wolf@gmx.de>
cc:     Git List <git@vger.kernel.org>,
        git-for-windows <git-for-windows@googlegroups.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Windows Git Status doesn't see files on WebDav, everything else
 do
In-Reply-To: <fb194341-f7b6-d036-95f1-441c0cb59ed0@gmx.de>
Message-ID: <nycvar.QRO.7.76.6.1911041326480.46@tvgsbejvaqbjf.bet>
References: <6c355683-726d-c497-d5df-bb7f8ea770d2@gmx.de> <20191027175850.b6le5r3jf3cxtnah@camp.crustytoothpaste.net> <fb194341-f7b6-d036-95f1-441c0cb59ed0@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KqDwPynvyeKQg57qczLXvBtGbP7V/o25/sVWbkRmxXdNpAlX+L7
 6b0nYbWtR+verl30ZGMkffd/xeOeswfGii+LI1YxVxg552BgDRRQB6fVaxHbLVxB0Ss+v31
 WaAqGfmPfV0u2wM9tvP7o+gZ5hJP2w9PcLQIHqPboqqMIHg/7G6Y2pCf16N0Sjq60T02WeS
 h3nKeLDbbxldQ2ERqPsnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m7IXJEu3XNg=:MVtqNbSwJ8T5sWXPxo8F2U
 FkOVw07mG1rTvQA/Dxjv/hgBYIhyAGQVJ4VTXDAQAwbhVVgDNKQ012w/08Kz9MvCTB2JZusM6
 nPELZfSzjo9nO/sBSy+O3xUoovy0QVdDyqBVUF9xqL1IbXzkeLOfFLFFCexqT9rv8AdrX01ZU
 DPamlirzesPHpyUrBfyKywm1D+H5NlGX555bIawpGMTtg230+2oQ9BXnFxw35M4X44yl74726
 qAT8+CiHYObctjO3LxlW2gBcYwePf21uPphur30XhITRa6U6SnWiH2B/x9FmUSOr56y2XmTBV
 8UEchz//nnQKxF02eLs1OTzBVn052Jnv1u5A7NvW6QfOGzg0azcA53HZxElZir3h3s90o829C
 JlFMpPOqFJ4+ghgfAkqE01j4mQGrWC7+JIAFArjraTAk4w/kRluAEUUNBCiUZ6KtTCdv1f3r6
 clAhlfyglSneUDc8pl8hSXouBvlWiIE6yzhBA2imgDEfKOraY5ugIJ0wFXX+2L2wjldNyrVA/
 EiBpFmOyqH0sS3U0Z23V5odVWCpOaXPXgW5VLiLIFdM9CTwAgrk0rYBDNEQ2ZBveBOnon3dpG
 LHKai2wEitRC1iDC0jSmhYnyq4EJneiGjASvJU7dfwiUEVfI82g2qPpetBnh+T0c5HF8Zil2v
 E5M3YkRUXHHBSq/3Y+9NWi/WQC9ZXynAFXmnqpUv0QQHQ6pnibroylWN+NT3HP/7+yWo+QLOo
 dyN+yY2Ik3ZKPGPlTSYsOjCbgCi5gW3AcMfv34XLI66QgnfcVPSsjdPwypyoRXwQDWymvzgbc
 Huyj/5DKrN5l8fAPMkI06GOZ63npVwJ77PoLuq5uGlF7hjHEVqKaSazPjV7mKHfJDZQtvccZw
 8059ybce4OFCg4HVMvW25Fou2Hh7MQsGOdlljC5UBjcdz7aSrSCxA4vXPGqqT24udwc6zkrmh
 31fTBYUl4tCCWJ5Rh/rkcMoVAIibIPmTxHpbDN8CjXUF+4e5QBmDhVUGuDl29dWsbWKZP7IEa
 mS2D2dh+NDe9FQ4qm72I7Jplex7OFy+PYDuhNBEoWNCx23Kqa6yAkotglfDYf4+XpJURyJp1y
 rBeu0WRhT/Jx3X8TpydNnB6dNb0Y1i2JiiMTbjyBfeg1f/NGOssHtsf2rWry+R5n9phjjA1u/
 zIGI3kzo6cSK8vAMsJNxcwbAafAxLcJWdnG+A2JjpsXey0csrmWt9I6V79yWKNdC3NcOXLOC4
 8W1hHkE/TQ8U7xh5zWnx8MlRnNkY3znAyCFE6yN0pdDBujLJVNrT+Dy/SCsc=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ingo,

please don't top-post. Answers inline:

On Sun, 3 Nov 2019, Ingo Wolf wrote:

> Are there any more ideas what git configs I can try to make Git
> Windows Status see the files in a WebDav workdir (and not as deleted)
> like any other program, even git commit commits them and
> checkout doesn't checkout prompting already there.

It probably has little to do with Git configs, if at all.

> Settings recommended by brian haven't helped yet.

That is an _awfully_ succinct answer. Terse, even. Or, if you will, too
short.

Care to be _quite_ a bit more verbose?

I think that brian's suggestions were quite to the point, they explained
pretty well what is probably going wrong on your side, and that WebDAV
is most likely not something you can use in this context.

Ciao,
Johannes

>
> Am 27.10.2019 um 18:58 wrote brian m. carlson:
> > On 2019-10-26 at 03:07:39, Ingo Wolf wrote:
> > > Hi,
> > > Git Windows somehow does not work with a Webdav Workdir even wenn
> > > connected to a Drive-Letter.
> > >
> > > brian: Knowing how WebDAV works under the hood, I'm not entirely sur=
prised
> > > that
> > > you're having this problem.  You can set
> > > core.trustctime to "false" and core.checkStat to "minimal", which ma=
y
>
>
