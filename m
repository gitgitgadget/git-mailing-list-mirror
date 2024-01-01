Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35E117C9
	for <git@vger.kernel.org>; Mon,  1 Jan 2024 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="IfdNSm9w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704097487; x=1704702287; i=tboegi@web.de;
	bh=SpEm+uELiD7cMh83K03EvPemcZkIJQ29r5FvI/dJUY8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=IfdNSm9w5tFpibPk+fmy1qOge+IRqyMHV6/8j/TgXpmdyec16Ot6wUvXvjZm+AA+
	 O5ikOV9ykVdjSfcFe6lbWH9VvEfgbV8gpe/s+BegsKqte2MDAB5GnzbUpkx1FlJoP
	 up1VuZTRaIbqTGbe/SjlLeFU4iD5ts/8JcT85LIPXEJNvA4LtNI+hD3YtAZYo0SYG
	 B+rj4bfvtkS1FcZh2NdwBU1xjW4pHh2Bv/Lkn490z984MaaNBpVTHJqeIa13jBuQ5
	 /qTo2uD8OYuZ/n1WqYjPLz03UU4twDudbbM3BsVSV5HkfkurJU8SmXs9C9X4NK6zS
	 1Qf98qzPl0PQEHw+nw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0Igv-1qz5eS0xGB-00xBPc; Mon, 01
 Jan 2024 09:24:47 +0100
Date: Mon, 1 Jan 2024 09:24:46 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Chandra Pratap <chandrapratap376@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH] write-or-die: make GIT_FLUSH a Boolean environment
 variable
Message-ID: <20240101082446.GA21905@tb-raspi4>
References: <pull.1628.git.1703955246308.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1628.git.1703955246308.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:brOfDTqXVclTzpr9seZy7kgk+w2nKW4y8gtDD8kL2SwiAWYbcX4
 Nk1okORWvEErkSJbXqYIY9T3yctgqsIlpLoDywTrKtQPC1JvfggbBcJ8zUq6r+vJncsnNEw
 FzfTHKaXNeFy8JREf72T45CPCw8mROsG6Ta4BxvCmNatIo19aAjsPk/R5jRJfJD2pS/5ng1
 5Th2af/A26r25nVUmq71w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dJ9v32YWSGE=;bktFzxSuABWLPrqD8f6uCw3Mzy9
 8JPBSiU+I6EykG6B4cq4x2QmyYViJnkyJMwJktCZuNwslZ8GxCYjzRYacURpZNy/YMTe8313x
 8+vadx11nOyNVusmLbjSqiqb0A5DEJM96GLZybWqP4k9eYNhX9nyjZgHE6gd1qmyBsiAKK42s
 Qpbv3nVovoIAo+wTRexE9MhUv6jt5pk4ATY+EbDAR3n7l9rOBsVWicRIXbchuj2G/qrOgEQux
 ZJ8v4EFsR1R0i5e8Krotq/px49jXubCn19s+VRp/9MZOjTG8vkiweZ8pqSoQopTFBqC8caxjx
 O52wI41GXWkkWIHkYiUQyhGoIU0zvZWU4G89BtJf+i2ZE3zquiErRId/N1Q+akveDAoFPUXv/
 63ROhrPhjcRps10a5vv1bKlNF6YmuxUbqWeiuyI4uUgOeQlAAA5Mb0SgGixuWsdVHAtzlUdx5
 1Wa7yq2XldaeoM8C09pza0FCuRipC9CR9uzJsDGjtBkXKoDncz4xpuR2JTS4D/Y9iSiImFctG
 V3ohAmLU70D5Nt6VY8DMX9obmTW8aZZzk94pTAq10kmYOWWOBZPCCMqadB5K0kYw7yve7sBwl
 C/GdmXC3eAE+cDL0/ky7eHf06PGhv3URMkMUaY7iX0U9h8FQlRGoPD7RM82+JADQzOHapIBO8
 LfEkTWvmszwLxJktxFnGUcFe4pXKiPSO0N4qkbV1POFcvF55App/DHQbTyM+Tx8VlkQ/C40w8
 rQAAnlEgp4PE0ltdf6bE2880B7lvFgFkSt3PZ6a+nAT0g6fCWi0JVU9/RzcQTnVBloi12n5Ig
 hApiL4D4We6xS7RUvs4DZ6Crwb8vjstbvq2ke2DSnxm1ktb1pRZfWdg4T1ggOcdEfQ0Qoa1g6
 4S1V92TK7lRpm5T0VGl+KSlMZGMeEsNms0LMCHBeqsl+e5WHqGVmDSJKeXr7kRDo6I8FSGM6O
 b9lDeyhOe3ooQ5u33eqOSDruBWo=
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 30, 2023 at 04:54:06PM +0000, Chandra Pratap via GitGitGadget =
wrote:
> From: Chandra Pratap <chandrapratap3519@gmail.com>
>
> Among Git's environment variable, the ones marked as "Boolean"
> accept values in a way similar to Boolean configuration variables,
> i.e. values like 'yes', 'on', 'true' and positive numbers are
> taken as "on" and values like 'no', 'off', 'false' are taken as
> "off".
> GIT_FLUSH can be used to force Git to use non-buffered I/O when
> writing to stdout. It can only accept two values, '1' which causes
> Git to flush more often and '0' which makes all output buffered.
> Make GIT_FLUSH accept more values besides '0' and '1' by turning it
> into a Boolean environment variable, modifying the required logic.
> Update the related documentation.
>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>     write-or-die: make GIT_FLUSH a Boolean environment variable
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1628%2=
FChand-ra%2Fgit_flush-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1628/Chan=
d-ra/git_flush-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1628
>
>  Documentation/git.txt | 16 +++++++---------
>  write-or-die.c        |  9 ++++-----
>  2 files changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 2535a30194f..83fd60f2d11 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -724,16 +724,14 @@ for further details.
>  	waiting for someone with sufficient permissions to fix it.
>
>  `GIT_FLUSH`::
> -// NEEDSWORK: make it into a usual Boolean environment variable
> -	If this environment variable is set to "1", then commands such
> +	If this Boolean environment variable is set to true, then commands suc=
h
>  	as 'git blame' (in incremental mode), 'git rev-list', 'git log',
> -	'git check-attr' and 'git check-ignore' will
> -	force a flush of the output stream after each record have been
> -	flushed. If this
> -	variable is set to "0", the output of these commands will be done
> -	using completely buffered I/O.   If this environment variable is
> -	not set, Git will choose buffered or record-oriented flushing
> -	based on whether stdout appears to be redirected to a file or not.
> +	'git check-attr' and 'git check-ignore' will force a flush of the outp=
ut
> +	stream after each record have been flushed. If this variable is set to
> +	false, the output of these commands will be done using completely buff=
ered
> +	I/O. If this environment variable is not set, Git will choose buffered=
 or
