Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B440D18AFB
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmadbyPi"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-204fdd685fdso3815623fac.2
        for <git@vger.kernel.org>; Wed, 03 Jan 2024 02:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704277369; x=1704882169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0j9LcyNjdX9ns3+PAtCiqYivsgqsLoLeArkWYtYrVn4=;
        b=ZmadbyPicbU5k3MbLqA+z9IW62KeCjy2hjEjyaey7zYbGfPln6yC1PDce0V2iRDNA0
         RTO88kDkBLdyPbsq7mh4eyg2iR69qJva8qTLjDeRNIUze69jZSI/EHKojc04pDebDScx
         vS6PmvRDtFV/DgiqIFHm7YTXOa32Bd+ZwNYyqKmctaqGrqZSlA7vbGtkRiucDyHvIWL8
         kBPMVrt3oE5H9/FN47C4P10N+H0Ka7kdKRwgsyf5hkaIC6M6M9zmwIjyl8gDaC8QdWxS
         tq9jwIargChhZyQuapyLc0uVm60svljSFWqKiEEIPUbmiR9yAORE9whGyAcnDBp742vF
         CYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704277369; x=1704882169;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0j9LcyNjdX9ns3+PAtCiqYivsgqsLoLeArkWYtYrVn4=;
        b=vX8sbW+LVNQEjgYGqEDBQUgwA+70dIiJjrz+inTBQjeYSEHUviFERzBpK2o5muWdhy
         +0Uqwj3GyLtOuUMLnjfZ+lg+HfjRDvG4aPbJaeu6IvN+iWV1wim6S4RWowzjFf56yEBO
         zbbhgSgmZiuJCVu/xxLKh14zJwQ3+sEtWH7S6gbsQDSzxdqOUtysBJHdpc83lcTw6KTf
         RTmRdY9KOqZsaMGIhOG3I56IpwPuxBKojnzm5VJs9FHIiZtjXBi52MB32o4jrowf9YD+
         xcdTpogCSg5RFP5OXQo5mePP8EA00pF7ixLgWM5dQUwyMY7rtHfcYaU9waS7a+9GIJ8D
         xLPw==
X-Gm-Message-State: AOJu0YxhseJkZm3JyElxe0fgs/kQ9+9zG2fz5T61SBf/8KZQ/dtKSnNV
	8FXtxZPJfZgGFwnEB2GL+pLcWEWmA9nqgHVExbg=
X-Google-Smtp-Source: AGHT+IF/EKBW10Rh6AirbatSO+sw85VWoej9rBp7wRHL1YsIC91k6Zv/nwYeO0yBb/bJr/VlSSZnu86MHTkZa9K0iTg=
X-Received: by 2002:a05:6870:b24f:b0:203:7bef:1691 with SMTP id
 b15-20020a056870b24f00b002037bef1691mr24790032oam.109.1704277368681; Wed, 03
 Jan 2024 02:22:48 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jan 2024 02:22:47 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZZUgUUlB8A-rhep5@tanuki>
References: <20231221170715.110565-1-karthik.188@gmail.com>
 <20231221170715.110565-3-karthik.188@gmail.com> <xmqqzfy3l270.fsf@gitster.g>
 <CAOLa=ZRedfBUjukbN8dFT9CZETe4pz1UR+eWfJwORWuMHSk0Rw@mail.gmail.com>
 <xmqqsf3oj3u8.fsf@gitster.g> <CAOLa=ZTPxWXnZ8kpBB7=cybNfdEv6d6O37Em7Vpmcw=enpY1_w@mail.gmail.com>
 <ZZRaOhK869S1Sg1h@nand.local> <ZZUgUUlB8A-rhep5@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 3 Jan 2024 02:22:47 -0800
Message-ID: <CAOLa=ZS4OOAmyRvf4HH-c_3GvnVkh6zS2kD3hEhRZ7NZT-rvyA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ref-filter: support filtering of operational refs
To: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, christian.couder@gmail.com
Content-Type: multipart/mixed; boundary="00000000000028d65f060e07ffb5"

