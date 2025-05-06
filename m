Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C06280300
	for <git@vger.kernel.org>; Tue,  6 May 2025 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537105; cv=none; b=IpCjYSYy0FvD+mqxgv+4izNN8jx7tJIu0/lF0Isy0j2LEp7yzS6ShdDfwSj7ZY3aKMHg32IWB1XJDJYfT90KcUQ2P9Qpmij1P3sn7G5GjCouwzJfgrTZnjXpaD4lVUnxo204+xHR1kzWybYug2gPW8HT/l6flHeHSBqPwwxK+64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537105; c=relaxed/simple;
	bh=+4AwO9f6IQ2vRzp3GOXuWUYWOoDQVVh9ErL/5FQttQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SApMsJDRf1IPeQexcu7I/rk9h0NL3wpFjvq09uWq9JtvhbcMn3GyusFwnh4HJ9I0vrWwc+FbV1h5/Ja/EA96BnTPNCvy3CPDiBOtKkDxuvb8QgDTSL7OHV6Rh1qXmC30fyDs07leURXmwtPUm0UA77yJt4pcTKCbB0BOex+pxac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=Ljk8b5vX; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="Ljk8b5vX"
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 19578840303
	for <git@vger.kernel.org>; Tue,  6 May 2025 15:02:06 +0200 (CEST)
Received: from [192.168.3.191] (unknown [141.255.129.53])
	(Authenticated sender: jn.avila@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 99FAD780526;
	Tue,  6 May 2025 15:01:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1746536519;
	bh=+4AwO9f6IQ2vRzp3GOXuWUYWOoDQVVh9ErL/5FQttQg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ljk8b5vXtiOiaMx/xSTzXqFVaPaovYd+un6RNU7mCW1Kgypdhu7LaJPC3mmVR83kN
	 NiDlhICap4fgFe7jAPfQL0oq6IvqgnWVVW0dDwidDO0jV2+R01WQSfvJZ+LOpcOfL4
	 0JDjpUqigMNROo5XzuwoSpp2EiL2ksguvDmYpMW0NE5PqnoeiWS0OBzWxJetGtUEAT
	 xWpkQZCceZj16Bl/3WldW3IE5dhm5fx0IINqysPaYNEWZdnSxKAURTJ6WDSMtzjCOx
	 mg4/tIKLBU//dabDUZWDklFbWhV44++gcn6KIcmKL63KLDgTJTx7VRPKUAQ5U82zQe
	 Lb5sQXuGCsIPQ==
Message-ID: <88a76ba4-b30d-496c-ad97-17c4d3c40e63@free.fr>
Date: Tue, 6 May 2025 15:01:54 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] doc: branch: fix inline-verbatim
To: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Karthik Nayak <karthik.188@gmail.com>
References: <cover.1746299135.git.code@khaugsbakk.name>
 <2e41f0f0f0738418375f77146e4b10e0e562d7fb.1746299135.git.code@khaugsbakk.name>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <2e41f0f0f0738418375f77146e4b10e0e562d7fb.1746299135.git.code@khaugsbakk.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 03/05/2025 à 21:13, kristofferhaugsbakk@fastmail.com a écrit :
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> 7b399322a2e (doc: apply new format to git-branch man page, 2025-03-19)
> updated the formatting for this doc to, among other things, use backtick
> for some elements.  In the process `è` was used by accident instead
> of backtick.
> 
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  Documentation/git-branch.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
> index 50a1e13e1f2..c0afddc424d 100644
> --- a/Documentation/git-branch.adoc
> +++ b/Documentation/git-branch.adoc
> @@ -373,7 +373,7 @@ $ git branch -D test                                    <2>
>  ------------
>  +
>  <1> Delete the remote-tracking branches "todo", "html" and "man". The next
> -    `git fetch` or `git pullè will create them again unless you configure them not to.
> +    `git fetch` or `git pull` will create them again unless you configure them not to.
>      See linkgit:git-fetch[1].
>  <2> Delete the "test" branch even if the "master" branch (or whichever branch
>      is currently checked out) does not have all commits from the test branch.

Thank you for spotting this one!
