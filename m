Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276AF3B5E19
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849926; cv=none; b=HMoiz7L9Kzv56n+l64/rPLSA55Tph3hcFDMP9PYFOO+V/soGEG7jinxSJDhZ9Mbmv+Fy81Qb83UmA+3/6Myj8Eb/y9UsA+SmSiErteuEFG5QNCZ80cLeMm01ZkhL39ksbs0edXLE2/Chtdvvmek9A9nm8CAc0NqC5WJGTJ6qubQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849926; c=relaxed/simple;
	bh=IIl/6fmoFiIFmCrn2pC1/LHJ+fOtwS6tBgboj6Vh9lA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/AKKPF+DYN5GF+92VCSTjIrhXk9nYX5giObQ+sByECSZywK8Sxv08vADYJDsD7crJWCFrHeoWy3V+tX6C8JF2MNJmxn4NNSLGJY5BeUkScJ+GRLdpChddtyMYq19v3yoPbTFtYnMZ3OtS/JL25D7SJKlcGH2IeIGKqJK7d4fYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=Am39T2wX; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="Am39T2wX"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 691AISAt018455-691AISAv018455
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 1 Oct 2026 13:18:28 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xCDrw-006uy8-Lo;
	Thu, 01 Oct 2026 13:18:28 +0300
Received: from localhost (130.232.226.127) by ex19-06.utu.fi (130.232.247.46)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 13:18:28 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id f2b991ce;
	Thu, 1 Oct 2026 10:18:28 +0000 (UTC)
Date: Thu, 1 Oct 2026 13:18:28 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: Silas Poulson <silas@dyalog.com>, <gitgitgadget@gmail.com>,
	<git@vger.kernel.org>
Subject: Re: [PATCH] Fix typo in MaintNotes regarding versioning scheme
Message-ID: <20261001101828.pe12F%taahol@utu.fi>
In-Reply-To: <xmqq1pe3ubr0.fsf@gitster.g>
References: <pull.2209.git.git.1771774770368.gitgitgadget@gmail.com>
 <882432fe-30f5-46c5-9efa-5b8a047283b6@dyalog.com>
 <xmqqfr6czmye.fsf@gitster.g> <20260618114837.0_RVf%taahol@utu.fi>
 <xmqq1pe3ubr0.fsf@gitster.g>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-11.utu.fi (130.232.247.51) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZXkgbAQQJGygMEQkEBw9GCwcF
 SFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhcSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhaWkgPARwPARwPCQwPDRwoDwUJAQRGCwcFSFhIWV9IDwEc
 GxwNGigYBwoHEEYLBwVIWEhZXkgbAQQJGygMEQkEBw9GCwcFSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=J4jKVh2Bi4DtkPG28JlqdgqwErvqCluGS7JBA4DZ/78=;
 b=Am39T2wXxilbS1mEmyK8MFXX8CM0hSapsR4Sy0KyUT8oMq0QPw1z+/H09weqGQCEgvUTrqB6t2Kj
	LKlRLeiC8W2BHcjpPekibF0mOUwzpDIC8pzVQQbYMzctyiXP2u8/Rrytn4bgpRZgieAsh//5x+KU
	FyWkgopT+stBCnDAJOBU+QgzMQzE+GF4L/tYRIOOghg/SahPZ++hIXmn8dTEr5SCcSyKTksYGLww
	ba5GINQzoW411HKtrx67nuqDnwacJje/aFuDmqdv4LN39+ABC0W4EddT4Qg+C3Bte0HYlUvynUa9
	1tssIWxnUVt0HRK44d4H5hQCfwoqSpookA1jFw==

Junio C Hamano <gitster@pobox.com> wrote:

> Tuomas Ahola <taahol@utu.fi> writes:
> 
> > Junio C Hamano <gitster@pobox.com> wrote:
> >
> >> Silas Poulson <silas@dyalog.com> writes:
> >> 
> >> > I'm aware this is a very minor change, but it would be good to not let 
> >> > this fall through the cracks.
> >> 
> >> Thanks for noticing a typo.
> >> 
> >> Will update before the next issue is sent to the mailing list.  No
> >> point in changing it before that.
> >
> > On that occasion, please consider also these fixes:
> 
> Thanks.  Will squash in.  The next issue of Maintotes will come
> right after 2.55 final gets tagged, so we have a bit more time.
> 
> 

...ping?

It's not yet too late for the 2.56 MaintNotes issue if we want to continue
having those.