--00000000000028d65f060e07ffb5
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jan 02, 2024 at 01:47:22PM -0500, Taylor Blau wrote:
>> On Tue, Jan 02, 2024 at 07:18:48AM -0800, Karthik Nayak wrote:
>> > > As "git for-each-ref" takes pattern that is prefix match, e.g.,
>> > >
>> > >     $ git for-each-ref refs/remotes/
>> > >
>> > > shows everything like refs/remotes/origin/main that begins with
>> > > refs/remotes/, I wonder if
>> > >
>> > >     $ git for-each-ref ""
>> > >
>> > > should mean what you are asking for.  After all, "git for-each-ref"
>> > > does *not* take "--branches" and others like "git log" family to
>> > > limit its operation to subhierarchy of "refs/" to begin with.
>> >
>> > But I don't think using an empty pattern is the best way to go forward.
>> > This would break the pattern matching feature. For instance, what if the
>> > user wanted to print all refs, but pattern match "*_HEAD"?
>> >
>> > Would that be
>> >
>> >       $ git for-each-ref "" "*_HEAD"
>> >
>> > I think this would be confusing, since the first pattern is now acting
>> > as an option, since its not really filtering rather its changing the
>> > search space.
>> >
>> > Maybe "--all-refs" or "--all-ref-types" instead?
>>
>> I tend to agree that the special empty pattern would be a good shorthand
>> for listing all references underneath refs/, including any top-level
>> psuedo-refs.
>>
>> But I don't think that I quite follow what Karthik is saying here.
>> for-each-ref returns the union of references that match the given
>> pattern(s), not their intersection. So if you wanted to list just the
>> psudo-refs ending in '_HEAD', you'd do:
>>
>>   $ git for-each-ref "*_HEAD"
>>
>> I think if you wanted to list all pseudo-refs, calling the option
>> `--pseudo-refs` seems reasonable. But if you want to list some subset of
>> psueod-refs matching a given pattern, you should specify that pattern
>> directly.
>
> Where I think this proposal falls short is if you have refs outside of
> the "refs/" hierarchy. Granted, this is nothing that should usually
> happen nowadays. But I think we should safeguard us for the future:
>
>   - There may be bugs in the reftable backend that allow for such refs
>     to be created.
>
>   - We may even eventually end up saying that it's valid for refs to not
>     start with "refs/". I consider this to be mostly an artifact of how
>     the files backend works, so it is not entirely unreasonable for us
>     to eventually lift the restriction for the reftable backend.
>
> I do not want to push for the second bullet point anytime soon, nor do I
> have any plans to do so in the future. But regardless of that I would
> really love to have a way to ask the ref backend for _any_ reference
> that it knows of, regardless of its prefix. Otherwise it becomes next to
> impossible for a user to learn about what the reftable binary-format
> actually contains. So I think that the current focus on pseudo-refs is
> too short-sighted, and would want to aim for a more complete solution to
> this problem.
>
> This could be in the form of a `--all-refs` flag that gets translated
> into a new `DO_FOR_EACH_REF_ALL_REFS` bit, which would indicate to the
> ref backend to also enumerate refs outside of the "refs/" hierarchy.
> This is orthogonal to the already existing `--all` pseudo-opt, because
> `--all` would only ever enumerate refs inside of the "refs/" hierarchy.
>
> Patrick

Thanks Patrick. I think the confusion was because I was referring to add
a new command to print all refs, meaning all refs including the ones
outside the "refs/" folder.

The confusion was that I thought Junio was referring to using

    $ git for-each-ref ""

to print all refs under $GIT_DIR, while he was actually talking about
"$GIT_DIR/refs/" directory.

So to loop back, I'm suggesting to add `--all-refs` to print all the
refs under $GIT_DIR. This would include refs traditionally found under
"refs/" and other refs like pseudo refs, HEAD and perhaps user created
refs under $GIT_DIR.

--00000000000028d65f060e07ffb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 439e97346c96ad2a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1XVk5YWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meWlCQy80a2E3ZFhEcFFQRFNvc1BkTG1FcmV4RHZlRgoyMFMzdXJLVVVY
TldPd2JMN24ybFBUNUU4Y3U5dW5BWVhBZDIvNnVJVDY5QmlPY0xTd0JLa29CS1B0cjROWmhMClNh
MEJNVnB2enNOSDdBd0UyYmdjQmpIYWNHa2FKTGo5U2ZOZnJURTB0TFY2QjVoZHpoMkxOUS9HOGQz
N1NlYUMKQnhpMDluWDZTOEJBZ04yTXlGTmpCdVNEcGc3SWVjcXludlQyT3REV1FTSDJpTGpoSFBP
cW9SSk5XZlhPQ2ozTwp1Z0g0TG9DUFd6RnVoOUdYSGlRWkNWTVdQWlBhSXdwaXZ6L3FCTVdocWxI
K1JYalpkR3ZoMjRremdvT2NHT01SCkZVRmp4VFU4SlkyU2oxSTU3aUNXY3dwcW9Bem5tRmNkRS9v
NlNTbkdrd2wrNG9hWnExblYwbVpsZnpkcElpVlQKZ01pTThGMEY2UVVjdXFaV2h2WS9DaEUxTUlX
ZWdLOTZWNEJvaEs4Q2h0eFVXOGxkaWpzc0ZkYWNKWFF5eGxBcApEWFZJZ3Jxc1NOVzdHQ1l2RE95
N2o1dmxXZDQ2ZTFGc0NxV1FMMjZJNVNUSkhJeHVIc3JtNkF2VlhXb1VNZlpoCmR0MjBPd055WDBS
cVZJNVZUbVphdk5XMzNGSno4bVlUSlF5aXVDbz0KPVRiTW4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000028d65f060e07ffb5--
