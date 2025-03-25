Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2871EB3E
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916229; cv=none; b=RDs/Ld0lWDOikQ4zmWPP7LhspB78a+O36rIsiGG5tWI3wdRlREgMNQ+plpTq/IThFVAkhVOSjr0U2t83brf9bsHQpP92gKs9p9yH+JbiaebjHu/camCzZhtlygXI29fKpmJSDTwN9KhgReVP0Gl6lLVRUfhexUTfvMJ3Q59JzaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916229; c=relaxed/simple;
	bh=JsnLNMSe4CuIHVKi+E6MpXJwnVjDPiSIql5xsdbcDTs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZAM0a6jE+UTpDbjqCNwP22XsqBoFYgze8DnFqMRwxcwCCOqrus8IMr5TISkAHVzNUh1R+aYiFdrASezRq7DdEckxDDs3VJXxj4WNJHMveq17xtuqDqGDqYWCBNJqw+Xd2jXJvrtndX/TPSR5gju2colNOPo3wwGHLNNht4mCRtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 52PFNjNK691358
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 15:23:45 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
Subject: [Question] Moving from Python2 to Python3
Date: Tue, 25 Mar 2025 11:23:40 -0400
Organization: Nexbridge Inc.
Message-ID: <022b01db9d99$e68785c0$b3969140$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdudmX7u5cR2t/syT0OH+kRKIN2nLA==
X-Antivirus: Norton (VPS 250325-16, 3/25/2025), Outbound message
X-Antivirus-Status: Clean

Hi Git Team,

I have Python2 and Python3 on my system. We are deprecating Python2 ASAP. Is
there an easy way to force git
to use Python3 only? Both are in /usr/bin. python has a symbolic link to
python2 right now, but we are probably
going to change that. I already have modified settings in config.mak.uname
PYTHON_PATH = /usr/bin/python3.

Thanks,
Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.


