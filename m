Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4974CB3D
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 21:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772675; cv=none; b=B+xTudlVWooYanngUr9GGV52Y5vKWbSNkAZFOAsiR1e51fSAEWJ/iMbFUyfOJV9a4E4sW5KoyPEii5B3HpeOy3cbfihTSd5VRBSXz4k+aDXSGS24M/vMGMLrIcDmkRqSRUsUT5rpmhBdXTimgF3fujB6glVtoumYQ93/+K/zmjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772675; c=relaxed/simple;
	bh=0CorLJvfSfDhEDAtUAnyzAg1iA0FK/jBChgegJv7Mtw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=B+XpT+8NJIG9RAFUi49TiEzyrm0r5XXCGvUv1+xSeIISXYDF2/4gBTqQB/TLDuxXaLYscQTGw36Bbxn+jVVPvM5NpF495DFKrWmX7vkFJh7YrblycF6eRRIkH5UnaOsYsSd7OmWmLpgFHw1wn5CK6hVycOUIBtNwFpHJ1rnslmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=eHENbTr8; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="eHENbTr8"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1707772663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Yt3sNca/aJxVcwMvy71R0AagZAl0J/on5jIR2EKh0g=;
	b=eHENbTr8NiKK3XXIRF7boJpObrse6nYjoeJrDjUl6x/F7vdlXgdYwzxcRuol9hu3R+YNw+
	EOEOVDRMvQHPcfpbB+HsB4lACRzXkt1YOTzQ+RzfGiJWH8E62E7Ww3szF9FxPq2S0PDRhL
	wy4hSEmSHtbKzu6bR/rX5M5QOHF8sfnfMQKuIUrsooAruy+nT2tyeiNxxhmE+U7LO119Rl
	jS25QPWCxneEQIh8KGjy1kqIUUO3buwN9kQoa8cf2b1uKbWbA3me/5mOWd0nEG+Ob9zPZI
	xJ3tBithSdqoNHp0dXW7terT1CqUt4QzyaYY+/PoH1Ut0fX/Dt1PaQJjJLdYkw==
Date: Mon, 12 Feb 2024 22:17:43 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Tobias Boesch <tobias.boesch@googlemail.com>
Cc: Junio C Hamano <gitster@pobox.com>, "brian m. carlson"
 <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: git-gui desktop launcher
In-Reply-To: <eb122f205692ef4848e3adf792d67067bb52dd1c.camel@googlemail.com>
References: <beeab03c564e94861ab339d26c4e135b879a1ccd.camel@googlemail.com>
 <ZcFhNPRprfMqeRu1@tapette.crustytoothpaste.net> <xmqqle7xh1hc.fsf@gitster.g>
 <c6be276bfc3c219e1a0ca1619f56c165@manjaro.org>
 <eb122f205692ef4848e3adf792d67067bb52dd1c.camel@googlemail.com>
Message-ID: <79989c064af19f5a7ef036d7ee0caf02@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Tobias,

On 2024-02-12 21:35, Tobias Boesch wrote:
> On Tue, 2024-02-06 at 20:12 +0100, Dragan Simic wrote:
>> 
>> AFAICT, Linux distributions provided their own version(s) of the
>> .desktop file.  Perhaps the version provided by Fedora [1] could be
>> consulted, for example, to see what's already expected there, and
>> to provide parity in the version supplied by us.
>> 
>> [1] 
>> https://koji.fedoraproject.org/koji/fileinfo?rpmID=37302272&filename=git-gui.desktop
> 
> The file contents of the fedora desktop launcher is here:
> /home/tobiasb/.local/share/applications/git gui.desktop
> 
> It differs
> - in the program name. "Git GUI" instead of "Git Gui".

To me, "GUI" looks much better than "Gui" in a window title.

> - It leaves out the "portable" in the description ;-).

Perhaps Fedora is right there, because it refers to a version
packaged for a specific architecture.

> - I has no option to be launched from a location in file browser (open
> with...)

Maybe it could be better to take that approach and add the
"Open with..." feature later, just to play it safe.

> I will adopt mine to match their file as good as possible.

Good luck and have fun! :)
