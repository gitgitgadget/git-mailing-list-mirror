Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8FA20C463
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765451447; cv=none; b=i3VAhbPpZLiYRMYGJBWd70FF/lsVqRxZe5SPz3ycm3uX/TfNQSgL9EgANUsA0TNwyizlFX8sXY2JW71dpNrlj6lVLBaTSM9xfdy5GpIPYoEOJVrrGsG1EqoSm0dOdpQ9xYYtkNHptZW7u+1gI/45RbHA9zIoy6VX6ifbgcE23Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765451447; c=relaxed/simple;
	bh=BzK0TLlL/DntS4+4wKKZM3CCR3pqc3rVjam0OWa0d4I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jSkyQLvm5Iuo02iVZYny+qG0Ha2PrS3sQb/h5zRaHrdd+xFJji/paB7uWuhThT8o3Zw5lQs6NkISVkKSKhanp9L6cRl3WJ0jlmOiOnWYJ+cMUYwhxBDGLkiDRGNdu5WNWytk2sN++gQpsEpVic6n0DgYIl4jzhAM5KoXD7cVR5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=SoHN3fh7; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="SoHN3fh7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1765451441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BEyEW9lEB+k5MYP1SXMIXWjS4LxbhCKA8PDZhBssZlE=;
	b=SoHN3fh7BPOM3VAiABmUZ1VLbxvJ7yT22RJT5zSDi8H6Jtk8yYcDOvYmQ/4RUWUStQ6a6o
	lBakh7HjgMJW+Vcr4FYtDgJRnmOEjNL93TzWH1AKWjsR4W3AxN+BxOZldN8oiEI0vB2Jpi
	W5TEQx7Xd9hiUBODYl84vWAte0+foqY=
From: Toon Claes <toon@iotcl.com>
To: Carlo Arenas <carenas@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] Few fixes for cross-compiling with Meson
In-Reply-To: <CAPUEspjifD8MYp6UR4pE91OqcJQdFafpeG8zNo1kfdxhnch_3A@mail.gmail.com>
References: <20251202-toon-cross-compile-v1-0-cabc8bce529f@iotcl.com>
 <3tucvydzaelj2mngkocb75l52nssxkkdtt3dj4paviatd3uvnc@u2sy4vig7owz>
 <874iq1vxwt.fsf@iotcl.com>
 <CAPUEspjifD8MYp6UR4pE91OqcJQdFafpeG8zNo1kfdxhnch_3A@mail.gmail.com>
Date: Thu, 11 Dec 2025 12:10:24 +0100
Message-ID: <87ikedgtpb.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Carlo Arenas <carenas@gmail.com> writes:

> I happen to have one of those under the desk running RHEL9/s390x, so
> will be happy to test your crosscompiled binaries, assuming it is as
> simple as installing them somewhere and running something like `make
> test`

Thanks for the offer, but I don't think it's needed at the moment.

-- 
Cheers,
Toon
