Received: from mail.inka.de (quechua.inka.de [193.197.184.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E7F23C8C7
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 20:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.197.184.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738959734; cv=none; b=khDyDuymkYvC7IATGBaPLgn7AI26iWJsUIccUIeV+e84y1WxIrS1WJBb5hDUv1Cy4FJWWLpqf5Urw9WQ/DymuUuROSi/dJJ9bb0nJ4vYZKVK25sBwKrWLtTZ4x389HxE/3TGxBsschEIkmQ5ZtpWBJqmVIqZ2/91nz4OjQ/ecAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738959734; c=relaxed/simple;
	bh=3CkXtfZLa9jJUJZtcSfaEniJnVA96xSUa4L52JIrNUo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=la74hu10ZFou7b5DUX7bQiFzNCXJN5hswSXiR2GTYdj+rVJVtgtnSOWAfRAItCeWrCl3u1/WFHb8FM5Wyo1tCU2GH0X07R3OeHsGgNVSVACpZELWHe/bejmgQxnc5QVj77Ojz/9G0ni95kFpBsX0sXpa5i/s/FGSMIQmzPrraxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de; spf=pass smtp.mailfrom=raven.inka.de; arc=none smtp.client-ip=193.197.184.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raven.inka.de
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1tgUrW-004S85-Vj; Fri, 07 Feb 2025 21:22:06 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id CD86060115; Fri,  7 Feb 2025 21:21:04 +0100 (CET)
Date: Fri, 7 Feb 2025 21:21:04 +0100
From: Josef Wolf <jw@raven.inka.de>
To: git@vger.kernel.org
Subject: Re: renormalize histroy with smudge/clean-filter
Message-ID: <20250207202104.GF30202@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <20250205214726.GA30202@raven.inka.de>
 <Z6PsXGnxM3UBR3nM@tapette.crustytoothpaste.net>
 <20250205235931.GB30202@raven.inka.de>
 <Z6QCX1QZxxwC7RVQ@tapette.crustytoothpaste.net>
 <CABPp-BFZ3oyKiryKMPph+nfokC=sFa7wn1wdas863273bzy7pA@mail.gmail.com>
 <20250206134006.GC30202@raven.inka.de>
 <20250206200418.GD30202@raven.inka.de>
 <CAPx1Gvc2piLT=p+dvzcJPTMDQAAjQfz__O4KiRWs-fOMg8dpTw@mail.gmail.com>
 <20250207104510.GE30202@raven.inka.de>
 <CAPx1GvcyaZqYK+SvgtfsajqtkMty1jOcVAtwfmam-LpOjyd0jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx1GvcyaZqYK+SvgtfsajqtkMty1jOcVAtwfmam-LpOjyd0jw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Feb 07, 2025 at 03:12:44AM -0800, Chris Torek wrote:
> On Fri, Feb 7, 2025 at 2:46 AM Josef Wolf <jw@raven.inka.de> wrote:

> Git is famously *fast* (as compared to most of the systems that came
> before or at the same time anyway). In the old days when I used CVS
> and Subversion and the like, we'd run a commit or update, and then go
> out for coffee or lunch or whatever, because we knew we were not
> going to be able to do anything for another ten minutes or perhaps
> even an hour or more. Then Git came along and we'd run "git checkout"
> or "git commit" and it would say it was done, often without even a
> noticeable pause, and we'd wonder if it actually did anything at all.

Well, I know the days of CVS. I even know the days of RCS. And yeah, bak in
those days you used to cross your fingers hoping that all will go well
while drinking the coffee.

I think there is more into git than speed.

-- 
Josef Wolf
jw@raven.inka.de
