Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF58F36C
	for <git@vger.kernel.org>; Sun, 24 Nov 2024 21:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732484516; cv=none; b=g3wjQG+aeotutidxgX5b9UOZr+2GmMI38nb7sElHXOcx68dvG8Wer27n6bKpU4rMd4hGTvBThUwT+3dgPTV1i/YIfJ3/P6r6+x7mIMirn0WzrPeZJgih+1TSaLdz+zDTXG4b4Rs9VHQkni2H2u1yH/aBrA3UrED5svevMM+n/GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732484516; c=relaxed/simple;
	bh=qiZa6S1LaWyqJnfBMFvjpSZy4SllLnnA+7CgLREwTQg=;
	h=MIME-version:Content-type:Date:Message-id:To:From:Subject:
	 References:In-reply-to; b=p3cJCSn6xaQsB1fwqKOPMgIWNMWFtG9DYN9aTPkfr2w7ZREEMSUAQzALwNVmvthDvtCJtVkeXC9Z8suZVRdKlt01VyCPgA6No7gSjDLE46rqpiQ/1lsF1QPkoWmblvouQV4vZ4mni680+JWJkHa8Yh4C73/Tr8FkzOqaCykHB4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=SyMyknFj; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="SyMyknFj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=it0/hNgVP9H24t3FOc7BGnUGzFdochPC/bVlS1+jNbg=;
 b=SyMyknFjrpl07GVNghBglfluQ1ha0EadZp/NqFFL0p5fczg4wsmcLHAcdw15Idxtyu0baXWaw4zW
   kRdqCnnbnFHVOpZGsgYwAMk2C5vZI4GPTzGzIvOvr7Ra5i9NcXbjhvvUe3enHZVech0qSfrIXE97
   p6byCDe0Kz6yVtVas7vDmrX/+rBPwn/99aVJmIIw/4ykZrraDo/OKbs7ijMA9sN2ljITgFNYw7Ns
   hGwnpNk8CNKHlU/T+UkP+z/oIZJgi2x+VrHhZ/hXTaBUsFP9SSXfjcsXB9HZ2AIUg+IMq2L2j+/Z
   7GjIG9LJKPkrmmgu3P/o0KERQtpJJH7bEc4pvA==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SNH00NX35LLH730@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sun, 24 Nov 2024 21:41:45 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Sun, 24 Nov 2024 22:41:23 +0100
Message-id: <D5UQHS9IV5N1.3IO1848Q1730B@ferdinandy.com>
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: Extending whitespace checks
References: <xmqqbjy5bc6m.fsf@gitster.g>
In-reply-to: <xmqqbjy5bc6m.fsf@gitster.g>
Reporting-Meta:
 AAEEhntTl+h45xwt23rOlO12H2i3RZN42Rohz08kWA97mbSPtZjVl9Y53p1lUyw9
 5iGpm4AFn+vyKQNWnN5Orrwzgx8pKS8IqMLBJvVMK55U0+07vx2lhvoL1MCRt5Rr
 0C+zCu6cuR2yDiEy+LmXEse5tElEjRRfS7AoDeV49DpEaq8LSo2GQhk5Q/BawvoN
 Ndee/yZ5vm2Ifp798UosiQPozpN8jW6pPiJN/bUT+Z2FT7h5GrqQkRzjcfYDuKzC
 codt+O2Qss7nfuu63BVp8RUxcXZehTr41MC0Lv6FpM0XnHf03PMYLSwGWBIY9gdC
 dI7ERrGMLAyqlN2miyCt4yn5RL3AXc1lLn1drnlLprNyuSb3OvD7GA5mhLzq8UUt
 W0WcqoBnxCP8oul6zQRfrBp3dy/YvYPEzTBT7Vxh6XdbXkHN9eADMQTw5kCncsC6
 lgfcVF9AxpPs43pTpzjv/g9bJEo3TaNEsImqeHQR12A4qRhzi6ylGAOw


On Sun Nov 24, 2024 at 03:25, Junio C Hamano <gitster@pobox.com> wrote:
> We have, via the attributes subsystem, a way to choose from a set of
> predefined whitespace rules so that "git diff" can notice that you
> are adding trailing whitespaces to your newly written lines, or you
> are indenting a newly introduced line in a Python script with a HT.
> This can be used, for example, in pre-commit hook to reject an
> attempt to introduce whitespace-damaging changes to the codebase.
>
> Which is great.
>
> I am wondering what we can do to add a different kind of checks to
> help file types with fixed format by extending the same mechanism,
> or the checks I have in mind are too different from the whitespace
> checks and shoehorning it into the existing mechanism does not make
> sense.  The particular check I have an immediate need for is for a
> filetype with lines, each has exactly 4 fields separated with HT in
> between, so the check would ask "does each line have exactly 3 HT on
> it?"  It would be extended to verify CSV files with fixed number of
> fields (but the validator needs to be aware of the quoting rules for
> comma in a value in fields).
>
> I guess the best I could do (outside Git) is
>
>  - write such a validator that can take one line of input and say
>    "this line comforms to the rule".
>
>  - add, via .gitattribute, my own attribute to allow me to mark
>    the files that these rules apply.  Git does not do anything
>    special for this attribute (remember, I said "outside Git").
>
>  - in pre-commit hook, run "git diff ':(attr:myattr)'" to grab
>    changes in these files with special formats, and have the
>    line-by-line validator (above) check the new lines.
>
> to make sure bad lines would not slip into the history, but it would
> be really nice if I can trigger the check as part of "git diff --check",
> which means it would be more ideal if we can do this "inside" Git.
>
> Perhaps we could introduce a mechansim that allows me to do the
> following:
>
>  - An attribute, like whitespace=3D..., specifies what line-validation
>    function to use to vet each new line introduced to a file with
>    the attribute.
>
>  - A line-validation function can be dynamically loaded/linked
>    (here, we'd need ".gitattribute specifies the logical meaning,
>    while .git/config and friends maps the 'logical meaning' to a
>    specific implementation suitable for the platform" separation,
>    similar to what we use for smudge/clean filters).  Perhaps this
>    would be a good testbed for use of dll, written even in a foreign
>    language like Rust?
>
>  - In the diff machinery, where a '+' line is checked for whitespace
>    anomalies in the existing code, add code to call the dynamically
>    loaded line-validation function when applicable.
>
>  - Profit?
>
> Hmm?

This might be a tangent, but since enhancing whitespace checking was mentio=
ned,
I'd thought I note here:  `git log --check` running in the CI did not catch=
 the
white space errors in this patch (see the last hunk):

https://lore.kernel.org/git/20241121225757.3877852-4-bence@ferdinandy.com/

although it would have been certainly nice. I'm not sure if --check could
already catch this actually, or if it would be easy/possible to have someth=
ing
general enough that does catch it.


Best,
Bence
