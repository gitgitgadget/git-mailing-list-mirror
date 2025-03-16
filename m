Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F6263CB
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 00:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742086056; cv=none; b=OZu7A88DpAAxdK++Te3PuN0fi78wPO03yOELGHBwDeA2JqTwX38Y5Q9piTRl51dQjwMR69IPp7Ac7sdOLbL55qya0bz9SwlVBHocSOxFrMaEB5miOb+4TEzdWvBRjQu0B544SgQq06pyjuqjslpNJzYXY5DUK1nye+fz/x4HyrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742086056; c=relaxed/simple;
	bh=LDf5e2Bb02me/ZkjyE7Rhx8c5iaK7qevYtyIMmZFyvs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cbvQqA/LxGktsE64eFixcXnOt9kMRZwCPFWY7acBTp0xgJ4EMLhCdF/9R/Ylziog+T2c2nIVIKH92hkvRcCUUutMuhKuRUV96DHA1oj6SuN5HmhQWirD8BZgy80F8zdxddjdIlSR/0rhP18RmzJypW34m/u6EAIRwNTHQYiGN/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=sxQw2VOm; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="sxQw2VOm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742086052; x=1742690852;
	i=johannes.schindelin@gmx.de;
	bh=39r4N1BTLQbBI+h4qADbQNNmW5cQ7dQzz4Lvqjs2FdU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sxQw2VOmkTIPYrDEAz8fQD9RTRViddQdrkPKsgtoVC0qCZinB+fBW8KFqdpe7jEl
	 uyWr75rbxQs7QH9CnL3Vkn+FDKfsxmzlQd2vuKwz4POxiisbBzCp6Fe0oDFj7uCsM
	 pMObn7eIlB1OgT8YaUaWPJw28+KtAfpsQy6wxMc2umWwLFN8zQ1PrzB8asQixJbSO
	 JMjz25YzNxbaFCdIrRBPumsqjBR9JfJvTmk/2I3xiQr8hK9sNlu8pgj/q7CGaMO3v
	 feIDmSh1u1vjCiPECJkbJJGkZh2stk/D5ha0xwyCZJG7dbRQw6zEun3scrwiWmBqk
	 nGH0yT5Ce1QoAEigkQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.73]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfpOT-1tIbOP18dF-00lLM6; Sun, 16
 Mar 2025 01:47:32 +0100
Date: Sun, 16 Mar 2025 01:47:31 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Adam Johnson via GitGitGadget <gitgitgadget@gmail.com>
cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
    Adam Johnson <me@adamj.eu>, Adam Johnson <me@adamj.eu>
Subject: Re: [PATCH v2] doc: restore: remove note on --patch w/ pathspecs
In-Reply-To: <pull.1504.v2.git.git.1685654097812.gitgitgadget@gmail.com>
Message-ID: <8c8da3d4-5184-f83c-c08c-51805fe9ca99@gmx.de>
References: <pull.1504.git.git.1683282753768.gitgitgadget@gmail.com> <pull.1504.v2.git.git.1685654097812.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kbXaJjMS4vJzTMZKKdIIikRVX8EYIILbEx7YeQ9vqNsSPBtmqN5
 bGMPEFR01FrvjvHAvM0JWoWEzTCKuXL8XK+kRvjNHCcZn8KhSDABMlhb5sxqjTPm86MV2Bv
 PKzdLXnaUmEdAgRLCv01j07oMa3h+WwXs4c8oU3qPrH9jfktY3QHHr7rvvw9KfHW4a6l+jC
 qvosJPnRBOKwS3h0PJQkA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SBnXK7lsrG8=;B+tmojl/hh2s/tr6HSWBmxNBBuq
 5jUBuh8HO/awYaF14aj8dWWi8JHGeLaQngfqiVyZdA1jt188SWKZjY7fgHPcJimXv9D+0OKQl
 1dt8xmFII4fAzF6aSZgwZw8Fu7mT+8A6PiQzOKz08tZzmIR/5/c5mqfUypYIdt4A9sF30cAbE
 cPxIHoIaQYb8fovTXa5wyUMms6YGApy42qX7yq2vgGaD62d0aaYjaWXL/WWFgeRdeX9HMoNc4
 VcVCcMoAUHHix19jVA3h3ZmzhZoQBDJiRW2iYAwCMbzKZOzEO4xWh2KiN+AjN3qU7p+eoGHPd
 45/v2TLoZuI0+ERUllYEOOSNCWK93h6zD8zNd5T0j3h01LNHQEsbpQiHiFI6a99Ej6xk8RCoX
 vbhTu4y1/+H+vgu4Sme7yM84jDsZuiemx91sRHa/GPxlTY6QSxtoxtSz4T3jGAQ8r0yLM/YqI
 sG3JqRjnn/zB815LFM/dRdYM6tkDSKXUrREarPMvJu8tmtvHUjnbB1tWGGkjbAxI7r4sagRAA
 DN31bBa5ndJg6ZUOc3JFJpuRR5JjqrY38/Gv3tqAZCZONO7KG2WueSwnd8WzZb5Ogn1qqEvX+
 xAdzxWzEsnK2o5zD1BFrBDp899gDwEEm9FrmgIqMoJ6B9sbP2/8LusSdj7ayyc67CA5XrIuMg
 oKa6jUFFj4BVRVxyd1CzaxkxwS0q6XwEgFbsgBqyzVH4HAJwKHFr9kjlpjCdewHmdAyI7Gxye
 JNzy7qlbjFxV+wfHRBE9s2svugfggO3GLiT9mUxSBK8WuO8vmSiNNY4uOCyaFgQZAjoDSfwFM
 hQD8cj60Jw7o6HUuGqx3HwyGcwUOsNYlaqZzN0pKGXbYoqgwE3RdTSmWlegYvyBOul+BTjjGj
 63Z3sUTLSmr7tUdepZ8L8lfkV68ezdApbnkyQAIJdbFCsjemAqTg/zAeEyTCmCap0jUZDE0xv
 7VpeeGI8F0DLwLz5OEQtMjoxJdm+pgczA3GATynhTK4DLgNo/SLbxRUpjgPXu5jvXHaR58Jro
 zjRJwxeEIVsrrrmEOksxGNdmuWKDOFZ/8/ipAiKHJW5mW1Ln9P1aTEanVh4a70h+8xKrmaFIV
 Us0HaTUdimR71Rs9X1AzUWPd+HC9kWPvaOK2VqQQq22sHzQF51BBkKtdbqIbw9V90fFnvtRyc
 Q4Ayh7tYDRX/lJIteSeCP+3EtXqEvgKum6tpj4kBxdkEmTWOLJVFkDLuchAvCPm62a3X2GI+5
 W5GnvhHyjqyQ27zRvy6viIejN8Q+hNM8MOtXpZBloTzWiclx1KNK8ZM6QyKjRPIEcgLK/mWCF
 EoKhSJ0O+qX9P3um7kwl06R4Q6TbNtIW7Jjy8KmLU0rZliiHD//tVH5K+tb0cK7JNCK6W2S4D
 RDVVdpXEfbRzyrw98nYW2L4aR8mrgL9rT4NroxwKpbK9IVDPdBi7XmwTQQLYzpWl0LnaXzpPu
 ukJmrsia+SwMaVItkWxjRRDxT8k2Rza7ATvKbS6cSEk5mO09xnKnHpPNs6YGEBWUEwumU+Eoz
 FavUXBVLIpZzVvAIkDs=
