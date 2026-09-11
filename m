Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A822D4457B1
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789111052; cv=none; b=BReo/+ZwUQEx4qBSqSVkmZZC+x7ySI5wHaclk1l2GYiGmmCqb9uh2wZWyO5Axj642shAtwtT3nyJ3xJt70i33ALmpZq7puvJrUaCxJIK23ICPLg7/c7udNgjgNGeeU2uDeUFGf4ECfbwsz5+XLPXJXxlruqhBMp/ooGZfya7Kvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789111052; c=relaxed/simple;
	bh=7zu/pEXShZAXVbGmTJvVboW2pyoNGH+zmS1V0Gyjj1M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=uTlpUFwyNnydiMh2yYgQxNkH1Hbs8BECaRhXWlm23UheZkmu72H4p3rMF7qluZAc+VgfZkvRqCASfagHF9jVh65Rq3G2J/w+tmeWvVWg56rqG0YQCFMHSJ/IM9m4rPwVa3lZDkmEuiZsNR7wOZDzdAkQ6d4IIg5Ib5gpp3GeKYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.103])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4hh5TT0CYSz7QbWl
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 09:17:16 +0200 (CEST)
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4hh5TH2YpnzRpL1;
	Fri, 11 Sep 2026 09:17:07 +0200 (CEST)
Message-ID: <e391e55b-4a23-4b84-8a95-1136449cd171@kdbg.org>
Date: Fri, 11 Sep 2026 09:17:06 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johannes Sixt <j6t@kdbg.org>
Subject: [GIT PULL] gitk: discourage AI, color preference dialog
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit f1de86371cb85dd09d55070d139e5fcdc595f026:

  Merge branch 'spanish_pr_bis' of github.com:basuradeluis/gitkbis (2026-07-16 10:53:01 +0200)

are available in the Git repository at:

  https://github.com/j6t/gitk.git master

for you to fetch changes up to a6457acb0f56cc2de76bcc12a5d18217973fbba1:

  Merge branch 'js/prefs-color-buttons' (2026-09-04 17:08:34 +0200)

----------------------------------------------------------------
Johannes Sixt (8):
      gitk: set intitial colors of swatches using the available helper
      gitk: condense repetitive code around color buttons into foreach loops
      gitk: show color preferences on the button instead of the label
      gitk: use more natural language for labels of color preferences
      gitk: avoid constructing dialog titles from text pieces
      gitk: move UI for generic colors above diff colors
      gitk: discourage AI contributions
      Merge branch 'js/prefs-color-buttons'

 README.md |   7 ++--
 gitk      | 123 ++++++++++++++++++++++++++++++--------------------------------
 2 files changed, 63 insertions(+), 67 deletions(-)
