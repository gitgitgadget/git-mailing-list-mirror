Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1395234CE2
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 21:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="agcDkc6b"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECFA9D
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 14:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1697145307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJBwqkcEkURGTyms5VIABY6Sh6GCyin2H8r4DeY2Hi0=;
	b=agcDkc6bVsvvqFLp9WLYMUbPIiEEVHtIdMo5rfzkXpVk82ZdiXTRl+V5DzlQpX0OTS0IO7
	Jthy7AWk/2rYpBv0/jQewBeYcblkLiXwcmPEAje/otVx4Z0gg/2WiH/yaLYEg8B3tnKLBG
	8c48YJTihpjvsyY8NeiTGwkCu6iwaBpxsCfk1LTB93Pc4RB0XnTt5gEXHQg5k7Gf1iJ+Gf
	9n6Warsprgh+SkxajJTCmgR7WkCnj8Fz6IH3YxRjFZ9z3WXsLcV4NVT5wM8Dd3pOc2LO98
	GjFa5I98THwUCz1oYrMI8JQ0lWKPQE6MJ4TJoqS/WfxnO+w4NZs0ldn3lqhMYg==
Date: Thu, 12 Oct 2023 23:15:07 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: git@vger.kernel.org
Subject: Re: why does git set X in LESS env var?
In-Reply-To: <e1e187ca3d970c18e1a11d51ff93b6cb212bcbaa.camel@scientia.org>
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
 <xmqqa5sokdd3.fsf@gitster.g>
 <0c10c4b95f2a947a5d569a2c3d51fcb02b35e81d.camel@scientia.org>
 <eadc03fc56d530ea31790f8a4b47a16e@manjaro.org>
 <ec43820562198de078db7df54d0338edf1f333ea.camel@scientia.org>
 <6457310b8ca0e7d3b288a3bbbe264012@manjaro.org>
 <fbb3c2bf1c832f0f16cb913da6b862dd313359ef.camel@scientia.org>
 <ace230a469fabbbbceb38cc884a40b4c@manjaro.org>
 <8f3bec2752f4c2d3ebdd29d20910a4a94f75f608.camel@scientia.org>
 <23cc509bfb433e19c7683c97314e4ac8@manjaro.org>
 <2f3ef5568ed19ac5bdcd23f84ddfb13dc6901043.camel@scientia.org>
 <161b9584c6c9a004c01bda98cea4f1f8@manjaro.org>
 <e1e187ca3d970c18e1a11d51ff93b6cb212bcbaa.camel@scientia.org>
Message-ID: <31b6f4a2b88cc3a2cfa908f82f4f2302@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-12 22:23, Christoph Anton Mitterer wrote:
> On Thu, 2023-10-12 at 07:46 +0200, Dragan Simic wrote:
>> Let me repeat that the messed up output you're experiencing isn't 
>> normal
>> and has nothing to do with the arguments passed to less(1).  That's a
>> separate issue of the terminal emulator(s) you're using, or in issue 
>> of
>> your specific environment, and should be debugged and addressed as a
>> separate issue.
> 
> As I've told you before it happens at least in gnome-terminal (and thus
> presumably and VTE based terminal), xterm, xfce4-terminal and konsole
> (all current versions of Debian unstable)... with less as of Debian
> unstable as well as 643.
> 
> That affects at least on major distro, and there's a good chance that
> it affects any other distro based on Debian (*buntu, etc.).
> 
> I further tried on SLES 15 with both gnome-terminal 3.42.2 and xterm
> 330 as well as less 530.
> 
> Even tried with the terminal emulator started via env -i and only TERM
> set manually.
> 
> *All* cases affected by the same problem I've described before.
> 
> Same with the command you've used in your follow-up post, here a video
> of it in HD:
> https://youtu.be/MsxtQgrKM50

Ah, I can finally see what are you talking about...  Thank you very much 
for all the testing you've performed and for supplying this screen 
recording!  I can confirm that my environment is also affected, but for 
some reason I haven't observed it this way before.

Huh, that's really worrisome and I'm willing to help you with debugging 
and fixing this issue.  Please, let me perform some debugging and 
digging around, and I'll come back to you with some further insights,

>> To me, having inconsistent displaying of the short and long outputs
>> is simply not acceptable.
> 
> Which is fine - and as I've said: I personally also tend to prefer it
> like that - but even if the above would be just some bug (which however
> seems to affect all systems I could test on a short notice, except
> yours)... one can IMO still not generally say whether on or the other
> behaviour is generally accepted to be the better one.
> 
> Even if output may be just chopped of and thus ambiguously incomplete,
> some people may still prefer to have rather no output at all.

Those people, just as anyone else, can use $PAGER or $GIT_PAGER to 
configure the pagination the way they like it.  In the end, that's also 
what I do in my environment.

>> Perhaps something is wrong with your specific environment, because
>> I see no other reason for this issue.
> 
> Well may be, but seems unlikely from my PoV, given that I've now tested
> even on other distros and systems not under my control.
> 
> Anyway... I think this got a bit too off-topic here :-D

Well, yes and no.  This scrolling-related issue is obviously affecting 
numerous git users, which makes it quite relevant for git as a project.  
Of course, not directly relevant, but indirectly, yes.
