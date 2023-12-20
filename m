Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12D83FB0B
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="LF9e256R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703086997; x=1703691797; i=l.s.r@web.de;
	bh=TAQzExhEBW7y79O9xbUqmtx5S7h0tljHT88Do04vDXQ=;
	h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:
	 In-Reply-To;
	b=LF9e256R/CLbm5vNymMsdtqAj5Qq347jW+7BZjhzjJM/coyoqcyITHVvCtqJ6arV
	 O4eqeNAc4+njBx37lV3n5FXsvi4eJH0b/rS7r23XQJEsxRSHM0g1g//w+T5Z4HsSg
	 Lo1GtmTo6sEXk3OQDPjPr7th4QsYmCthG3q2WfHzoQvBhLJtwS0iue4rHGj5BLbpU
	 V4+KemkHPxz4IwQbM+hfkwmktkiX0HzRluf+Zu9J4YQ3zkunzqlxvRMEZ4ds+T425
	 4uAH/H2TYLQ12nHqNH1XS6saogTShdNuUnDJhBm2IjENp7DDQsd2WREZdN+Br93FT
	 jUz5nM94a3Nm3k2jGQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mkmzl-1qsDda1RU7-00mC2N; Wed, 20
 Dec 2023 16:43:17 +0100
Message-ID: <c6814a39-b4f9-4b1e-b81b-45ffe4aa7466@web.de>
Date: Wed, 20 Dec 2023 16:43:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] Documentation/git-merge.txt: fix reference to synopsys
To: Michael Lohmann <mial.lohmann@gmail.com>, git@vger.kernel.org
Cc: Michael Lohmann <mi.al.lohmann@gmail.com>
References: <20231220070528.8049-1-mi.al.lohmann@gmail.com>
X-Mozilla-News-Host: news://lore.kernel.org
Content-Language: en-US
In-Reply-To: <20231220070528.8049-1-mi.al.lohmann@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3NbxJ++hMUoI3blx7XhWrQXAP1uD8+mbUTrD9WQkTFN9SAdlO6b
 wTYrMFrhDZQloQuHMEnK5Hh8FOrI4HVPkgiYk7pQ6YejVqTNffn82F3j8V8+A4i0Tq21xWC
 1UjS0UDbsobYDW0nEM1tUblTDJq+7rUzlXYzM2PKyguv6GQAjio25C71L9pp6o7NU3ktVgT
 2bq17eZE5z4zb9Vbmg5Dg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Nnwi0RwEmrE=;aDk7XWHXk4hnlJl/yg2P7ILKaGH
 Y1hC8MSmhN8dhiqhl56heeAq3zqB+Qe2279c4UL5UIpFS+9/9aUyidj895/LdersK8Rgek2Pe
 +3T/+37fPOHnwjdANpFtjUVLBUtBeSqH6U2awGhoydWqrMxeFGUL3e6kH1k/39OtMBB/9w2oM
 Eb3sNUx/ePjshEKadbBxHr4jlc5AMkP/bx+H/rlaKnEfmjIUOR02TazPYu1LFqZTvPDudWfMw
 LUlRkdNif085rvaZXBKJeUg6uAfIL/ZETniZcUZO9OwBb4PzDV+mAidiuBNkwLP+w88Lo5F07
 I+qjEWsuDT5AOt8ASz4OYLlN+HqCA3k68b/2EG9cirpOpu8oSxX38Bz5nor0K6VxWi71kMW0s
 1Tr7FLLYjLKQnASGhO4AKoV6uuYbfBNxlqxR7QVSYtSOTfTMzkR36nF0fP1snDhBUk1RAg/iI
 MH25sDaUX/v62oo+dy4LqoM6Vv7KdTI/1Ze44yLR4XnSSZ+dKIwDx3zyGI0ExWx8wRmyrKH8e
 uoSqxjDKdRNdpX/KAo5ek3WCK2V9+izwyKnnEbtbbOHYBsdSmj1+7GWJH3LKeqgYt7h9hgTOd
 xC/KtxQsn7/muM8zNFHdEzMSexlB8T3G6hF14HB8BkaatPsd3OVdPQ42BZ5L8dNlFPZELw9Yf
 G6IOI8hHfqR08ziWZmUyMIMV14kXMN9Bn0mBRzrWAmoHTAqecU2iS2pm5BwwMFGzq2ayKkuzP
 hjrDVKqKje95UhbLv2ZKCvGRwPJFyNbHhO2Oh4KalZf71ojtBW6DA03wgTyV7AxqT3BNTiNqK
 DVSgvL3yb+Ke/GLzo64LPWam4Q1xZ/MzNxBQ706V0MTxhuv3dGQql5qzoo1nOSJVMjRrWJzI5
 ODfAftc5WspMSh/T322QxPKeOIvhPhdqW3FNSXbHV6PNdnq+0pw30WrD99DD08R+1M+ZVb7Wb
 e2sMbg==

