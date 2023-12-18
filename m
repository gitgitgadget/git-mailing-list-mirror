Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961D13D0BD
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="oXQOt7aG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702896838; x=1703501638; i=johannes.schindelin@gmx.de;
	bh=KKQUTKKW6aLwPNQEuraKFS5EVDpuAzscBWsgwW2FsN0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=oXQOt7aGCDbFtw+UKm6Z93IA2AElyNzv4npgBNW0iDmF3qEtT3oxzaQjrsyY8oE5
	 yylvsyDaNS6wpg2QxogS7khs/K0Vcbyol8YaDfQeAEGpOofSRBlzYYJj9grVcNwyy
	 cZhQOC4ytHVNsHFxBGgYbwQnM/p7l5TAFj3lnSJEKP8JMz7f9cURoE/ngM42KCATr
	 unHvWVO0TtybF8V8NxFwA9+0uHZuvqTv0cHxzP5v4Dpyv4SNLGMlQ2BLfTuFWUmYF
	 pAmRj7TyuA2lmpjl0zFqZwg10guSdX0VTuzYAq5BLti5rqIRWSdd4CFhpNHc66+Jz
	 iZdWD+ovB6ztIF4Jww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.125]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsUv-1rWUkj3MGV-00HQ0A; Mon, 18
 Dec 2023 11:53:58 +0100
Date: Mon, 18 Dec 2023 11:53:57 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Michael Lohmann <mial.lohmann@gmail.com>
cc: git@vger.kernel.org, Michael Lohmann <mi.al.lohmann@gmail.com>
Subject: Re: Why is `revert` undocumented in interactive rebase todo help?
In-Reply-To: <20231218065313.55725-1-mi.al.lohmann@gmail.com>
Message-ID: <3e71666c-22a0-f52b-4025-dddb096e7e6c@gmx.de>
References: <20231218065313.55725-1-mi.al.lohmann@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+BY3jQQYHZCV01koIwDh0EAU2n8//cUuB6s8IKohVK5wCaRoc5Z
 E1FGiT9PVL95wZFG8+y7U8t/tevZJZ/GoEtYSOvH/XWx8Z16jjVfMdl+vN8I805yR7+rokl
 ZNWjVLfB3dRQ532NypaqYU16Qbf+ua+VWDSkgw7kbkLrIEkcG42tMA4JFav9rgHXtrEDSr8
 Pv1siSw6uHxyW7uoF1nRw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Flirvx/1r5s=;ekBzD/tTy4r3gcSFyzQ4HlAK7T5
 GYB+2b19EH6fWNdTD4VZMpH/cDQuESAc/NXXHf1aku9vuxMd9+IwnrDJ3foWKvgFOTVYOHOTD
 lYa94BJ1PoXVYzIoRrmrGc+jqixLGrMIAiXcvmEyw9SDw8GXdL4pKgHuSGJZJOsI5BMhDkC8g
 bJidK6WZMCI9eLu7Yp6XW7jXiASfcQtSWONMbNYiswEm7HNCZYsQwuChegg1mN1E6FQyK3pwc
 nzVwks78CeJjN15UkDPpSLeOuzmcmN53ZOgnClLFuK4U+K9gAsQMChypYxnQfELwGl1bJS9D9
 WXCatMrEJ3fR3RTdp+Y+bacioiLg8QNBRhZvTfpO4qelWoCKBin/BPdjqsMNLUfliPQ83TdZh
 DmLUU2IQtrodPWo1XgneAFypqBhwSTcnJuqbOnKYooTMzPCmfPNAI6ysUGmC52/a+Yj0TNh/J
 nMQDxa2Juiyawq1wMIcZL76eYulxevm1dQgU+X7HRbLFuoLrtdNDsQTVIpN4U3BLcc6gD05tQ
 6TaBH6v5Pv/WFRwyFWRRqqfHqJs0ACvNo1L7WmWzp9PXtFvRMePOflz9A/eF0b5uCImq9ORT2
 u9YI9nqXnXP570c3/a6ARN01ToUMET7C7Ag38EJsgug3W/wPLQkrpTyADjY9aT2vhY5tfvYYg
 zUoqsW/sLgp8P/zNUcQkVUKL50MHYgnZ+gnMGrxpprsaC7w42prTWufhAH9J+jA+s+5d018aG
 vSnBrdzOweizvL4ZAViUteARP/QdZ8TedVicqWku1213XiJe1JEyRY2s7vrRHiAT3WW+fVORz
 ENNLuLktYyboxg5M5ur8GRfuxdPklRrAYlPEuTg/CyugTXh9V3AFM/hu9+Igqnvtg4eyqEint
 OFrkn/rf918NExyqYytpLcIhffoML2ZktvevOJyhzAbSZRHfHrEeApmlJ0Imo2YDajkLptqYD
 olraOQ==

Hi Michael,

On Mon, 18 Dec 2023, Michael Lohmann wrote:

> I wanted to align rebase and revert/cherry-pick a bit more (for the
> latter I am currently finishing my patch for --show-current-patch and
> then looked into possibly implementing --edit-todo). To avoid code
> duplication I wanted to reuse the existing interactive-rebase code as
> much as possible and ended up at the todo script parsing in the
> sequencer. I was a bit surprised to find that the file could already
> handle the command `revert`, even though it isn't documented in
> `append_todo_help` of rebase-interactive.c - is that by choice or just
> missing documentation?

The reason that it is not documented, and that it has no single-letter
"short command", is that it is more of a historic accident than design
that interactive rebases support the "revert" command: In 004fefa754a4
(sequencer: completely revamp the "todo" script parsing, 2016-10-21), I
revamped sequencer's parsing of the "todo script", in preparation for
teaching it the trick to parse full-blown todo scripts of interactive
rebases in addition to parsing the (hitherto quite limited) `cherry-pick`
and `revert` "scripts", a trick that was completed with cca3be6ea15b
(Merge branch 'js/prepare-sequencer', 2016-10-27). These days, `git rebase
--interactive` uses that code to parse todo scripts.

Naturally, to be able to continue parsing the "revert scripts", the
`revert` command needed to be supported, and I never thought of disabling
it specifically for interactive rebases.

> Whenever I wanted to achieve this I used `break` and then manually did
> the revert, which obviously works fine, but it is much nicer to put the
> command in the todo file... (Now that I think about it I could also have
> done it with `exec`, but that is also not the nicest solution :D ).


Right. I often find myself adding commands like this one:

	x git revert -n <reverse-fixup> && git commit --amend --no-edit

to amend a commit with a reversal of another commit, most prominently when
I squashed a fixup into another commit than I had originally intended and
now need to fix that.

> The only other command not mentioned is `noop` which is obviously not
> too useful apart from distinguishing an empty list and aborting, so I
> totally understand it missing.

Correct, that one is intentionally not described, for the reasons you
described.

> Yes - in contrast to all the other options it does not have a single
> char notation (and 'r' is obviously already taken und 'u' for undo as
> well or 't' for the last letter), but why not show it in the list
> without it? Or maybe add 'v' for "reVert"?

Sure ;-)

Ciao,
Johannes
