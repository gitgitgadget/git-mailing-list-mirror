Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B848C05027
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 16:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjBHQM2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 11:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjBHQM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 11:12:27 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AF648A09
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 08:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1675872743; bh=/0fK8HFZVlC95RB8RFlHEYkC73VIaxKQQXA0LmhY+9c=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=eTQZSEsYFWw9SXW7//tyVezjfyRphNGTFid7ifjNh004y/Qfb7bRfM/FlpD3Q65h1
         /JUG/KnsR0uYADzf2qlm233VSg1iNmkH6NITgVOaJUdbboAZ7DczcQxIR4McQpFkNM
         t+aispXX6MO2kDLRe+YFjYMJbd9FFD+nhw4aoN2D1HWj/Vi2aPH5RBSICACoWyLTaq
         2eLY+99ouIvYvR2FzRL5h5kTKLTlMW5jIMk7Boh/oVhmKqK906UfOJV979ZekC3o5o
         nQhzlc+PF2G8hNGL2Trn2m+kLybejw48fSXJSkp/lTToX/x8FShnjIY4YqxquVC1Cu
         nP0SsdJEpggJQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2SL5-1oSUcz3jDj-013xfI; Wed, 08
 Feb 2023 17:12:22 +0100
Date:   Wed, 8 Feb 2023 17:12:22 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Kir Kolyshkin <kolyshkin@gmail.com>
Cc:     git@vger.kernel.org, Roman Dodin <dodin.roman@gmail.com>
Subject: Re: [PATCH] remote: align columns on -v
Message-ID: <20230208161222.guqqwlceqiy3jq7e@tb-raspi4>
References: <20230207235238.1850757-1-kolyshkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230207235238.1850757-1-kolyshkin@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:BBJs/OQ+ltemA0Odyu/YL4jhmFVXMqLTQ9XdcOGZzVKTl9tT2HN
 iKu70Z16YoN5+jDgAAv1pxQVX26K6xj55uKTlFgu5+Oks5z2+JmZT8X4PAi9R0o7XtW1AmZ
 b/Mw8welkqERCAajPtt4yFUZB+NBtQ4MOBWQvUYaZ71qedCMkhQeGpNzqf8pnTJSWfeuwCa
 Odje/D75HFrEyuFg3RKGQ==
UI-OutboundReport: notjunk:1;M01:P0:S9yUISWU+8I=;3DXk0FCAbfxlrq3yNqiTy8+6dtD
 bJV/abIABuDW5+IEZwGPzklSuvgPbqlmeWrlZaz1ELr+bOL3NRMDdkv0aal1r9oLUZTwa/J+a
 hJdhnWuzQj5f4XxSXElWE1q95PmdJ38DhnLcKgz2xWneyvzPE7sVphQi3MF2HLPB23F/TVA3l
 fc/KhEbI7Nefhw2Uy0pMUGkbRC3uNqcOswbUhFER+mY/dFwJ3gW6J9W/ToL2ZlDyLOvkjcW0Y
 VBPtSm9pqsEAKK0KFipj3O+rs4yYuBWrBfAc2CNN1GL8ixVCU6QJzPnfSgfgFStAfue0iDpQd
 LMPUOOfGQZa5TfA8CfTIMxXX4JOOqb1yiz/io2YqtO3iPB+8GHtDZhtX+VysJ+IcOOLJuvfst
 vJdSd/cRe0cz6711VwfAGCE1yqzeSrh+u1UMnFYpgwOJVsv1hRg+6j3Dl6lYg7wThyZqWymHq
 ykMNGjvA3ccqj5eSPvH5zz9yO+5zP7WOE5y4zsinEv/2zE11y42ZokpoS4TLGm2eN/d40LSC2
 QvQ8SqWDQOj4yDarGrKbDj3aj+iNo74oejXR7ah4gc82gv1Mo4PEU5Kw9q1yp5UKiR1m4nxYI
 bZGw2nksAGS8yKdZWKaoIU9O/8l1tbhq60BllF/XWBn7ixTHIkYaonw2QYv0MOBnttnBT0fYV
 HdMV8q5Hcicg1rHLaLTPkDmChFOW/NFOoCmD3fV8yKTHmP2g9akcbv8su2jA5UmGkCn0HCHvi
 8s36o9QDLr8BTue369qpSPXCWMtcnetZWzKAyRQx/w/vErdtbKBnPN7g6i75Zbk2cl85/ZSNC
 f+TfL8C7q0FW1ywRs18EtOD4d1XONfPPRUYdYH12tecwOK7G7n+2K/ns4ZQFPlsDnFg97D4Ad
 ra5qMXayniKrV12IbRzpZF211vo/Y1l5gz9RMl4xiZwKft9D7XBKK+Jp5V9PSi2jWx+N00o1/
 O/hRtKHt+UYykvzfM5WKITL0oGI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 07, 2023 at 03:52:38PM -0800, Kir Kolyshkin wrote:
