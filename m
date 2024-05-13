Received: from mx1.net9.cf (mx1.net9.cf [185.106.120.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B221EAC0
	for <git@vger.kernel.org>; Mon, 13 May 2024 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.106.120.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715636230; cv=none; b=kbHSs0muM/srN3gaNocUtl06lk3ZDmdKKFpQi2/JtBuwAqm7f7P1Q8VYjk/exOckrQVbA05BC4tuyClLdh3/oOYhFLaTbfA+FjTQHMWkDYNpIOP6x9TY88htTYXav2DUc2MpcNb/Ur1TWWfRdX7bLbozuLLrHjBRUDwNz1jKSCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715636230; c=relaxed/simple;
	bh=CaZAHdALHl1Xo/DflxFeucCG/tyI/5CG5rCCgablLVU=;
	h=Date:To:Subject:Message-Id:From; b=SGEDdNJ3fJKmwozTk0kME8TSDr1ApnnUt6cX4sGL3ZnnqO+5s0ZClVvJGqr2ATnTkGvD/72LtmAt95nGjyvVvdez9wIC2nm3XAiviCJOCa5KSoFt1WhLk/iyqhPZYel++pypkl/TUlZHoAYD61plYLshzAkO7hBgtnh7hGYb6DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net9.cf; spf=none smtp.mailfrom=net9.cf; arc=none smtp.client-ip=185.106.120.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net9.cf
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=net9.cf
Received: from u34 by mx1.net9.cf with local (@Mail Server)
	(envelope-from <u34@net9.cf>)
	id 1s6cl5-0003nc-3D
	for git@vger.kernel.org;
	Mon, 13 May 2024 20:58:55 +0000
Date: Mon, 13 May 2024 20:58:55 +0000
To: git@vger.kernel.org
Subject: Options to have git log presents commits of a non linear
 history in a meaningful order
User-Agent: s-nail v14.9.24
Message-Id: <E1s6cl5-0003nc-3D@mx1.net9.cf>
From: u34@net9.cf
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>

Am I right by default, git log present commits of a non linear history in
a meaningles order? Am I right git log has options, such as --graph, to 
get the order of commits presented in a more meaningful way?

As of git 2.45.0, gittutorial states 
    
   The git log command has a weakness: it must present commits in
   a list. When the history has lines of development that
   diverged and then merged back together, the order in which git
   log presents those commits is meaningless.

Is it accurate?

--
u34