Content-Transfer-Encoding: quoted-printable

Hi Adam,

On Thu, 1 Jun 2023, Adam Johnson via GitGitGadget wrote:

> From: Adam Johnson <me@adamj.eu>
>
> This note was added with the restore command docs in 46e91b663b
> (checkout: split part of it to new command 'restore', 2019-04-25), but i=
t is
> now inaccurate. The underlying builtin `add -i` implementation, made def=
ault
> in 0527ccb1b5 (add -i: default to the built-in implementation, 2021-11-3=
0),
> supports pathspecs, so `git restore -p <pathspec>...` has worked for all
> users since then. I bisected to verify this was the commit that added
> support.
>
> Signed-off-by: Adam Johnson <me@adamj.eu>
> ---
>     doc: restore: remove note on --patch w/ pathspecs
>
>     This note was added with the command in 46e91b663b, but it is now
>     inaccurate. The underlying builtin add -i implementation, made defau=
lt
>     in 0527ccb1b5, does support pathspecs, so git restore -p <pathspec>.=
..
>     has worked for all users since then. I bisected to verify this.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-15=
04%2Fadamchainz%2Faj%2Fgit-restore-patch-docs-fix-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1504/=
adamchainz/aj/git-restore-patch-docs-fix-v2
> Pull-Request: https://github.com/git/git/pull/1504
>
> Range-diff vs v1:
>
>  1:  784143b9949 ! 1:  556f4323ce6 doc: restore: remove note on --patch =
w/ pathspecs
>      @@ Metadata
>        ## Commit message ##
>           doc: restore: remove note on --patch w/ pathspecs
>
>      -    This note was added with the command in 46e91b663b (checkout: =
split part of
>      -    it to new command 'restore', 2019-04-25), but it is now inaccu=
rate. The
>      -    underlying builtin `add -i` implementation, made default in 05=
27ccb1b5 (add
>      -    -i: default to the built-in implementation, 2021-11-30), suppo=
rts pathspecs,
>      -    so `git restore -p <pathspec>...` has worked for all users sin=
ce then. I
>      -    bisected to verify this was the commit that added support.
>      +    This note was added with the restore command docs in 46e91b663=
b
>      +    (checkout: split part of it to new command 'restore', 2019-04-=
25), but it is
>      +    now inaccurate. The underlying builtin `add -i` implementation=
, made default
>      +    in 0527ccb1b5 (add -i: default to the built-in implementation,=
 2021-11-30),
>      +    supports pathspecs, so `git restore -p <pathspec>...` has work=
ed for all
>      +    users since then. I bisected to verify this was the commit tha=
t added
>      +    support.
>
>           Signed-off-by: Adam Johnson <me@adamj.eu>

You clearly have addressed Junio's concern, and since the reasoning in the
commit message is valid and the diff is trivially correct, this patch
should be good to go.

Ciao,
Johannes

>
>
>
>  Documentation/git-restore.txt | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.t=
xt
> index 5964810caa4..d31a06a673e 100644
> --- a/Documentation/git-restore.txt
> +++ b/Documentation/git-restore.txt
> @@ -51,9 +51,6 @@ leave out at most one of `A` and `B`, in which case it=
 defaults to `HEAD`.
>  	restore source and the restore location. See the ``Interactive
>  	Mode'' section of linkgit:git-add[1] to learn how to operate
>  	the `--patch` mode.
> -+
> -Note that `--patch` can accept no pathspec and will prompt to restore
> -all modified paths.
>
>  -W::
>  --worktree::
>
> base-commit: f285f68a132109c234d93490671c00218066ace9
> --
> gitgitgadget
>
