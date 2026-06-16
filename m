Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D92D331EA5
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 21:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781645993; cv=none; b=FK5fYa1iI0vgP9HVqiUdKCs0wNOl+9CH4Bz/203ZsBxjo821vsvG73sxJ0TdKyPwE2OnwkFr6ZzaEvKx+EDRC9P1lbR5nyU08LHjtKwFqREpRDQY54ROEjWt9WM4UDrGzhpcvMCqM1+bUeYB7Xc8ndK1oXVVTaC/v2hrtkKh/rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781645993; c=relaxed/simple;
	bh=zoNVVWuPQ5J+IWIHeO733VTaeUPqq/I7wmKbivMUj0I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=VqI7gzzwDj//eEjNSXJL2x7xj2svk2hBNbQJbV30WnFSSxXcL8vsYmueejtcS3YnCALwtlY5fizJKYkcq+ThT8AQabMRE05nwHcLec2i4WDqGIyDgtMd5+FwVDPcDRv+XGmDQrhbMukht+zJp3ipAXGhqPlNom7B4+5QvNKwJF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=Mrd/Fh/z; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="Mrd/Fh/z"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id E98CE60035;
	Tue, 16 Jun 2026 21:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781645985; bh=zoNVVWuPQ5J+IWIHeO733VTaeUPqq/I7wmKbivMUj0I=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Mrd/Fh/zo6SoNQoz2Svavid5t7RtlnbPn64gJa6oKZ6FcDSfveIIXpPf/S7jTacr0
	 9A36EG2OUmkGJyHNiajYffXdpiS4tmZtk2u9L3EBL5T08sNcW75XFa/o4zmGTu7BfD
	 mhCILanBZ71RL7rgc7WQoEry/lXimPldOxUefDWg=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 17:39:44 -0400
Message-Id: <DJASSI4SSB3E.3JDRTZ3UNTSC4@lfurio.us>
Subject: =?utf-8?q?Re:_[PATCH_v3_02/11]_doc:_interpret-trailers:_replace_=E2=80=9C?= =?utf-8?q?lines=E2=80=9D_with_=E2=80=9Cmetadata=E2=80=9D?=
Cc: "Christian Couder" <christian.couder@gmail.com>, <jackmanb@google.com>,
 "Linus Arver" <linus@ucla.edu>, "D. Ben Knoble" <ben.knoble@gmail.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 <git@vger.kernel.org>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <CV_doc_int-tr_key_format.533@msgid.xyz>
 <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>
 <V3_metadata_not_lines.8a5@msgid.xyz>
 <DJ5W2I8UYXAA.3O4JQUHFMKP5X@lfurio.us>
 <26c2fcb2-2618-4bb9-a6e4-a6135934556d@app.fastmail.com>
In-Reply-To: <26c2fcb2-2618-4bb9-a6e4-a6135934556d@app.fastmail.com>

On Tue Jun 16, 2026 at 4:32 PM EDT, Kristoffer Haugsbakk wrote:
> On Thu, Jun 11, 2026, at 05:10, Matt Hunter wrote:
>> On Wed Jun 10, 2026 at 5:21 PM EDT, kristofferhaugsbakk wrote:
>>>[snip]
>>>  DESCRIPTION
>>>  -----------
>>> -Add or parse _trailer_ lines at the end of the otherwise
>>> +Add or parse trailers metadata at the end of the otherwise
>>
>> fwiw, I think "trailer metadata" reads more naturally.
>
> You=E2=80=99re right that your version reads more naturally. I went back =
and
> forth on this.

After reading your points, I started debating the grammatical
correctness of it to myself too.  Though I think I stand by my original
knee-jerk response.

>
> 1. We=E2=80=99re introducing the jargon, and the format is often discusse=
d as
>    plural =E2=80=9Ctrailers=E2=80=9D, with its constituent parts being si=
ngular
>    =E2=80=9Ctrailer=E2=80=9D
> 2. What this replaces uses =E2=80=9Ctrailer=E2=80=9D, but it rescues the =
plural mood
>    with =E2=80=9Clines=E2=80=9D
> 3. This is very soon going to go into the constituent parts, including
>    each trailer, so we=E2=80=99re contrasting the concept name (trailers)=
 with
>    its parts
>
> But I think your version is overall better. It reads better and there is
> no way to confuse =E2=80=9Ctrailer metadata=E2=80=9D (trailers as a colle=
ction) with
> just a single =E2=80=9Ctrailer=E2=80=9D.

Yes, "metadata" reads as a hint to me that interpret-trailers works with
the overall trailer block too.

Another thought I had after seeing this again is that the text could
just say "Add or parse trailers at the end ...", but "metadata" is a lot
more useful, since it's an introduction to what trailers _are_.  So the
patch is an improvement over the original context imo.
