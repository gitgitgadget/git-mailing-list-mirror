Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A51A920
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736115230; cv=none; b=MQYUU93EcWwvhqIz5iEa1RmM8A78x4MgrmXjw2DciCrZD+hP572qVBTey5qgNkjRSYxt9lPIZevVfFMwZKxgMtyWQTj80l8dgvUyodPyyMaj3lMTlJu/Zp7t/OUmjsTBLytfksEUNZmuokryHGs3CBB8rn0evQb+/or7T4JrUEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736115230; c=relaxed/simple;
	bh=CF4ArnOMsb2CFoOUhYk+EG8lnYTIo7GAEjEwE7OjOlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=jEQxBYCov/t++aMXptJmGdS6aZ0qQIjBwKvtpa5D3k1dhBG3L/ogndPv5DG/z1c2hMlMTK8keHTdDlKXfSuBv64bvJwy5LN93AMBcQ5B/uuGrnyOXldHtJz1IZcmLYiJPIkUz3FHMNyUR6zgv2fHxfN3BCL9Tgd8k+uhyIrXA2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.101])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4YR9hX4nLKz7Qh0M
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 22:40:12 +0100 (CET)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4YR9hN2cD9zRnDQ;
	Sun,  5 Jan 2025 22:40:04 +0100 (CET)
Message-ID: <dbf29bb6-5105-4a26-80f6-36b796ffa4cb@kdbg.org>
Date: Sun, 5 Jan 2025 22:40:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: [GIT PULL] git-gui: Bulgarian translation
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit 5c95773eacee6eeecc16506fad3ca7fe6bf249be:

  Merge branch 'js/no-rescan-on-empty-diff' (2024-12-21 14:06:33 +0100)

are available in the Git repository at:

  https://github.com/j6t/git-gui.git master

for you to fetch changes up to ae6336b6173bf5303fad53e0a52a16f92c47b6b7:

  Merge branch 'as/translations-bg' (2025-01-05 10:44:35 +0100)

----------------------------------------------------------------
Alexander Shopov (1):
      git-gui i18n: Updated Bulgarian translation (579t)

Johannes Sixt (1):
      Merge branch 'as/translations-bg'

 po/bg.po | 3721 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 1890 insertions(+), 1831 deletions(-)
