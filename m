Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D45C419FB2
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 21:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787346908; cv=none; b=tRpxfX+NTR0dmzDl4TWU54djawM9MaTdsDf4DAEe5N9XnLNBuS/dn7az7lSKDF4fjRXdNk7XQ2c+VFcpkMFcFfYiIOr+Ojd7/LEcc8SeWcMxGXiOc00CMGBThjT36npXr8Mvlw4oHiU1NLi0kKoA3tRIXWaSk4tTw1SHqG0yBsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787346908; c=relaxed/simple;
	bh=hKdkajLztNgGHITCXCDoHEr0N1tN2ZRFYYvIugl7sFQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=OdfSskiAt8o96JBOoiEBj5p9j6BX4OO1HdHAJEOOYlEEyEuRy/V1Txc5tsANd1XVoNcPRSTpUERjbom5a1V9La2AB3+Jb3wwlGd1JSYnXxI8Cdd93Q2oxiT0JZj2O8XGwpUe5R1cY8egte86ATlImT/ySHvsoEF+hDyX8VMhJ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=aK89yKr/; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="aK89yKr/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787346896;
	bh=EHQFAaNoD2ziR+wL0AlPTOtdBkQCEuzjSudGeJ6urtk=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=aK89yKr/KVLc0x32R5+avd55mrsWnb4hL5AS7IVPbWUwOJHE6rgk9mTbCTBbBwdte
	 mNjUqgCTBcHl+ErYUoTVJydZgcZnNa9jYrcuTZP5ENeNStVamaQkTRz7hUVVT7qE47
	 lJXQZ/9hCgwH/VsNs1t20QTMf3LpcMjuQ74GGJjM=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4hRY3h2Qs7zGp8v;
	Fri, 21 Aug 2026 21:14:56 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4hRY3g59tMzGp8d;
	Fri, 21 Aug 2026 21:14:55 +0000 (UTC)
Date: Fri, 21 Aug 2026 22:14:55 +0100
From: Bradley Morgan <include@grrlz.net>
To: skybuck2000@hotmail.com
CC: git@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_AI_Textconv_filter_misconfiguration_on_Windows_leads_t?=
 =?US-ASCII?Q?o_silent_corruption_of_diff_o?=
 =?US-ASCII?Q?utput_=28ongoing_investigation=29?=
In-Reply-To: <AM0PR02MB44501AFB0A97E2E097B8795AB3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com>
Message-ID: <26321C84-5D6C-489E-9CE1-03F55BAC697A@grrlz.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 11 August 2026 05:26:22 BST, Skybuck Flying <skybuck2000@hotmail.com>
wrote:
>Faulting application name: WindowsTerminal.exe, version: 1.24.2605.12001,
>time stamp: 0x6a03a6ca
>Faulting module name: Microsoft.Terminal.Control.dll, version:
>1.24.2605.12001, time stamp: 0x6a03a3a2
>Exception code: 0xc0000005
>Fault offset: 0x000000000002c924
>Faulting process id: 0x0x5E3C
>Faulting application start time: 0x0x1DD2916AA80F175
>Faulting application path: C:\Program
>Files\WindowsApps\Microsoft.WindowsTerminal_1.24.11321.0_x64__8wekyb3d8bbwe\WindowsTerminal.exe
>Faulting module path: C:\Program
>Files\WindowsApps\Microsoft.WindowsTerminal_1.24.11321.0_x64__8wekyb3d8bbwe\Microsoft.Terminal.Control.dll
>Report Id: cd357657-4241-4a05-95d5-54ad0292fa24
>Faulting package full name:
>Microsoft.WindowsTerminal_1.24.11321.0_x64__8wekyb3d8bbwe
>Faulting package-relative application ID: App
>
>As if this day wasn't bad enough yet, windows terminal also crashes,
>trying to copy & paste the command line used to actually fix git.
>
>Many copy & pastes were hurt this day. uBlock origin also started fucking
>around with copy & paste functionality, blocking it.
>
>Hit the big logo which looks like a power icon to turn it off... or read
>this horrible dev issue thread, which contains some more manuals how to
>add a by-pass/circumment/exclude filter for deepseek website:
>
>https://github.com/vitelabs/go-vite/issues/656
>
>It's good to read this anyway, to see how SHITTY your git actually is, it
>orginally started with trying to apply your git diff output via the patch
>feature which miserably failed !
>
>None the less a branch was created anyway, with commits, which is a more
>proper way to do it...
>
>I can't believe you linux faggots used patches all this time, it has
>rarely worked for me, your parsers are total shit. You need to start using
>AI and first SPEC THE HELL OUT OF IT by using every AI in the book:
>deepseek v4, gemini 3.6, grok 4.x, chatgpt 5.x, meta.ai spark 1.1 
>
>Only then will your software improve.
>
>Anyway, thankfully the entire browser didn't crash yet, I should be able
>to at least copy & paste the instruction out of there:
>
>git config --global diff.lfclean.textconv "sed -e s/\\r//"
>
>
>TO ALL SOFTWARE DEVELOPERS AND CODE FAG BUNNIES ALL OVER THE WORLD:
>
>TEST YOUR COPY & PASTE FUNCTIONALITY 1000X BETTER
>
>TEST YOUR SELECT FUNCTIONALITY 1000X BETTER
>
>TEST YOUR DRAG & DROP FUNCTIONALITY 1000X BETTER
>
>I RUN INTO THESE KINDS OF MALFUNCTIONS
>
>ALL
>
>THE
>
>TIME.
>
>BLOODY
>
>FUCKING
>
>ANNOYING
>
>BYE
>
>FOR
>
>NOW
>
>I 
>
>HOPE
>
>I 
>
>GET
>
>BANNED
>
>SO 
>
>I
>
>CAN
>
>PUT
>
>SHITTY
>
>LINUX
>
>SOFTWARE
>
>TO
>
>REST
>
>MAYBE
>
>I MAKE A NICE PARODY USING:
>
>"SOUND OF SILENCE" BY THAT WELL KNOWN GANG OF MUSIC ARTISTS
>
>TUT TUT TUT TUT TUT TUTUT TUTUT TUTUT
>
>OH YEAH I REMEMBER NOW:
>
>
>"SHOUT !"
>
>"SHOUT !"
>
>"THROW LINUX OUT !"
>
>"THROW THAT GARBAGE OF THE PLANET"
>
>"COME ON"
>
>"JUST THROW IT OUT"
>
>"COME ON !"
>
>"AND IF I"
>
>"COULD JUST NOT HAVE TO DEAL WITH LINUX"
>
>"I COULD JUST CODE FINE"
>
>"AND I WOULDN'T BE WASTING MY TIME !"
>
>"I'D BE CODING FINE !"
>
>"AND NOT BE WASTING MY TIME"
>
>"SHOUT ! SHOUT ! THROW GIT AND LINUX OUT !"
>
>"COME ON !"
>
>"GET RID OF THAT GARBAGE !"
>
>"COME ON !"
>
>BYE FOR NOW,
>  SKYBUCK.
>
>P.S.: DON'T DEVELOP YOUR OWN OS, IF YOU CAN'T FOLLOW SOME FUCKING SIMPLY
>STANDARDS LIKE CARRIAGE RETURN AND NEWLINE
>
>BY FUCKERS.
>

uhh, you don't need to be this mad.
its not particularly linuxes fault


Thanks!
