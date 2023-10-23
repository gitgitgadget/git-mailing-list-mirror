Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BEA29A9
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="s3EHok03"
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D308D7C
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 07:34:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698071656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qd2KbLhy1nv9Brci3kdk5okvEkbxPuPfT+OCQJJqAUA=;
	b=s3EHok03w73fJdXzLVALEoanlSm+LJACB3P69HRaCssM1MkuEWz23ZhAaXbyn7dW0rxyNC
	4H2uQFBuH3taX3EfMKWbgi0L+FnrIr8tZrOrfVuYGmZj1j2r/05hLVleq2AbnC1RTPhENd
	JcJ0qy3fZj09BZfhavv/MctNw3aZvWqNNM5HS/S1Y62LPdtGO8sacfqVliS4SbebEpcsAN
	ZxyeWq7/GZo4NB3lRNTllBb+zCEXI10ihUF2ytrpYr/CN1arIeH/saO8WDhGvt8V0vQxU9
	qsPa3E4MnqBtKJCWLtxC9LppiWmkSk0385UFzhxJp8KxJl/nqYoRVuo83fXNQw==
Date: Mon, 23 Oct 2023 16:34:15 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Jacob Stopak <jacob@initialcommit.io>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
In-Reply-To: <ZTZQZhtTxvGT/s81@ugly>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <fd26df85661d554ced9d8e0445f75952@manjaro.org>
 <ZTL1wJIIK/5YWQK5.jacob@initialcommit.io>
 <d3bbe53c3b910f891c80465ea0c3f53f@manjaro.org>
 <ZTS4jfsU6oS6LW0u.jacob@initialcommit.io>
 <5fac8607a3c270e06fd610551d7403c7@manjaro.org> <ZTT5uI5Hm1+n0Agx@ugly>
 <58a6a25a7b2eb82c21d9b87143033cef@manjaro.org> <ZTZQZhtTxvGT/s81@ugly>
Message-ID: <bc55e29274da0d8059a8cd4383aa1b22@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-23 12:52, Oswald Buddenhagen wrote:
> On Sun, Oct 22, 2023 at 02:55:05PM +0200, Dragan Simic wrote:
>> Oh, that's awesome and I'm really happy to be wrong with my broad
>> classification of VCS users.  However, I still need to be convinced
>> further, and I'd assign your example as an exception to the rules,
> 
> i don't see myself as exceptional at all in that regard.
> in fact, your second user group seems like unicorns, and the first
> like a disparaging attitude from an elitist. in reality, users lie on
> a spectrum of willingness to engage with the details of the tools they
> use, and that willingness is circumstantial. a tool that is
> forthcoming with information has a higher chance of being actively
> engaged.

Actually, I see myself as some kind of a slave worker who just keeps 
typing on his keyboard and helps the elite (i.e. the "normal people") to 
enjoy their lives.  In other words, my viewpoint is totally opposite of 
how you perceived it.

>> and because you use the command line a lot.
>> 
> in my experience, this isn't uncommon for users of "discrete" vcs'es
> at all, even if they aren't too interested in the details. they just
> copy "magic incantations" from stackoverflow, etc. - disgusting,
> right? ;-)

Good point.  Various commands are often simply copied and pasted with 
little understanding.  I guess that makes people content, as one of 
their life choices.  I can respect that.

>> I also ask myself why would I use git-gui or any other GUI utility?
>> To me, clicking on something that represents a file is often simply
>> wrong.
> 
> that makes you an outlier. most people find point-and-click
> interaction rather intuitive and significantly more efficient than
> encoding their intent into character sequences.

Well, I guess I'm different.  As I already wrote above, I see myself as 
some kind of a "slave worker" who helps in enabling others (i.e. the 
"elite") to do whatever they want.

> you should however consider whether your preferences are a good
> default for the wider audience, even within the context of the command
> line.

Actually, some of my own preferences for my environment, when it comes 
to the git configuration, are not the defaults.

> i for one think that it would be a perfectly valid experiment to go
> all-in and beyond with jacob's proposal - _and make it the default_
> (when the output is a tty). more advanced users who feel annoyed would
> be expected to opt out of it via configuration, as they are for the
> advice messages. because it's really the same idea, only thought
> bigger.

I'd never support that, FWIW.
