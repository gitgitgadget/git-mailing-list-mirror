Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259D6757F6
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 23:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712703791; cv=none; b=cRuldbeMuKKMoIHCOyt/r68n18qtcBrw7WJWzy6z9+zL5tQL1d91mJvf1/KK2Gj8W2ssTQCxgLYbgDExDc3TE0Ewy7ExBeZ4bko/c9DVnXxIqJYTUh5AIXqdbuySjy10UlnvR4UWFocrLc+VoYExUZW35QVs21rfMbBI81Yi488=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712703791; c=relaxed/simple;
	bh=vjfUPeGHsqGmcc9r3cqcYN3dX4SRISgEOedufweGBS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tYdqk4v2xD+hPRL7iFOeSO4jntZfP6Y+COhQuZ0VLZoF2g6uAN65FFFEcCT8FzHIkAUQ57X/k04eJZ5HgB23148PNjAXFDNzTxWw7A19nL3yygDMTEZR2e76wwrZcGvKpzEgjlKAPOfckxzOgQ2L/C7lUE+bqpLXp0+i/bP1JVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ULhsGXIq; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ULhsGXIq"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 99A992939C;
	Tue,  9 Apr 2024 19:03:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vjfUPeGHsqGmcc9r3cqcYN3dX4SRISgEOedufw
	eGBS4=; b=ULhsGXIqtxxN4GsoXGFOJr85mVlPtFJ1sy3GE7cPGsYOAW1C2V5wrr
	nk42/ouFTra9RytUcRzktC5FzWsh0cM7tdMnC+Qg8GcdHETOOrw3Aq/Q9LI/LAGo
	vgwCzLzhGfgmNZcoExmipfXuDXCIlT8re7dH9ISVf2JIMsexJis4k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7B2852939B;
	Tue,  9 Apr 2024 19:03:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 01AD929398;
	Tue,  9 Apr 2024 19:02:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Jonathan Tan <jonathantanmy@google.com>,  Emily Shaffer
 <nasamuffin@google.com>,  Patrick Steinhardt <ps@pks.im>,  Matthieu Moy
 <git@matthieu-moy.fr>
Subject: Re: [PATCH v3 1/8] MyFirstContribution: mention
 contrib/contacts/git-contacts
In-Reply-To: <owlyil0qrxev.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Tue, 09 Apr 2024 15:20:08 -0700")
References: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
	<pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
	<1f65dc5ba3ded5b90ed929aa3884574e8b26cd9b.1712699815.git.gitgitgadget@gmail.com>
	<owlyil0qrxev.fsf@fine.c.googlers.com>
Date: Tue, 09 Apr 2024 16:02:58 -0700
Message-ID: <xmqq8r1m16n1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4FA4C256-F6C5-11EE-9D4A-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Linus Arver <linusa@google.com> writes:

>> +NOTE: If you're not sure who to CC, use `contrib/contacts/git-contacts` to get a
>> +list of reviewers you should include in the CC list. In addition, you can do
>
> I just realized that I could also do s/should/could here, but I assume
> you'd prefer to modify in-place instead of me rerolling for a v4 just
> for this change. Thanks.

We do not even know if there are other things people find issues
with in this iteration, so it is a bit too early to say that.  In a
case like this, if you do not feel so strongly about it (which I am
guessing from your "I could also") either way, staying mum would
probably be the best.  If you feel more strongly than that, saying
"I plan to update 'should' -> 'could' if I end up doing v4" right
now would be fine.  Then when there are other things you'd need to
update after waiting for others' input, you could keep that promise.
If there are no other things you'd want to update after waiting,
that would be the good time to say "Here is a fixup! commit; squash
into topic X. There is no other changes".

For now, I inserted this extra commit between [1/8] and [2/8].
Thanks.

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 00f4c63cb9..bb7e4174e8 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1116,8 +1116,8 @@ $ git send-email --to=target@example.com psuh/*.patch
 NOTE: Check `git help send-email` for some other options which you may find
 valuable, such as changing the Reply-to address or adding more CC and BCC lines.
 
-NOTE: If you're not sure who to CC, use `contrib/contacts/git-contacts` to get a
-list of reviewers you should include in the CC list. In addition, you can do
+NOTE: If you're not sure whom to CC, running `contrib/contacts/git-contacts`
+can list potential reviewers to put on the CC list. In addition, you can do
 `git send-email --cc-cmd='git contacts' feature/*.patch` to automatically pass
 this list of emails to `send-email`.
 


