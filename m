Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0AD15D1
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="uw1u2O8A"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A1E469B
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 05:39:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1699796351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Huzbi2jQr6D6GlKcCRYjcHxsvnNpXV+lMz041L640Bs=;
	b=uw1u2O8AX56aQj5/WUgoqcv+tzUFVenH6rLShCZwHXKm0xvz1WiU7rZtgekFs+yEMZIT58
	c9OuTNEv1YJ9KCGzILyxi65u/UJ0BtXJIkoj8/i3Bnf5wqCl+v9FBRpcd4G0fzr3fVYatI
	QS8gywS/VRH3DqE0VeNuVzGz9eKTvaQbNkxngU/+fHJBSwqXH3Zi+oNftIBztCacUm1YJa
	+YVQC5255lLj46rFESIOkgjcy54vEYP0mBoczOk55+iBsveMH4fasgKh7U8uVKC9d2kTTp
	wxOm1uD0ifSu2dMOBERyW2TB2ecua/AIxa5WC3/ufRMW03CQ0W6kY68gvLdzsg==
Date: Sun, 12 Nov 2023 14:39:10 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?F=C3=A9lix_Pi=C3=A9dallu?= <felix@piedallu.me>
Cc: git@vger.kernel.org
Subject: Re: Declutter the home directory
In-Reply-To: <cb89d863-12d4-412b-a25b-9eedce996708@piedallu.me>
References: <cb89d863-12d4-412b-a25b-9eedce996708@piedallu.me>
Message-ID: <4023bded47a39e10f28e30efad9c34d4@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-11-12 13:10, Félix Piédallu wrote:
> ## Default to XDG paths instead of home directory
> 
> It would just swap the priority of the two possible paths. It would
> also only impact new installations as, if ~/.gitconfig exists, it
> would keep being used.

Quite frankly, some configuration files should remain in $HOME, and 
~/.gitconfig is IMHO one of those.  It's used very frequently, not only 
directly, but also while discussing or explaining various configuration 
features or issues.  Thus, moving it somewhere else would only make 
things more complicated and worse.

IOW, I think that the order/priority shouldn't be changed.
