Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44820382
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 01:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721265240; cv=none; b=OzLpgqHMVUd1g8cmXHydPUEm1oozUXm2/vE9S3vhLqfdKHM275PTqLr3Jvx8pvuJxQTjdwY7gd3xhIJiLdLEGs1jd3V8gmIK0o5RlAhpOAjthc//t2lIev1wecTz3iVw2YAZylTebTlKnhM1uKQWQ12Ia8vGiB0eMIgRaBARpqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721265240; c=relaxed/simple;
	bh=DEUxfukAYAXsWxsxFrTgHUR2188M07CuqZIchyy9mM8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=VJyIrizhHNb9BDZzxK46+HME+TE0/j4jpbiCWbaOegzJnrXu0K2ZhqKjeuoa3zMmYeKAxA2rKKBNiZVdHRgVm0xyOoeDbspRc14FrCO80X1LYX/PFsVQKY6ZZv635XuPIbpYav/lbh2aQQSi9aULWsUEuZGHh+/uqXkPvQOracU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=f6FW/Hjq; arc=none smtp.client-ip=212.159.14.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="f6FW/Hjq"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id UFfUs5yhZX9c9UFfWs8mOZ; Thu, 18 Jul 2024 02:10:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1721265050; bh=U9pYdzZIIeFMqDqnYgI4uptIKbXWReL8fDgBQFbdgXg=;
	h=Date:To:Cc:From:Subject;
	b=f6FW/Hjq9tXkKiLCCvTjDrGkSnl4lTFRxhDyEu0Eong8bB+3lmbSEw4qHD1Updhmc
	 wb7CvDpreh4AVI/EQ9385LEpNapkw6b8V7Thifmly1mWpnj/v8YQfx4rkIskiVp4uI
	 QlHCGSkj1A9nQIrMCUw003El+upEo8zBaKeZLAsjNyWjjNx3+7R2SshgIH0WTGZ6GZ
	 vPhaBgomKu20IcKjv+lC0R4yecY8GMaDQk8Dl1M9Okq6QAUYyCEF66upYUP7uCxFWt
	 vUiOwvpvTqxg0bqw66LqZsywbBp23dTXKDuNpbDF2RvKl/Yo5J7phhjTVcGFhGz8ju
	 tFzbpOjBIuI0Q==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=NPx2+F6g c=1 sm=1 tr=0 ts=66986b9a
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=Zc4h2LxlQuItlyckRoAA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <7a38d869-8d8a-4922-894c-59ac7fc20449@ramsayjones.plus.com>
Date: Thu, 18 Jul 2024 02:10:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Subject: [PATCH 0/2] misc Makefile patches
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGelY9KPQb64+Wq8uSlFagdlTUjH3MqfsJJCKiHjA8+jmnlU5aLgBQjzfJpfHtD9rhO3odlCqcWgW5O2TZJGZv8u1fwV6KGv5A8c75DaLuv21vANygCe
 MgVVYqP+p478h9/q9x5t6L/L2ksvhabiRs9EdzKfmlFpSI2d72bw/AgZV66buwR6jZ0T+JJHJPz6JVyno63zRzlCfock1E2Jz9w=


These patches have been hanging around for _years_, so I rebased them
onto the current master branch @ 04f5a52757 ("Post 2.46-rc0 batch #2",
2024-07-16). This was prompted by the sparse discussion tonight.

Ramsay Jones (2):
  Makefile: drop -Wno-universal-initializer from SP_EXTRA_FLAGS
  config.mak.uname: remove unused uname_P variable

 Makefile         | 2 +-
 config.mak.uname | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
2.45.0
