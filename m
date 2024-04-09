Received: from renault.us.lt (renault.us.lt [79.98.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889687F7CB
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.98.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672103; cv=none; b=iB+fKZWLo9OJW4B26SmM/HUfZw8Fpq5/UYPAuQAhU3n388PHybLt+7bI9hmMj34YURW9HbMjYAsiXOhcqtFsocTygweE8VJMKXHG2fQ8JzdGP+dVBZxzrzuj/RgyT5UuVh/oQO7MdRj7Vl1+p6abTMNcTgCas9+MT9jNXh/S6AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672103; c=relaxed/simple;
	bh=8wIAfibojaaH9RtfhB5x1wb5Jb6OB5eAPJqQ21T2V74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROvKgQ3MQKw9dmn5whTApm9ykNDh+/SKqm3YgSs+51AkqqL1BEIz/IPA0jdu4b29VIGnQK6xfJ2PyKu24veQv/Kvsb7nfgdfqT/c6TePj/ywEJBU4SWwUm28g2Vv+w/9Udmktutzk7pbzp7rMLXGgdwfbwOrEf0bl5JxxUtpk7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kipras.org; spf=pass smtp.mailfrom=kipras.org; arc=none smtp.client-ip=79.98.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kipras.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kipras.org
Received: from [157.230.0.129] (helo=localhost.localdomain)
	by renault.us.lt with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <kipras@kipras.org>)
	id 1ruBoo-0000a1-Ng; Tue, 09 Apr 2024 16:47:23 +0300
From: Kipras Melnikovas <kipras@kipras.org>
To: benji@fisherfam.org
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	nasamuffin@google.com
Subject: 
Date: Tue,  9 Apr 2024 16:47:22 +0300
Message-ID: <20240409134721.5106-2-kipras@kipras.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <CANc=FSNXzsFqzbgGs3CVAPxtxske_DEorNrk66gvYe2+1d_PAQ@mail.gmail.com>
References: <CANc=FSNXzsFqzbgGs3CVAPxtxske_DEorNrk66gvYe2+1d_PAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Authenticated-Id: kipras

> I was under the impression that the new "git switch" and "git restore"
> commands were recommended in most cases instead of "git checkout".

For new users, yes.
For someone who's looking to contribute to core git - probably not.

