Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12BE1E862
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 02:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710727953; cv=none; b=QCsKpO4st2f0e0qnNutclQad2treUoEGZf+lB5nbC0ldWY9CsW/ZDtZqBRRzUfSSC4eFLez5fcUV6OzQLd8T5ByWwn2BR1TANhzBZ8iCGnSZKHdPV8G3/MhUhjLAuaXiEQwycddEXkwBqyMjZ/rySzCKioH+3MqXbCvo84PQX+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710727953; c=relaxed/simple;
	bh=o7/ve/BNLoSuUJttk4l2leaDk0aq2eIU/lylhxyylqs=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=AIrr9gI4Oy1NQoSXywcBkWZxyDqqK3PV1gO3pgxc5skZgHRVpkNJShTlzazenpdl55pX3iahxjNtEiZC2UtACupkBTfm3neiKdqbQqliiDLrO+8M8NSJKpvSGjqiaj9Smok2w46b0vpc6hEAuyuMA1xB5U4+tFzpyGAfDOZ06UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 42I2CL0q2626155
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 02:12:22 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Shubhu Rana'" <xhubhurana7777@gmail.com>, <git@vger.kernel.org>
References: <CANWjJ0M_buzhES7g+6maGFgC668cEcWtMivOfPBPvnifhKjjkQ@mail.gmail.com>
In-Reply-To: <CANWjJ0M_buzhES7g+6maGFgC668cEcWtMivOfPBPvnifhKjjkQ@mail.gmail.com>
Subject: RE: Subject: Resetting git account from system completely
Date: Sun, 17 Mar 2024 22:12:15 -0400
Organization: Nexbridge Inc.
Message-ID: <010201da78d9$b60a36d0$221ea470$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFxkpQ8qq93QfeOnFrYFOMflRClCrIOjYYw

On Sunday, March 17, 2024 9:55 PM, Shubhu Rana wrote:
>Hey! there,
>Actually the issue is that I've installed git on other laptop and set =
up my git account using my own git username, mail and password,
>and start using remote github for cloning, pushing etc. But now I want =
to reset my all the setting from that system, so that when
>someone try to using git on that laptop they won't be able to =
manipulate my git, github repos, It will prompt for them username and
>password. I've tried every possible way from deleting credentials from =
windows credential manager and  git config --global --unset
>credential.helper renaming and deleting .gitconfig file changing PAT on =
github resetting password and tried chatGpt's steps, gemini and
>what not. Could you provide me step-to-step guide to resolve this =
issue? Please help me to resolve this.
>Any advice appreciated. Hopping response from git community.
>operating system using =3D window 11
>Thank you

If I understand correctly, this is actually a github question, rather =
than a git question, so your question is more appropriately directed at =
github; however, You should look at the credentials you supplied to your =
github user id and examine the settings on that site. Following that, =
you will need to update your local SSH keypairs that were updated on =
github.

Good luck,
Randall

