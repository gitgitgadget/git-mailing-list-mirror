Received: from mail-106103.protonmail.ch (mail-106103.protonmail.ch [79.135.106.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF01309F1B
	for <git@vger.kernel.org>; Sat,  2 May 2026 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777714477; cv=none; b=D4pme/9IhQJCukUEoeaVwY4HNZjf4EXqmlfNg01T6VVNSfbxQpsLrLSA/8nfBVGbGB/SAUFtWaVgVbD9W4vUA4pqQQ91PUIJtJTnzSixtSp/PCdWfp2mY4J+2oPGYRmsiA9m4vRS67tQ67rsmF79R8G9hAJrIVq9aQQcalyVo7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777714477; c=relaxed/simple;
	bh=wPBawU9uPujYOEMQaaY++4EBHbEpnSmu0ebfmlCGcww=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dxXx8z5Fd5gFemJzgnZT6HgYpiBx4eumGYFSBVMDgkYN5ZjXu3QhZiIapxCNG2XvGWq5W4qQHM/JHB9tdPt+Qu8jQhs/p35rSkPM8aXb8od7sZTle0QfSExbsOU7q0iuMmb9kkTAnlEuyxVWh8zjUZb8kaNVU5V9IugZQ7ahwj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=EMn3VwKp; arc=none smtp.client-ip=79.135.106.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="EMn3VwKp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1777714463; x=1777973663;
	bh=UTZTLFcmEOpVLFBYOoJsa0HQu5qdXeU7Ytx329CwZVE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EMn3VwKpFSy4BEzoN7MVPaQ3wTjXDXJQ8DJLMeM1eXVM2PE4B3Vi3CTiZv8E05AfR
	 AW46ssj13IJDhhcROiqoFfGoztJh4pItvN0x4SQdy9cQWZhur1F6pbQpwYntyBqIX0
	 Tqdz2vaahCnpSCo+kKl1zmngss7Qlv3hQNYLau/BKKk4XJvQzv01nPPvHQIMIslM+3
	 0TIbVHYaNzTmGqumneucx+P3IWzLQ63AG/xl2flpNM5iqCJuXuw3sNq5oZv/Tpg03d
	 a8iJ2rRSKZBM1w8isBjq/5AmFTDiU0Igu0T3tYrGrg6U/Qe7eIcZZsOrS4fZTQI+sk
	 bJQFwkGTt1aVw==
Date: Sat, 02 May 2026 09:34:18 +0000
To: "phillip.wood@dunelm.org.uk" <phillip.wood@dunelm.org.uk>, "chris.torek@gmail.com" <chris.torek@gmail.com>
From: "sebastien.stettler" <sebastien.stettler@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, "j6t@kdbg.org" <j6t@kdbg.org>
Subject: Re: git rename/moved status unreliable in ruby
Message-ID: <IC7a4NnSKMdvXlVyaSDYEtU7iRlKdJGzCwrXNCFKrtFfnBJTMrwY522rHF8PfzYxFs43huo0KFGrqB6f4IQjmvYi2B8Ehh0cwfjHHOYW_RU=@proton.me>
In-Reply-To: <CAPx1Gvd_VEWHrBWtUjNeWZ+wfmsAOTamKmL6fhBSQi=MbmXRcw@mail.gmail.com>
References: <OsOzcjEwvHCQSghLE8LD_wHb_jDlil9I88OUuhpiRONnVd1o9p3gStbK1mx4q7OwY3ePtbZO-BBgTNOCeJ2DMyvBsdlMhRmDrTP894KP5xo=@proton.me> <CAPx1Gvd_VEWHrBWtUjNeWZ+wfmsAOTamKmL6fhBSQi=MbmXRcw@mail.gmail.com>
Feedback-ID: 67513414:user:proton
X-Pm-Message-ID: 9859dce7aba406c817451a0620efdfcdf8eb5f79
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for all the responses and thoughts thus far.

> Which means that git sees that every line has changed because the
> indentation has changed. If you want git to realize that the file has
> been renamed you could move it in one commit and then add modify it in
> the next commit.

This is the minimal solution to the problem but as Johannes illustrated,
there cases where that "move commit doesn't solve the problem"

> Splitting into two commits helps only certain
> cases, in particular, when the commit that moves the files is compared
> to an earlier commit, such as `git log` does. However, if a commit after
> the change is compared to a commit before the move, the rename is still
> not detected.


Further examples:

The move commit helps if i want to blame a file if i use the -W option, but=
 if it doesnt
help with git log since the changes are now considered modifications.

git blame -w ruby-example/lib/calculator.rb
(shows previous files changes and not the indentation)
```
303f25f5 ruby-example/lib/calculator.rb (nothing    2026-05-02 16:40:51 +08=
00  1) module Lib
^1cf274f ruby-example/calculator.rb     (billybonks 2026-05-01 12:36:47 +08=
00  2)   class Calculator
^1cf274f ruby-example/calculator.rb     (billybonks 2026-05-01 12:36:47 +08=
00  3)     def add(a, b)
3d22d303 ruby-example/calculator.rb     (billybonks 2026-05-02 16:34:14 +08=
00  4)       a + b
^1cf274f ruby-example/calculator.rb     (billybonks 2026-05-01 12:36:47 +08=
00  5)     end
^1cf274f ruby-example/calculator.rb     (billybonks 2026-05-01 12:36:47 +08=
00  6)
^1cf274f ruby-example/calculator.rb     (billybonks 2026-05-01 12:36:47 +08=
00  7)     def subtract(a, b)
^1cf274f ruby-example/calculator.rb     (billybonks 2026-05-01 12:36:47 +08=
00  8)       a - b
^1cf274f ruby-example/calculator.rb     (billybonks 2026-05-01 12:36:47 +08=
00  9)     end
^1cf274f ruby-example/calculator.rb     (billybonks 2026-05-01 12:36:47 +08=
00 10)
^1cf274f ruby-example/calculator.rb     (billybonks 2026-05-01 12:36:47 +08=
00 11)     def multiply(a, b)
^1cf274f ruby-example/calculator.rb     (billybonks 2026-05-01 12:36:47 +08=
00 12)       a * b
^1cf274f ruby-example/calculator.rb     (billybonks 2026-05-01 12:36:47 +08=
00 13)     end
^1cf274f ruby-example/calculator.rb     (billybonks 2026-05-01 12:36:47 +08=
00 14)
^1cf274f ruby-example/calculator.rb     (billybonks 2026-05-01 12:36:47 +08=
00 15)     def divide(a, b)
^1cf274f ruby-example/calculator.rb     (billybonks 2026-05-01 12:36:47 +08=
00 16)       raise ZeroDivisionError, 'Cannot divide by zero' if b.zero?
^1cf274f ruby-example/calculator.rb     (billybonks 2026-05-01 12:36:47 +08=
00 17)
^1cf274f ruby-example/calculator.rb     (billybonks 2026-05-01 12:36:47 +08=
00 18)       a / b
^1cf274f ruby-example/calculator.rb     (billybonks 2026-05-01 12:36:47 +08=
00 19)     end
^1cf274f ruby-example/calculator.rb     (billybonks 2026-05-01 12:36:47 +08=
00 20)   end
303f25f5 ruby-example/lib/calculator.rb (nothing    2026-05-02 16:40:51 +08=
00 21) end
```


git log --follow --diff-filter=3Dra -- ruby-example/lib/calculator.rb
( it does not show the move commit )
```
commit 303f25f50cde83c46f83bc3c337cd52b87b63d52 (HEAD -> example-2)
Author: nothing <nothing@contributed.com>
Date:   Sat May 2 16:40:51 2026 +0800

    update lib and require

commit 3d22d30304d836c07b3274689e5e2c536b29e1bb (example-3)
Author: billybonks <sebastienstettler@gmail.com>
Date:   Sat May 2 16:34:14 2026 +0800

    fix: sum was doing subtraction instead of addition
```
Using this approach does incur a heavy burnder on the user since most tools=
 that do renaming etc=20
will move and rename, and that cost does not give a complete solution as th=
ere are still many thigns
that don't work in the most ideal sense.


As mentioned by Chris

> It *could* be improved. Doing so in a way that works for more than
> just some special cases -- e.g., in a way that works for ordinary
> text, or graphical images, for instance, rather than just for Ruby
> sources (or just C sources, or C++, or Swift, or Python, or whatever)
> -- seems particularly tricky. Some degree of ignoring white-space
> changes would probably help multiple cases, though.


Has there been explorations of ignoring white space for the similarity chec=
ker, i would=20
assume that majority of white space movements across many languages would r=
esult in a=20
semantically similar document in most cases.
=20
- Sebastien







