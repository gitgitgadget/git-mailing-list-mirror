Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3309C12B176
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707206788; cv=none; b=huKC5KiQieh0I7tG1w9+O61WOjzXaycahVEnFzwIPVQBTyAgu/zuKTzb/DNwMIdASVnvG6BQWjRLFjE1C1sVg9fNF8dWN1HWucSxQ3AYzZJAhcEZEP6t1LvKo/zsB/T0qHD+F2stq8DAznNva7LNrd5HpNw9x4yK7grMpcs/opk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707206788; c=relaxed/simple;
	bh=rUVLpUgaLQP+8n81JNcJkcuBOz762uiGWnQUJFsrhuA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=irB2G9lvLuym/McByQMkEcErza7y2RnMAuX1b8O54Fo5YkyZ+0HwEowBqZkJpiFYcmYhrRQ1XOXKmuWaR6wfbtqRSBJmJPvyLn6u+kaa9F675INIP9PILBrHGjB+AlJrWysfZC59K4J56/ZoxT1ToYSxe4InJ8U1ZANEmFxppIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=jCay+oJQ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="jCay+oJQ"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1707206782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cBWtNTReWRypAGaIMNPbxemxtwTBsI4q+eFtAxt4TRs=;
	b=jCay+oJQLH99NNqyXCVGJf7FDnigq5/GOu3A5rLv7A0YuvSa61VNWgwrNP/ObiUgpmy9bv
	pVyhXg5AvG/cBWMeIX0kl+p2ELfr0Gb/jRaduyh3i3oDVqPJozJCocNdx54pBrcxPWZI4l
	XumDfWn6I3oAiBU8kprLJF7TIIYs1TvW/rJ5/v7ef2IQSHCbV4kilstvHMUwI98nfHlPFj
	xxsdr4cvfGFNnHTJG6OgkscMwbroVdngZPcylinU+bs5P7FUIBAh/PN1MrQccJCYnozw/U
	zPLjybFb5o0V8FYFTSPLT8VunRxMClxztuQ3AM6xeoMGIobFlbq0GWQsMNxo9w==
Date: Tue, 06 Feb 2024 09:06:22 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Hans Meiser <brille1@hotmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
 rsbecker@nexbridge.com, 'Sergey Organov' <sorganov@gmail.com>,
 git@vger.kernel.org
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
In-Reply-To: <DB9P195MB213080E6DD9ECA0EE3D2B491E2462@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <877cjm53bf.fsf@osv.gnss.ru> <008b01da55eb$9f3c36d0$ddb4a470$@nexbridge.com>
 <20240202161643.GD119530@mit.edu> <xmqq5xz6sn5i.fsf@gitster.g>
 <20240202212809.GA36616@mit.edu>
 <DB9P195MB213080E6DD9ECA0EE3D2B491E2462@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
Message-ID: <aca58f5d44d48f98b464e6c4a8d637fe@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Hans,

On 2024-02-06 08:22, Hans Meiser wrote:
>> Please, keep in mind that not everyone lives in a web browser and
>> loves to click around.  Some people simply prefer to use the CLI
>> utilities and to press the keys on their keyboards, and are very
>> efficient while doing that.
> 
> You are aware of the fact that all these Git collaboration websites
> are providing a REST interface? So, you are free to access any
> function by means of CLI?

Perhaps I wasn't clear enough, so please allow me to clarify a bit.

To me, it isn't just about using the CLI or TUI utilities.  It's
actually about using standard CLI/TUI utilities, such as using git
directly, instead of using some specialized CLI/TUI utilities that
are made to interact with a forge in a forge-specific way.

Perhaps you'll ask why I find using a forge such a bad thing, so
I'll try to provide an answer in advance.

Git is a widespread, standard system of utilities that isn't backed
by some company that sees its profit as the main goal.  On the other
hand, most forges are backed by a company, and as we know, companies
don't last forever, and they often pivot due to business decisions.
What we don't want is to tie the project into something that isn't
expected to virtually last forever.