Am 20.12.23 um 08:05 schrieb Michael Lohmann:

Thank you for this patch and sorry for the nitpicking below!

> 437591a9d738 changed the synopsys from two separate lines for `--abort`

"Synopsys" is a software company.  A "synopsis" is a brief outline.

> and `--continue` to a single line (and it also simultaneously added
> `--quit`). That way the "enumeration" of the syntax for `--continue` is
> no longer valid. Since `--quit` is now also part of the same syntax
> line, a general statement cannot be made any more. Instead of trying to
> enumerate the synopsys, be explicit in the limitations of when
> respective actions are valid.

Had to think a moment before I understood that "enumeration" refers to
"The second syntax" and "The third syntax", which have been combined
into this line:

       git merge (--continue | --abort | --quit)

And it does make sense that we can no longer say "second syntax" and
only refer to "git merge --abort", or "third syntax" and mean "git
merge --continue".  In other words: References by number are no longer
valid after a merge of some of the synopses.

> This change also groups `--abort` and `--continue` together when
> explaining the circumstances under which they can be run in order to
> avoid duplication.
>
> Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
> ---
>  Documentation/git-merge.txt | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index e8ab340319..d8863cc943 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -46,21 +46,20 @@ a log message from the user describing the changes. =
Before the operation,
>      D---E---F---G---H master
>  ------------
>
> -The second syntax ("`git merge --abort`") can only be run after the
> -merge has resulted in conflicts. 'git merge --abort' will abort the
> -merge process and try to reconstruct the pre-merge state. However,
> -if there were uncommitted changes when the merge started (and
> -especially if those changes were further modified after the merge
> -was started), 'git merge --abort' will in some cases be unable to
> -reconstruct the original (pre-merge) changes. Therefore:
> +It is possible that a merge failure will prevent this process from bein=
g
> +completely automatic. "`git merge --continue`" and "`git merge --abort`=
"
              ^^^^^^^^^
              automatically

> +can only be run after the merge has resulted in conflicts.

The connection between these two sentences feels weak to me.  Are "merge
failure" and "conflicts" the same?  Perhaps something like this:

   A merge stops if there's a conflict that cannot be resolved
   automatically.  At that point you can run `git merge --abort` or
   `git merge --continue`.

> +
> +'git merge --abort' will abort the merge process and try to reconstruct
> +the pre-merge state. However, if there were uncommitted changes when th=
e
> +merge started (and especially if those changes were further modified
> +after the merge was started), 'git merge --abort' will in some cases be
> +unable to reconstruct the original (pre-merge) changes. Therefore:
>
>  *Warning*: Running 'git merge' with non-trivial uncommitted changes is
>  discouraged: while possible, it may leave you in a state that is hard t=
o
>  back out of in the case of a conflict.
>
> -The third syntax ("`git merge --continue`") can only be run after the
> -merge has resulted in conflicts.

What's with the quoting?  It was inconsistent before, but I wonder what
would be correct here.  Switching between straight single quotes ('')
and curved double quotes ("``") seems a bit arbitrary.

And I'm not even sure if these quotes really are what I think they are
based on https://docs.asciidoctor.org/asciidoc/latest/subs/quotes/.  On
https://git-scm.com/docs/git-merge single quotes get rendered as <em>,
backticks as <code> (which makes sense) and curved double quotes as
<code> surrounded by straight double quotes (which looks weird).

The only guidance I found is this paragraph from CodingGuidelines:

   Literal examples (e.g. use of command-line options, command names,
   branch names, URLs, pathnames (files and directories), configuration an=
d
   environment variables) must be typeset in monospace (i.e. wrapped with
   backticks)

So shouldn't we wrap all commands in backticks and nothing more?
Probably worth a separate patch.

> -
>  OPTIONS
>  -------
>  :git-merge: 1

