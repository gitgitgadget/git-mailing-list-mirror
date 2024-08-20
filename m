Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EE818E35A
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 20:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724184953; cv=none; b=bVGaX2g6kruJHOjSzEUnJu7Z5Ig6NcPKjHgfwYbidw4dNXnQ0xEbFKUEkxyyJbEBfuhJJeOhJFcouOWYY8dwu1D1qkoVsME9okbz1Xk5tCbvEHLiYDPZXSKh25oLog8+sATv0wGR9XowvJH0sh4PvNJvWkmmCiKnzr6qKklzN2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724184953; c=relaxed/simple;
	bh=ABA3BQEbFRB8F72FKxUoWaC0v6yolvwxgzQ7ESG0hj8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fseJIqBxZW2aZUg5ieRjmvv8ZFPaUth0UTBztLd2NxGFS1kvHh/CZ59VNSzKr0uTOkIM/NKvo4xfoM8TyxxLLof/+xe+MaAGNo+u0Sl2h/QiOJDfH5N4TcTyk+GITQaegreouLXOTnHY/rbNt+3YNM3fCeC6D9ikYr7qQsfhVyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=nv37CFYV; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="nv37CFYV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1724184944; x=1724789744;
	i=johannes.schindelin@gmx.de;
	bh=gwl21SE+7sBP30+YJ3Qazl+xW1Ufn5BJGUcsMFZ7wNY=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nv37CFYVwOUlk9whC+rVa6iDp/CdPeeBvuiCIgEkFR9N9xHybjjKKW6weqXvBd7Y
	 Y06enJLAwNHNqYw1ZPrs5TPQ6aSCwcMCTwvuE+ugPmthyDW4jNaH+Jhc/LRoaIlhW
	 fpMLk4cv2nRF2WHjnNk84m++JT7VFsKnhAVcKWT/8mRV0ukjoJvaY/BboP4I0nhNF
	 jG5ogTmCfAiWjVEOJVf0HupPeQdeDMpFchv+6GemggjJDA4TYqoDbPn56gQV8JNBu
	 CXzNKBnR4zT3a6jI8gb7MfSpLzW0oHK/A2MWAS4KWYQywPjwb9c6ViAy22nnVW6B1
	 H4RYVYnbEbS7twjQkQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.249]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkYbu-1sHa6Y0hzy-00nPSA; Tue, 20
 Aug 2024 22:15:44 +0200
Date: Tue, 20 Aug 2024 22:15:43 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 0/2] Update the win+VS build definition
In-Reply-To: <xmqqv7zvb4mu.fsf@gitster.g>
Message-ID: <ab765f95-1208-fa77-01a7-2dd4f5eea90d@gmx.de>
References: <pull.1775.git.1724164270.gitgitgadget@gmail.com> <xmqqv7zvb4mu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wl7cPgFAEhFzKXAmdPbLw15IGmWjD2J/d4k/7V7qVE1/8JpwbKW
 UnMK8V9aq2fG23/DF0Sv7PVKjqHhSlriEyk/Nclr3hpyc0rOePfTg8z6QCogjW5FJklxsid
 b2pQhzza3XbOkKRhgadvUUphe8BfaczWNY+wKPXKh0CDZ7AZAnMzn9vSzGcHjNqZDNOdDS4
 y+AAXua9HMGTdjGzyoFYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Kua0UNgDZqI=;xgJMy8TNFzHS0DctdYli1at7hn5
 TQj3XKPznxgqOygHj/42TCnWOc6CUySJT9E/IeD83CO9Sb+ccgpUl0OmZtsxdLjfvgN+TakwS
 baqAqI+xeq1r6a8wVgHpMvUA0cjdVCDa2Y8KS6F6vFpkCvfjm08anlvuxN8otmXYEJbsVfu37
 MKU+duzcDUbnpR1wpcJCC6uO7QIZ4hlqtRgDZuObBc14nb95tX5xWfcugF8uXiz8NmUzDkQZm
 AI7l3TbT2NaYJS1wYps8CfSJTYgi96eqi/aMMCekAEsYfJGT3YApB9OxCNM8e675Ttur14zZz
 YUwZl2xbtG++EqAWWkWK4IqH+qCp2WMFZ2DfH5H4d2VtfZCsy8yHZuJ+qHDufEbNAUkO3FEyC
 6/fUQ+UFhFA5hbbY5WvQZRV+9sgiHdoaaqyIrF8hsbT+I8qLxFzC+jhmk7gDzF14AM+hnPTfb
 6n+x912YQos/zmPpJWc0tiFLaqsXoIAgP1ngiVF5W7snfuB8NdjhnviaHgOrXB3HCEF1MQghi
 BkC1gF5A60mRazHus6yDByWxrKZ+pzCNT5LsM0qaYlup0kdq8m7ZeS9QeEtV2Y6rzkJ3UJoEm
 shSke3DNZZXwyoiB+J0TAp2IbK2X8vKqpD5pIbThYl06JX4CeRbW8T9UGo6AZJ1s+S0uWFJ2T
 lTMsDAPhyQ2YJZ6a+KoPSet23CYFd0icIkHFaLMT/Q6l9wZv/VMsZoKF7jVenCWfNED7YkDLc
 W8lyVTNuu32ixUT9RQDl2UUjzvbCZ+p8wUz1QeBxLtBLAGl91IqEtaTSmnhEIU+u+n0/wbLH8
 W2fvJBbMG5YcwMJBjBr0e1uA==
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 20 Aug 2024, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > These two patches have been in Git for Windows' fork for quite a while=
.
> >
> > While the win+VS builds are not run in Git's CI builds, it is still a =
good
> > idea to upstream these changes.
> >
> > Johannes Schindelin (2):
> >   ci: bump microsoft/setup-msbuild from v1 to v2
> >   ci(win+VS): download the vcpkg artifacts using a dedicated GitHub
> >     Action
> >
> >  .github/workflows/main.yml | 14 +++++---------
> >  1 file changed, 5 insertions(+), 9 deletions(-)
>
> Thanks.
>
> Do you mind if I applied these directly to 'maint' and merged the
> result upwards?

I concur that this is a good idea.

Thank you,
Johannes
