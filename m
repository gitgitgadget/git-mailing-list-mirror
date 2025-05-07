Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0426476410
	for <git@vger.kernel.org>; Wed,  7 May 2025 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746612541; cv=none; b=V1V+kQTk0t2vYn36fcuHLxdfMVMOqhe3kjWQ3CnlWIOVxxiviOv2z4yGjTAMdvIov0aTqfTf0fZNKezKCnSrgpfA2f5O//YXLtMqUk8K7yQpOLZdPhiZ2EBtB9WCB/x3HuFOONssZTLAzHH4B7IwaLnmhI/OAP92h3DwY2nwHrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746612541; c=relaxed/simple;
	bh=M6pYuo5C9y5/pmHgSqKyFbukztkXoh/yfujJOBHRGfM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u3pZan5MDTAcq+6vSDwh+zqNkPyJ5POUg8ag0/SGvNRb6tyt9lwRnnHvRG/0hYj2jQaZ240OICkVTE20kQnMUJD80XrxNkWD6C/RdfzigJN52Cs8R+7k4g9u6W8WLOlH29NnEoqtw6EZN2vfsrI5tPk93zpOHThu2CSopAhP5OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=54dbhUBd; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="54dbhUBd"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1746612534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=M6pYuo5C9y5/pmHgSqKyFbukztkXoh/yfujJOBHRGfM=;
	b=54dbhUBd8KaEIGnRnX3bfi1RzeQqIWQsfN1y+cHlI3sf2cWi12oClsrJPla1edSYtg7LL4
	lTQFOSV5DDMDzqk0XXg3lz5aR4B7JDWIKpiQVI9bTVtsekVo6M6YezhRNSuLctD6nzUbt0
	TeDIJa+tlg/LynqyPxMxAXHjMDUl+6I=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Subject: Celebrating Git's 20th Anniversary - A Token of Appreciation from
 GitLab
Date: Wed, 07 May 2025 12:08:24 +0200
Message-ID: <87jz6sivhj.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Dear Git Contributors,

Last month Git celebrated its 20th anniversary. This is a huge
milestone, and we at GitLab are grateful for your incredible engagement
with Git over the years! It's awesome that we've reached this 20-year
milestone together. Your contributions to the Git ecosystem have not
only shaped this powerful tool but also made platforms like GitLab
possible.

As Git celebrates its 20th anniversary this year, we at GitLab want to
express our gratitude for your contributions to the Git ecosystem that
has made our community possible.

To commemorate this milestone, we're offering active Git contributors a
special anniversary package containing Git-themed merchandise. You can
find it at: https://rewards.gitlab.com/kits/1008.

If you're interested in receiving such package, please send us an email
at: contributors@gitlab.com

Thank you for your ongoing support and engagement!


Toon Claes
Senior Backend Engineer @ GitLab
