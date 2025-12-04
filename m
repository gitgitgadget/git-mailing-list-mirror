Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ED81531C1
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 05:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764825146; cv=none; b=gK1N7Am/9D95EawGPTvyuPJmy3F6gTOC0NbGRcrxNMZeyUypdubjfjLTW6HeT4o++K6aNcOzfY9yKLI/mKi8OuyBjtZofPoG4lDkixcAZ8sKF3T152k3rHqelGC+blwuBumm0IMkQ5Kd8wxxmzTfFN8wfZbC4WrR3JpBuu6IkIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764825146; c=relaxed/simple;
	bh=ha2E0zg0rmqD/dLA8EaEvsnypxqvU/KSg1PJGAtscAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nm2LcfC0BLpyF++VNLK0mX1L6yMFuA80oFobtpW+g7L0m/qrOdsfmxVqleaC5PPylDbl74nbjv1dllH/dsSrBlZPjSr+8BhM4KEGMQXcNeC4rXCzzjd0bW/TeQERIgmAgDBpLw3vh63Vu4CzOEbR5ApwXAOs+26aVv6DlOu0Rfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=LdXp7KO8; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="LdXp7KO8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764825136; x=1765429936; i=tboegi@web.de;
	bh=ha2E0zg0rmqD/dLA8EaEvsnypxqvU/KSg1PJGAtscAk=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LdXp7KO8j1SjdOtyB7AKZhWVX+7V6HYY25HATEvG7mpZ+eGarT7hPOjJPDtmGEPX
	 p5rPsXbdLHFP8Ufg26nW3E/7BUUjC0+UVKilHvKZPuwFjyiKxSXa6JWyIkOTidZnD
	 LbRMjuPHAxu/TThBSFQRA6M4WTfMKT9DWHvGtgGB4xuWzpAKMbk9Cjdvf9BrUPGOv
	 cTP0yP/ZHGkitUCwVhaiTwwlNamVg3UVZSed39WgVQCA4m6cG+8W9XDHXmSZRB36i
	 NlsDoT+tCWU9R+ncltwzDu9az6hAIOxdn4gxLBWRQ1iCPATdsNRqRDzn+vgQxJqwg
	 XglgP3jf9Cwcd6m71Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.224.105.209]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MidHP-1vxKJb0nzD-00ioRv; Thu, 04
 Dec 2025 06:12:16 +0100
Date: Thu, 4 Dec 2025 06:12:15 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Skybuck Flying <skybuck2000@hotmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Copieing git repository to another disk is dangerous !
 Especially in combination with remotes set to local repositories !
Message-ID: <20251204051215.GA23486@tb-raspi4>
References: <AM0PR02MB44508B247E4B6EF4F387DA5FB3A6A@AM0PR02MB4450.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR02MB44508B247E4B6EF4F387DA5FB3A6A@AM0PR02MB4450.eurprd02.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:Mu65gK1xi+lUyCluVsHhduyQHIdfDEdwDk1ngdtaKzSJwcYtTI5
 i00aYaJwwVFTLLtsejaJUtlFqxlXOOPc0c2V6ChpVE8QULGFc05WIQz+uOpLKjmkEW3KTyH
 bjvUt5+mxhXgbKuA3HN4q6T0q8zctEeP7C2sVk4HfiEYYEccUcWGSLonw1OGOaFuDPMTMHf
 z7qeEf7EJGJNw7YWEdMNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VulQ4wjWdkg=;amCu4DayMvV9eTkRkQtIAIoJgRV
 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
 HCU5bIPF3p0VDYxOXPqDdllbrfxkrvFLyHeqBv
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2025 at 03:59:19AM +0000, Skybuck Flying wrote:

[Skip all the interesting stuff]
>=20
> Which leads to the question:
>=20
> Can drive letters be avoided in git remotes ?
>=20

I think so.
Since a long time Windows supports an UNC path.
They start with a double backslash, followed by the
server and share:

\\server\share\directory\filename.txt
So when you do
net use z: \\server\share

you can do
git clone //server/share/path-to-repo
instead of
git clone z:/path-to-repo

(And git replaces '/' with '\' internally.)

I need to admit that this may be not well-known=20
but should work.
