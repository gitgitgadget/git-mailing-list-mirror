Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734D6340DAE;
	Tue, 19 Aug 2025 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611859; cv=pass; b=twW3ib36TdZYNbgp+iW4+EZVTy0bKij+gGLSWdD5F2cfg/TBxXs6aHKghl2rFTlUUF4uk9U1e/uGdvr2CHjHE3L7yQ1+RYiXQVJ7BuKLWJa5HCxQTOTCfcavB1tyfOBNpp4WpO3LeiWGaQzkTrqtu2mGfKt77e1/Cmn5xk+G98Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611859; c=relaxed/simple;
	bh=/u5Ee+2oMY6FMONv07SJaZVrVSz86ClpSDAzVozXbMA=;
	h=Date:From:To:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=qJQgeajvlHLL3fFO8d0J02lLmIHuMX33jEDws7IGuiPlai6vUH7WEqMSZBMvLskiNUjLV5vB1cMb7S3cqm+CzlhIRflm1qnNJFFoGo262WouhKRi6DFSYPuPEUlJGuB+Iasc9Fgn7t0mrZAnBzU/3/Rvunnu/RvWmIWhBhtpX3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=NdKKkhb9; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="NdKKkhb9"
ARC-Seal: i=1; a=rsa-sha256; t=1755611829; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KLJKOj7wNcVYwJ/KY8Ac53Dn4ayb8EzsNRhSExYL/FYVLidzB13YmCjzhSyYJl5CdnlbfRF48Uxy9Jw/C5nX1d6ipzgrH+PeErOHZl+h1blquFyINajYPb+WDA9NaEvRTZtskHQBpJXAG7D9kDnfguwG/SazJ/9ohSYgjjH1ATw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755611829; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=/u5Ee+2oMY6FMONv07SJaZVrVSz86ClpSDAzVozXbMA=; 
	b=RoKm2StobtTXHs6nKP8OYaKvvvIgurA9bkUtFG5TRzdnQm/Goc6fzy2I0IUrRB8Yw9KYtBtW1ah1HOGLr9p25KUuhcHVaL1E20zBwKk6y1Sx8GbvWxU97xQfLNlolui12Kju2tLdwYp6zHk9IoYp+dpUaXP05xLJXt8bUx/utvk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755611829;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To:Cc;
	bh=/u5Ee+2oMY6FMONv07SJaZVrVSz86ClpSDAzVozXbMA=;
	b=NdKKkhb9GDqr3pl6WielOVJs2gA5Q/zXnXUA9iFOGyvNd6Y8b7d4e72NhN342iGf
	nVXRPJYX42q4WJclxFsV53N6RyzECE06La366hYV3oPaAa4uFq6quwI1M/gqcksFPnd
	5UFne8KTabPEmlGdlx+S95saxuWmGTgVPyNfAqP8=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1755611828327196.99370704706973; Tue, 19 Aug 2025 06:57:08 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Tue, 19 Aug 2025 06:57:08 -0700 (PDT)
Date: Tue, 19 Aug 2025 17:57:08 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "git" <git@vger.kernel.org>, "gitster" <gitster@pobox.com>,
	"helpdesk" <helpdesk@kernel.org>,
	"kernelnewbies" <kernelnewbies@kernelnewbies.org>,
	"kernel-janitors" <kernel-janitors@vger.kernel.org>,
	"linux-doc" <linux-doc@vger.kernel.org>
Message-ID: <198c29e9058.119e3a5c065010.5888624019176274871@zohomail.com>
In-Reply-To: 
Subject: git: list of my complaints about future graft removal
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr08011227f3b7956650712fa76dd750ec000041389be543ffda8140eb467d40bd94f0665362ddbc9c02225b:zu08011227b3f45efc54d3316da1dc20db00003685f09e47a9bc1a98f3e666c7e1b3fc9ee97412dc08315d7e:rf0801122c39bd46176ce042e9e17b1f02000053356318c787fe63794ac9cbd4949f841d80c0a8c17808e0303302435f41:ZohoMail

Hi.

I just have read in https://github.com/git/git/blob/v2.51.0/Documentation/BreakingChanges.adoc that
git grafts will be removed in git 3.0.

Let me share my list of complaints/objections/thoughts about this.

(And also some info for kernel.org admins.)

* As well as I understand, Linux history repo
( https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/ )
relies on grafts. It is supposed that whoever clones that repo,
should manually graft latest commit of history repo with earliest commit
of main Linux history. Also that person should graft two other commits of history
repo (as well as I understand).

So, git and/or kernel.org people, please, ensure that this history repo
will continue to work after removal of grafts.

Also, currently this is very hard to discover how to get full Linux
history. If we type "how to get unified linux kernel git history"
to Google, we will get this answer:
https://stackoverflow.com/a/8130239 ,
which also points to this link:
https://archive.org/details/git-history-of-linux .

Both these links rely on grafts.
So, please, make sure that whoever types "how to get unified linux kernel git history"
into Google will get modern instructions in top links,
which do not rely on grafts.

Again: I strongly think that we should not remove graft support
until https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/
is made compatible with "git replace".
history.git is valuable repo, and I think a lot of people use history.git .

Git release notes for 3.0 should mention how to get history.git
working without grafts.

* As well as I understand, "git clone --depth=1" rely on grafts, too.
I hope "git clone --depth=1" will continue to work.

--
Askar Safin
https://types.pl/@safinaskar

