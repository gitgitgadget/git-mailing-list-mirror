Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE61DC198
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 22:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739571097; cv=none; b=eIyHwEwKyhwaYCEtiqiAC504I82zf3Cw8qxJ7IMDvJH9rCbg+illTUCrsAx99QRfFxolxk186BE0Cs/4O0JTKu4NB5EAvHHeK8OpvL67SjoC8AtgNMBjpNvn8fjykeop7nQ+dIU8+w38UBQ3sAlypSki8prrQE5FfXSSPkdE5yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739571097; c=relaxed/simple;
	bh=RgQF9KOXNpbiauRl5ViQVHhObsj5aV3PZ2wZpGMUqFw=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=e5YtWgqXQWXMiVRATp7BxANib3udTzCVDwktLmUTx/Z3zBl3Ojm8yNOuhT73t4mYyYuthMqgF7CC/bFe/AG40fPFGUdc3eHOqODrRuZ050PssW2aea3j3DNZcbvo/nAxKJYFQ/JLuxzg1Kascl17CMFCwPUOcH9AJ7gWhX4I7F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=MXWuxrv5; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="MXWuxrv5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=QQPbqJeIhMnzFRWAFNZs1rR6rSABJu6N/sP8dtGTKB0=;
 b=MXWuxrv50YjXpaTtCsfZb61tfTlbNCAutCRfdOo6bPxZ2guoTYh71f4kt7AoqF/9KZh7PkwxSj66
   WRdq6sOoCB/7xwLblqhQcTGcxY/2e9Dqxrrhb9H24PyYQoZqJK1YmkUmZRdZtu9dv/dF4HUN7IvA
   M72EDf7PC6BW5hLGzCvYiBVIf+zJRRWT0u+1paQKiDgt4PHqP11zAhTtYVE6h3sKbMjjkwOhcSoJ
   JjtV49b22gHVcG838YYddDVdWdSHm+O3brWeBzU3IRcsD8Hum1rkbq5f3GyAG3FHarfsCEuRwJ8R
   jY8/6BSg8nMTWTuXZaRJoroXDQEnpoWBI0J6Yw==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20250128 64bit (built Jan 28
 2025))
 with ESMTPS id <0SRP00C031EN9V60@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 14 Feb 2025 22:06:23 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Fri, 14 Feb 2025 23:05:53 +0100
Message-id: <D7SID7X5ZGKY.BZY6LVZ57YUR@ferdinandy.com>
Subject: Re: [PATCH 2/2] config/remote.txt: improve wording for
 'remote.<name>.followRemoteHEAD'
Cc: "Philippe Blain" <levraiphilippeblain@gmail.com>
To: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>,
 <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <pull.1894.git.git.1739554578.gitgitgadget@gmail.com>
 <140794b8846e94ec3ff77920f0153f65d434f07e.1739554578.git.gitgitgadget@gmail.com>
In-reply-to:
 <140794b8846e94ec3ff77920f0153f65d434f07e.1739554578.git.gitgitgadget@gmail.com>
Reporting-Meta:
 AAFohyyZ9X+I4hh95H2m7pOlv7H54RvR7BO+zt7cV73V6GrAFsNY9c+Vh8gC/saA
 uTfw0rk9KSbpAkptzG93cctXgDbE9a3BbF9dsshE1h6omUwCf7n8Y0ZwxWCVYGG2
 hL5a/zud8hyXgE/wYgNp7EzGr4TTYXxcezLy1VVYIq6uK+WNv3iuRLQlZHesvDft
 +b9Yw6IMchrnUIm+6A8Nu5lGKF8tcmkm2/yfpVeBC92bDjDzSseIvw2X5AVCLLOa
 0szYK1x2cbNvnH0OSB4MVlFz4cwPg/Z0Om4qZQXuFPY1K0LOdVx4S9SlLzPDhbOF
 KdsrPROOdhq+OIdt3MxzdiKb5WpYfsGq+T5rHsBAmmqfNf6s0dochNKt22IlyJ7G
 sJbs/44AVzX2vnc7rbfrmTtGa+2MNnwzroWZ58YQpyB8We90ttvElU8dyZImw9vz
 cjPEKepxrHgmK2azz3ef3MGUnroTOdwohyYTwr1xIo7jKId7dYCP75cP


On Fri Feb 14, 2025 at 18:36, Philippe Blain via GitGitGadget <gitgitgadget=
@gmail.com> wrote:
> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  Documentation/config/remote.txt | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/config/remote.txt b/Documentation/config/remot=
e.txt
> index 1b9814e8aa4..25fe219d103 100644
> --- a/Documentation/config/remote.txt
> +++ b/Documentation/config/remote.txt
> @@ -110,12 +110,12 @@ the values inherited from a lower priority configur=
ation files (e.g.
>  remote.<name>.followRemoteHEAD::
>  	How linkgit:git-fetch[1] should handle updates to `remotes/<name>/HEAD`=
.
>  	The default value is "create", which will create `remotes/<name>/HEAD`
> -	if it exists on the remote, but not locally, but will not touch an
> -	already existing local reference. Setting to "warn" will print
> -	a message if the remote has a different value, than the local one and
> +	if it exists on the remote, but not locally; this will not touch an
> +	already existing local reference. Setting it to "warn" will print
> +	a message if the remote has a different value than the local one;
>  	in case there is no local reference, it behaves like "create".
>  	A variant on "warn" is "warn-if-not-$branch", which behaves like
>  	"warn", but if `HEAD` on the remote is `$branch` it will be silent.
> -	Setting to "always" will silently update it to the value on the remote.
> -	Finally, setting it to "never" will never change or create the local
> -	reference.
> +	Setting it to "always" will silently update `remotes/<name>/HEAD` to
> +	the value on the remote.  Finally, setting it to "never" will never
> +	change or create the local reference.

I'm personally not a huge fan of semicolons, but I do agree that the text d=
oes
not flow particularly well. Wouldn't it actually make sense to format this =
as
a list, with an entry for each option? The would probably also help in quic=
kly
parsing how many options there are.

