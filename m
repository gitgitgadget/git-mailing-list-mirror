Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96081DDEA
	for <git@vger.kernel.org>; Sun, 13 Oct 2024 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728852082; cv=none; b=I/RtDhU9DCBOOUy5nNkdUWXZ11aJfCREnrHCMjNYu6Z4fuDJOViV4ErihjLCXqzDreISVBlAsGdbFK0oiOrlRXCPRYNt7DqI+FBrw/dbV4qDVw9zg6WNhPkuiAWhJ3utgTTKu3/WIWLJcqXoijg4i28FKy7T8VoEIB1i2UW+ENA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728852082; c=relaxed/simple;
	bh=HAVEEXg6UoYG/x6lx6ol1wDf96eH41f+uxleAKUVbvU=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=FgbWntTndy4yeNcsdgqfhFFqHmYvvhgdwcojIxyH5tfGvFhuI6w3AtSXe1Kz1KiFettn+WQ615uiBcZvwR8X+H20S6vvVgr3l5DbyNRyboghkoGgYT5kAAz01S+onHg0ndBUME1CRDGBJXes16T/ZykngjzHTcRkw6kB4ZqAe00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=GlGMvd5J; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="GlGMvd5J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=XTGhvVFLApw0J89CXRb+xb++cOKXwHqFUQLjz0NK91Y=;
 b=GlGMvd5JA2/y6VVw+AwJ34EMJsz7QDXng6VWvMemXSdM0a9xcoUu5ZTXsse9UAZ7mv3v2J9ZW5GT
   nRnA+9OIEMSqY6yq7670eI4V7YrRUJlaRsZX7D/3oqGfGnnNgJO+4UcbLHl/6GiRno002UHyyzvT
   vT5JVPXS/3rz8BRKcjyCzHqoQPaybp+MMN89YZ4AOSLUrn1t89/o8P+2AI6+M+E1pZThu5spQjw4
   ARP+ckpWdR4irN6hZD9AXEwI/HYkV41h16S2e3dNTqW3uxQhxh9u8NPFDi0InBwQ7y8mcW5llMpU
   z2LHX5w5iRdmmRSTS1vEH/t9i+7t9W8wUtOoQg==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLB001PMASV2J40@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sun, 13 Oct 2024 20:41:19 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Sun, 13 Oct 2024 22:40:39 +0200
Message-id: <D4UYWECVEIXX.25JAWP39XGC73@ferdinandy.com>
Subject: Re: with git update-ref?
Cc: <git@vger.kernel.org>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "Karthik Nayak" <karthik.188@gmail.com>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <D4T9VCF8OS6U.1FMB8P6YU7I3S@ferdinandy.com>
 <cb60b7ad-7902-4293-81e9-06d1b1526842@app.fastmail.com>
 <D4TA5EXQFFA0.1XVEK1RM2Q6VA@ferdinandy.com> <xmqqa5facosb.fsf@gitster.g>
 <f7a7046c-020a-4365-baf4-49184bd2c60b@gmail.com>
 <16d2d47c-5887-4658-b6db-996dac075828@app.fastmail.com>
 <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com>
 <ef5a38af-e2bf-49f3-8611-6134970f829b@app.fastmail.com>
In-reply-to: <ef5a38af-e2bf-49f3-8611-6134970f829b@app.fastmail.com>
Reporting-Meta:
 AAGOtndPHYve+CBAUpjOYmQTvvEHjh1F4B6/yLYbinbCdk09Ucq3ZVbhN0gRwJaM
 DuV8tulunR+xPPqMcWZA9KBQrR5gnL6sXVzkD4CCVhFdujG6653Ju+heb1c/HAfb
 AN+a3QVl7+HF+paEkVVIbZksENxjQ9YSQgB4PIGezxt6gUGh2y+CgQixZP30+vX9
 zkZ8PDQ4jn7Yi5DK5kvK/PpjYwILEV0Wf2bPshhW9VkE90agtyK0IAiaXAMzs8SL
 8G/fyeum2YN794VBEDTDKMtt12dWF8b5d8scBtHPyq1+LQlZYFnBB7R133j/pnEy
 bXgU7h6o6Itad9cIosGL9Wd3IZwFam5/785JARsMNzghjnQ7gEia24n3UbmxKKS/
 XOhuNvuE1nnfS6QO2tP4PB33TeDyvh5ufCtro2davjJ8xW5YdjKbCMoW3MIYhutx
 gO4OVa5Rrea6g8Zn7DGLPVoPjbbMOTxWNxoeM5PEMYjTAUTqcezXfRJJ


On Sun Oct 13, 2024 at 17:39, Kristoffer Haugsbakk <kristofferhaugsbakk@fas=
tmail.com> wrote:
>
> On Sun, Oct 13, 2024, at 14:09, karthik nayak wrote:
>>
>> I agree, the documentation here could use some cleanup. The confusion
>> here lies around
>>
>>     It also allows a "ref" file to be a symbolic pointer to another ref
>>     file by starting with the four-byte header sequence of "ref:".
>>
>> This is added to talk about how the command de-references symbolic refs,
>> but it can be misinterpreted to mean that it does support symbolic refs
>> on the top level.
>>
>> Do either of you want to take a stab at updating the documentation here?
>>
>>> That seems in line with a plumbing command.
>>>
>>> --
>>> Kristoffer Haugsbakk
>>
>> Attachments:
>> * signature.asc
>
> I wonder if the third (It also) and the fourth
> (about FS symlinks) could be removed. The
> third is confusing like Bernard said and the
> fourth doesn't seem relevant enough any more. Not relevant enough to be p=
art of Description.
>
> And the "safety" paragraphs could be moved
> to its own section. Because it looks like it's meant as an advice to unle=
arn the habits of a Git user from, I don't know, 2005 maybe.

According to git blame on the manpage, 2005 is spot on :)



--=20
bence.ferdinandy.com