> +	record-oriented flushing based on whether stdout appears to be redirec=
ted
> +	to a file or not.
>
>  `GIT_TRACE`::
>  	Enables general trace messages, e.g. alias expansion, built-in
> diff --git a/write-or-die.c b/write-or-die.c
> index 42a2dc73cd3..f501a6e382a 100644
> --- a/write-or-die.c
> +++ b/write-or-die.c
> @@ -20,14 +20,13 @@ void maybe_flush_or_die(FILE *f, const char *desc)
>  {
>  	static int skip_stdout_flush =3D -1;
>  	struct stat st;
> -	char *cp;
> +	int cp;
>
>  	if (f =3D=3D stdout) {
>  		if (skip_stdout_flush < 0) {
> -			/* NEEDSWORK: make this a normal Boolean */
> -			cp =3D getenv("GIT_FLUSH");
> -			if (cp)
> -				skip_stdout_flush =3D (atoi(cp) =3D=3D 0);
> +			cp =3D git_env_bool("GIT_FLUSH", -1);
> +			if (cp >=3D 0)
> +				skip_stdout_flush =3D (cp =3D=3D 0);
>  			else if ((fstat(fileno(stdout), &st) =3D=3D 0) &&
>  				 S_ISREG(st.st_mode))
>  				skip_stdout_flush =3D 1;

I think that the "cp" variable could be renamed,
cp is not a "char pointer" any more.
However, using the logic from git_env_bool(), it can go away anyway,
wouldn't it ?


  diff --git a/write-or-die.c b/write-or-die.c
  index 42a2dc73cd..01b042bf12 100644
  --- a/write-or-die.c
  +++ b/write-or-die.c
  @@ -13,21 +13,21 @@
    * more. So we just ignore that case instead (and hope we get
    * the right error code on the flush).
    *
  + * The flushing can be skipped like this:
  + * GIT_FLUSH=3D0 git-rev-list HEAD
  + *
    * If the file handle is stdout, and stdout is a file, then skip the
  - * flush entirely since it's not needed.
  + * flush as well since it's not needed.
    */
   void maybe_flush_or_die(FILE *f, const char *desc)
   {
          static int skip_stdout_flush =3D -1;
          struct stat st;
  -       char *cp;

          if (f =3D=3D stdout) {
                  if (skip_stdout_flush < 0) {
  -                       /* NEEDSWORK: make this a normal Boolean */
  -                       cp =3D getenv("GIT_FLUSH");
  -                       if (cp)
  -                               skip_stdout_flush =3D (atoi(cp) =3D=3D 0=
);
  +                       if (git_env_bool("GIT_FLUSH", -1) =3D=3D 0)
  +                               skip_stdout_flush =3D 1;
                          else if ((fstat(fileno(stdout), &st) =3D=3D 0) &=
&
                                   S_ISREG(st.st_mode))
                                  skip_stdout_flush =3D 1;