> Currently, git remote -v produces a misaligned output when a remote name
> is more than 8 characters long (i.e. longer than a tab step). Here's how
> it looks like:
>
> giuseppe	https://github.com/giuseppe/runc (fetch)
> giuseppe	https://github.com/giuseppe/runc (push)
> kir	git@github.com:kolyshkin/runc.git (fetch)
> kir	git@github.com:kolyshkin/runc.git (push)
> lifubang	https://github.com/lifubang/runc (fetch)
> lifubang	https://github.com/lifubang/runc (push)
> marquiz	https://github.com/marquiz/runc (fetch)
> marquiz	https://github.com/marquiz/runc (push)
>
> Let's find the maximum width and use it for alignment.
>
> While at it, let's keep the \t in case some tools depend on it
> for parsing (there will still be trailing spaces in the remote name).
>
> With this change, the output is like this now:
>
> giuseppe 	https://github.com/giuseppe/runc (fetch)
> giuseppe 	https://github.com/giuseppe/runc (push)
> kir      	git@github.com:kolyshkin/runc.git (fetch)
> kir      	git@github.com:kolyshkin/runc.git (push)
> lifubang 	https://github.com/lifubang/runc (fetch)
> lifubang 	https://github.com/lifubang/runc (push)
> marquiz  	https://github.com/marquiz/runc (fetch)
> marquiz  	https://github.com/marquiz/runc (push)
>

Thanks for working on that  - I had the same wish as well.
However, I am tempted to comment on some details here.
Especially, what happens if a remote is named with a non-ASCII
character (unicode code point would be a better term) ?
To determine the width on screen for aligment, strlen()
does the wrong thing here.
This has been done at other place (being UTF-8 aware),
you may want to have a look at this change:

  commit 12fc4ad89e23af642a8614371ff80bc67cb3315d
  Author: Torsten B=F6gershausen <tboegi@web.de>
  Date:   Wed Sep 14 17:13:33 2022 +0200

      diff.c: use utf8_strwidth() to count display width



> Reported-by: Roman Dodin <dodin.roman@gmail.com>
> Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
> ---
>  builtin/remote.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 729f6f3643..116417574d 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -1245,13 +1245,21 @@ static int show_all(void)
>  	result =3D for_each_remote(get_one_entry, &list);
>
>  	if (!result) {
> -		int i;
> +		int i, width =3D 7;
> +
> +		if (verbose) {
> +			for (i =3D 0; i < list.nr; i++) {
> +				int len =3D strlen((list.items + i)->string);
> +				if (len > width)
> +					width =3D len;
> +			}
> +		}
>
>  		string_list_sort(&list);
>  		for (i =3D 0; i < list.nr; i++) {
>  			struct string_list_item *item =3D list.items + i;
>  			if (verbose)
> -				printf("%s\t%s\n", item->string,
> +				printf("%-*s\t%s\n", width, item->string,
>  					item->util ? (const char *)item->util : "");
>  			else {
>  				if (i && !strcmp((item - 1)->string, item->string))
> --
> 2.39.0
>
