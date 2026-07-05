Received: from mail.itlods.dk (mail.itlods.dk [85.119.82.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB37A1DF254
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 00:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.119.82.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783211013; cv=none; b=U85R303aqQBxGKBuRpKj81M9MGH8Qatrbl2PE9W8co1I+PleYTWu3aj0CQsHxnS2KenWZFjL939iXTzR9o1aZRSwSAEwFkP9596SI5lvh5Gt3dj+ExXGtZ4Ll+i3KEFG3ZTNO/Viz7UZK8QlVQfVL9bq2sEsT78QXltDhW9RpZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783211013; c=relaxed/simple;
	bh=WOMewBksneim7rrXBzckalXWJzmmfWlcZbnBub2VddQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=JZpQGB4DYfXSzkOvqa+0sg2wEYo2IwMAIQwTNummYitHwgUAvNWZvGSCM0W0KfPdBMcOJnfxQjxSJ6iNblBd9G9QFodGvFzoLPis52PkwPZgkdPFeycEzvJ4QLm0kufSdHcx2kk5Guc355JdGiDTJZe4ZyEQnv0NYZzN/0dJfKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyn.dk; spf=pass smtp.mailfrom=lyn.dk; arc=none smtp.client-ip=85.119.82.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyn.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyn.dk
Received: from [172.22.32.166] (unknown [91.229.203.95])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.itlods.dk (Postfix) with ESMTPSA id 3377B260904
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 02:21:14 +0200 (CEST)
Message-ID: <bb2a925e-0b01-4e12-88ed-44deea0c90a1@lyn.dk>
Date: Sun, 5 Jul 2026 02:21:13 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: Kurt Mielke <scr@lyn.dk>
Subject: CARGO trouble appeared from 2.54.0 to 2.55.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi


I had a clean alma10 and wanted the newest git BUT building fails:

make

....

     CC version.o
     AR libgit.a
     CARGO target/release/libgitcore.a
/bin/sh: line 1: cargo: command not found
make: *** [Makefile:3021: target/release/libgitcore.a] Error 127

I got 2.54.0 and it compiled just fine

I found out CARGO is rust related

Changing make command to

make NO_RUST=1

And I got my 2.55.0 version, but allow me to suggest it again is the default

II have no caommands in path beginning with the letters 'rus'

Thank you in advance

Kirt Mielke

