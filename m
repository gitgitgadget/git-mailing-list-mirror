Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A5F1C1F22
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 22:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954606; cv=none; b=Uw3TSnfCe+Jus/7G2rkitYLg/Aup/N1+sjoMiCdvWkpQYhAIdsYb5MMdXlqo62zPlND+ejhqkcYJdjyS3UhVhr1TzBbNB6h9yblmDA6MUgeRqBXb5NVPtl3GAewgoIv7ORB+YCdG3XBykihvO7coZkMHDUM21o6AdWbXObkhC2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954606; c=relaxed/simple;
	bh=d57bbwiHLQxU53xFlQCXTmSKz3xglvfAjMQ0Mt6rGxs=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=m+Td4Cja0zm/C7XKsr5kSIgkHQ4gEgvDQtnNGCXesyJdF6lv1csrPyauw+PCpCwpEbJr5NT6WOC3OI3FjKlpOIs7ESJhlFyNddbUKjvAp/5mCtDLFude2C29rDQOFw5mc0Za3YdWbphWGL9jFL4qDOdq0tyqSeZU09FO1mSRCn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=ZWUKfdJV; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="ZWUKfdJV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=d57bbwiHLQxU53xFlQCXTmSKz3xglvfAjMQ0Mt6rGxs=;
 b=ZWUKfdJVe6bSRe8bDqKn3hJYPpBIy3Nj4NGSRw/gJxDoNVSWXjdiNGGD9t/oegcSXgMo0S0abCvq
   TeMIti+XsCfb5IF7LPI7duiHmNQENNstIEISZPBq08j1mR+4JcJQAVWOQa2Tm8cS9GJV6QkDznK9
   VVQ2EatMOS5JVQbLQ3hzP0TDlaNiCmK5IMbLWvKPbRnQKdfcLkgp5kMbk+odxKfouA9uu0oYQn/L
   O//sZLS0JeJOInNAZSol/9eR+Y2EPRD21BMVQZAnA4ecC/DgpVSjdFrIJMZwRfJI0WyMmId9u6lh
   PZ0CVtdktXh78eKIkSg2NL7/Kwd9l4RMkqsezA==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SOC00A1TNXIKK70@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 11 Dec 2024 22:03:18 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Wed, 11 Dec 2024 23:02:56 +0100
Message-id: <D697LJWHRVMR.36YBMM1URT59U@ferdinandy.com>
Subject: Re: branch description as a note?
Cc: <git@vger.kernel.org>
To: "Justin Tobler" <jltobler@gmail.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <D68T28TFNW6N.2W0WV6WOUT6V0@ferdinandy.com>
 <ldbhbymjanp5xg4suatp2bgbnk3etkgxqivytpqzyqkmsiuotk@hnro3pu2zqtj>
In-reply-to: <ldbhbymjanp5xg4suatp2bgbnk3etkgxqivytpqzyqkmsiuotk@hnro3pu2zqtj>
Reporting-Meta:
 AAHTorN5Q9PFyqj6wSgN3tdighfE6wLCguebq3ii8+rHHRPON74VFWP/5OpLLJa7
 neVM6jQwhMaRxn0itawa4EKRVCRzN9mfpqBXkWc/K1rCl+hngJfJcIc9jLVTVhzg
 P5jhvVz8hLRDQJhZxlpsTC3U7F+7Zf+c2TcOy0rGzSenOAUfYRoj5TxgkH01k+eZ
 /DirDhsDX1lYcsSEQmmlDJ/kPeVPt/mkEZLjYmstKknhQ6SaMJ6js1wq/FCMSCtM
 baO6uZKvtDZe4PM4oGJzTLE5ae93bCdiDqOZSd6tbtFanxmlkDPMivCei3OfPJyG
 jEPG9lsS0LTqbfCIClTVzTHJAqy+ivl9qVR9UeryD8/1TNrsrc/tWH2eYTIZDSBV
 y80ddOo52JOmU4s+mPEeFRUu8DU56MX2JJr9+rdhy2HesuJfUNgeQAlU4a/RJ7B5
 0JIsKf3BlAo5Dq1Gudoui5F/bkE4kJrKoFFaPhaZy+QJXO6hk71EcYlk


On Wed Dec 11, 2024 at 18:34, Justin Tobler <jltobler@gmail.com> wrote:
> On 24/12/11 11:39AM, Bence Ferdinandy wrote:
>
>> Now my problem with the description being a local configuration, is that
>> I often work on patches on two different computers. I can easily share m=
y patch
>> notes with myself, but not the branch description. If these could be pus=
hed and
>> fetched like a note, I think that would open up some other nice possibil=
ities
>> as well, like having a standard place for MR/PR messages for forges, sha=
ring
>> proposed merge commit messages, maybe other things.
>
> Recently I have started using branch descriptions to store MR/PR
> messages and using a script to sync it with a forge over its web API.
> This has got me thinking along the same lines. It would be nice if these
> descriptions could be part of repository tree is some manner to more
> easily facilitate distribution.
>
>> For my personal issue of sharing branch descriptions with myself, I coul=
d
>> probably just make up a convention for myself, say using refs/notes/bran=
ches,
>> but it would be nice to have this built in, instead of the local config =
branch
>> description.
>>=20
>> From usage perspective I could imagine a new `--branch` flag for notes, =
which
>> would tell `git notes` to operate on notes attached to branches instead =
of
>> specific commits, probably stored under refs/notes/branches by default. =
Maybe
>> add an `--edit-branch-note` to `git branch`. And of course have the opti=
on to
>> use this note instead of the description configuration wherever it makes=
 sense.
>>=20
>> What do you think?
>
> One problem I see with notes is they all live in a single notes tree and
> are associated with individual commits. Therefore, I'm not quite sure
> how a specific note could be correlated with a branch without having a
> separate notes tree for each branch. Maybe the notes mechanism could be
> extended to also support storing notes associated directly with a
> reference in its tree? That might allow for notes to follow a reference
> as it gets updated.

I haven't really looked into how this could be implemented, but somehow you=
'd
need to map the branch's name to the object for sure. I just thought it wou=
ld
help if the user facing part would be similar to notes, maybe even the same
command just with the --branch flag to tell note that the branch name shoul=
d
not be resolved to a commit first and then to the note, but rather the name
directly to a special "branch note".

