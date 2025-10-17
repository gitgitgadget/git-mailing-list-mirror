Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335D01D5CE8
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 04:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760674738; cv=none; b=GOKF2dMOyUHL1SjgkAQ9oOMP7jYPc+qvduMYVBTkYDE+pp+7Gz/yD0OLJctpnqD8G29GBMPkuJTlPBus9mZgDc1P4W63zWvApFdscL9NWscKFRkxEBwjfO+ZjL4f3olhl9/NFR4QV8lLPmmzRYqpMpdLlTro0ti5WeP2+H2d29A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760674738; c=relaxed/simple;
	bh=ZrnIy5Ly6Kk7aJCCa/+Ji9qf9q/iEK3D8uYA4OXZT+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJRl/aLlO7BYcD+xubdtDkMMiJXpkhIjKsq/G5DwTsOPQ/JRCGe2+BOzYMNh1mqx7c2cToEow22CT1OB3zTPH/5B2KwAjjHUon2zjUJPbqQyrJMJDVmUceQw+oIodYxJZQrIASjdCYXuG9NYo5myqTjVeVwiE0AV90vNCaTb6jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=msJ0VMP8; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="msJ0VMP8"
Received: from trampoline.thunk.org (pool-173-48-113-184.bstnma.fios.verizon.net [173.48.113.184])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 59H4IoFK000957
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 00:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1760674732; bh=pKB7kNnAh+10OvQxYJk/XezYlbOjQFvPxI1q69ytAgk=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=msJ0VMP8n/kLIuGXkv/BQU7mpmcmQOntYBCNbNCZSX4sfg8X6rrK+xMRl/B/0zS+t
	 avwK67k7l8HdahAo93RfMhMPuhWvtKtnQMFvRK6Ax/ChOgqu+ghZdQstmrctbfqVQj
	 e/8WVLFgF+H5w6/ig/Ug9tc5NQlJ5g5v0oGXABEBWkDaB1SuBEZ+yOx3bOgbSZZ8ix
	 8CzFTjHNSbdBZgfEcw1c5OMcq9xg3FmeY6ypdnaKGnZYZASRNmk+lr4bJyDjD2zoKg
	 q1/z7FRirL8PLQPC0YtVA7bWnf+O2lv2Cu5u4L/RQaLTTzyVItNIyJU9nysDao/DhG
	 offHNi+UD8ymQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 9FC472E00D9; Fri, 17 Oct 2025 00:18:50 -0400 (EDT)
Date: Fri, 17 Oct 2025 00:18:50 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Collin Funk <collin.funk1@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: Signed-off-by & the law
Message-ID: <20251017041850.GD786497@mit.edu>
References: <CALnO6CDNRw3UcU9UM7rpkAoQsSmfdkxMKVihmoUmUOCv_fpbJw@mail.gmail.com>
 <871pn2ftx6.fsf@gmail.com>
 <CALnO6CC4hBBMyqEfLEn7EO28LVo7i4eDqAMLcFzSJZudVnB0oQ@mail.gmail.com>
 <87tszylem4.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tszylem4.fsf@gmail.com>

On Thu, Oct 16, 2025 at 02:29:39PM -0700, Collin Funk wrote:
> I think this section from an article written by the FSF addresses your
> concern [1]:
> 
>     Some developers worry that assigning copyright will strip them of
>     all their rights to the code they've created. To address this, the
>     FSF includes a "license grantback" to the developer in the agreement
>     contract. For the developer, a license grantback means they can
>     continue to modify and share their code, and technically, they could
>     even distribute their software under a different license. In other
>     words, by assigning copyright to the FSF, the developer does not
>     give up any of these sorts of rights.

That's not the only concern.  The reason why I have chosen to never to
sign an FSF Copyright Assignment is the following:

  "I hereby indemnify and hold harmless the Foundation, its officers,
  employees, and agents against any and all claims, actions or damages
  (including attorney's reasonable fees)...."

If you ever see the word "indemnify" in a legal document that someone
asks you to sign, I strongly suggest that you first talk to a lawyer
to understand what this might mean.  Speaking for myself, if I were to
give the FSF my intellectual output, under NO circumstances would I be
willing to risk my assets, my house, etc. on an indemnification
guarantee.

In any case, as I mentioned in my comment to Ben's Law Stack Exchange
answer, before the DCO was drafted for the Linux Kernel's
SubmittingPatches process documentation, it was vetted by lawyers at
the Linux Foundation and various LF Member Companies.  Those lawyers
certainly viewed the DCO as being legally useful.

	  	     	    	  	  - Ted

P.S.  The FSF has gotten more flexible over time; when I first got
involved with FOSS, the FSF required copyright assignments, and so I
didn't contribute to FSF projects.  Perhaps because enough people,
including large companies, have said "no way, Jose", the FSF will now
accept copyright disclimers, or even unlimited perpetual copyright
licenses.  More recently, they've even said that limited number of
code contributions with a DCO might be acceptable[1].

[1] https://www.fsf.org/blogs/licensing/FSF-copyright-handling