It's similar to the concept of bit rot.  A lot of data is poured
into something and it slowly starts to degrade over time.  Though,
in the case of a forge becoming no longer available it wouldn't be
a gradual decay, but an abrupt disruption that would make all the
data unavailable and unusable.  Of course, the data perhaps can be
exported from a forge in some format, including the discussions,
but who's going to sift through years worth of such data and make
it usable through some other interface or in some other format?
Frankly, I wouldn't see that happening.

On the other hand, discussion in form of mailing lists aren't tied
to anything, the underlying data format has been around for decades,
and the raw data can be accessed by any editor or viewer, such as
less(1).  It isn't tied to anything.

>> As a Linux kernel subsystem maintainer, I am super grateful for those
>> who do code reviews and those who work test regressions, because in
>> general, that which doesn't get done by other developers ends up
>> getting done by the maintainers and project leads if it's going to
>> happen at all.
>> 
>> When it comes to requests like "you should migrate the project to use
>> some forge web site, because we can't be bothered to use e-mail, and
>> web interfaces are the new hotness", the entitlement that comes from
>> that request (which is in the subject line of this thread), can
>> sometimes be a bit frustrating.
>> 
>> Going back to the original topic of this thread, my personal
>> experience has been that the *vest* percentage of pull requests that I
>> get from github tend to be drive-by pull requests that are very low
>> quality, especially compared to those that I get via the mailing list.
>> So making a change to use a forge which might result in a larger
>> number of lower quality code contributions, when code review bandwidth
>> might be more of a bottlenck, might not be as appealing as some might
>> think.
> 
> Again, you are aware of the fact that Git collaboration websites
> provide a powerful user rights management?
> (https://docs.gitlab.com/ee/user/permissions.html
> https://docs.github.com/en/organizations/managing-user-access-to-your-organizations-repositories/managing-repository-roles/repository-roles-for-an-organization)
> 
> Using Git collaboration websites you can easily control and filter who
> will be contributing. And you are able to focus on issues and filter
> out spammers. It's quite the contrary of of what you have now with
> your mailing list. A vanilla student from the "axis of evil" could
> bomb your mailing list in a snap by just registering a dozen new
> e-mail accounts and writing a script that bloated your mailing list.
> And you cannot thwart that at all.

I don't remember such cases.  It doesn't mean something like that will
never happen, though.  Also, pretty much anyone can create dozens of
fake accounts on a forge and do malicious things.

Please note that creating an account of any kind is often unacceptable
to many people.  I was a bit surprised to discover that.

> With your mailing list approach you don't have ANY sort of gateway to
> keep away spam or "low quality" contributions other by means of the
> intrinsic clumsiness and intricateness of a mailing list. After having
> subscribed to your mailing list, my e-mail spam rate immediately
> increased significantly.

You must be having bad luck for some reason.  Knocking on wood,
I've received zero spam emails directed to my email address since
subscribing to the list.

> Again, on Git collaboration websites you can hide your personal access
> information and focus on your repository tasks rather than wasting
> your time on cumbersome additional and unneccessary work.

If you ask me, one's identity shouldn't be hidden when one willingly
contributes to a public project.  Taking part in the discussions is
also a way of contributing.

> I'm getting the impression that you didn't yet seriously investigate
> on the features these Git collaboration websites provide.
> 
> Let me finish this thread from my side now. I suggested a way to
> improve your daily business by employing tools that have been
> established and proven to raise code and documentation quality and
> that will allow you to focus on important tasks rather than wasting
> time on an old fashioned workflow. Well, it's up to you now to decide
> whether to stick here or to migrate.

As I noted already, these days it's expected too much that some
utilities will do the programmer's work.  Also, being unable to
follow a moderately busy mailing list, such as the git's, may also
show that one needs to improve their own skills in some areas.

In the case of high-volume mailing lists, I admit that things can
be different and much harder to handle.  That's why I plan to work
on extending mlmmj to support muting and unmuting threads. [1]

[1] 
https://lore.kernel.org/git/93be64af474b228e914a4c39443b5a9c@manjaro.org/
