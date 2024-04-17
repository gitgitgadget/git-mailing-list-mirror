Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF3252F89
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 05:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713332310; cv=none; b=A9gnPdBcbPZjUEPOkeHySCjf7gOaSSxrs3v5mmbbIMxvzBN/35qeqCdjzhZAUIzo5UXdpP1ePA73M5L5A4YNja9LhPHXlQ99v63hvWV05+wdKsX8lB5qKyfrViKC/vBFcdyO3K5KZS2jwhAub9lWOWv8+Dp13vaeXL6CL0Mr3sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713332310; c=relaxed/simple;
	bh=dFlu6aMUVzCREkPHnukc32pM0ZpoBQXQVLH05MaM9dk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jzTwwsvUGgqTdo1Unq+HVf/7PDFU0s1xIcDnOxIpYKJDrYsP4RwtSNBNrTNH/OSr2CF+GSURobNAn6o7WQEPuSOeJ9u5e0C1u3yy36UHKLjClMDiSk83wHC3OWtpWh+LNNKeAkfKKum2ilNmF6P8ORElQB0YoaKi8krAhH9pxmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ajjGdoNf; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ajjGdoNf"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E59E1D594;
	Wed, 17 Apr 2024 01:38:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dFlu6aMUVzCREkPHnukc32pM0ZpoBQXQVLH05M
	aM9dk=; b=ajjGdoNfOyooOZzB3vdt7u+EnfBK8FHbTald8xnkSaSKtFJC+83j0A
	xEaRCE4rugYJcGmdLhopJqGaAj7WnChPj6ACwVA03w9zFnY+i57a1E1UttIKlLE8
	q5I3wkC8cYMKhx3I/EYKZ2F8NhYC0Wl/nP4dbYYh3e4PzO/Y1VbC4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 45AF31D593;
	Wed, 17 Apr 2024 01:38:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0370B1D590;
	Wed, 17 Apr 2024 01:38:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Jonathan Tan <jonathantanmy@google.com>,  Emily Shaffer
 <nasamuffin@google.com>,  Patrick Steinhardt <ps@pks.im>,  Matthieu Moy
 <git@matthieu-moy.fr>,  Eric Sunshine <sunshine@sunshineco.com>,  Kipras
 Melnikovas <kipras@kipras.org>
Subject: Re: [PATCH v4 2/8] SubmittingPatches: clarify 'git-contacts' location
In-Reply-To: <xmqqfrvkd843.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	16 Apr 2024 19:40:44 -0700")
References: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
	<pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
	<c43de19d867cb5e63fe6689b2b7d645dc4741950.1712878339.git.gitgitgadget@gmail.com>
	<xmqqsezqmrtd.fsf@gitster.g> <owly34rl53mr.fsf@fine.c.googlers.com>
	<xmqqjzkwdigv.fsf@gitster.g> <owlyzfts52ln.fsf@fine.c.googlers.com>
	<xmqqfrvkd843.fsf@gitster.g>
Date: Tue, 16 Apr 2024 22:38:15 -0700
Message-ID: <xmqq8r1cczw8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B0F9056E-FC7C-11EE-A3A1-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> We are not installing this thing (yet), so how about giving an
> instruction to run "perl contrib/contacts/git-contacts", only
> assuming that the user is intelligent enough to be able to react to
> "perl: not found" by installing it on their path?

That is, something like this, perhaps.

As the string given to --cc-cmd is stored in $cc_cmd, and is used in
this call:

	push @cc, recipients_cmd("cc-cmd", "cc", $cc_cmd, $t, $quiet)

where recipients_cmd takes ($prefix, $what, $cmd, $file, $quiet) and
runs execute_cmd($prefix, $cmd, $file).  execute_cmd in turn takes
($prefix, $cmd, $file) and does this:

	open my $fh, "-|", "$cmd \Q$file\E"
		or die sprintf(__("(%s) Could not execute '%s'"), $prefix, $cmd);

IOW, $cmd is just an early part of a shell command line that takes a
filename as its last argument, so I think it would be fine for $cmd
to be "perl contrib/contacts/git-contacts".  I did not test it, and
it would be appreciated if people can test it.



 Documentation/MyFirstContribution.txt | 6 +++---
 Documentation/SubmittingPatches       | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git c/Documentation/MyFirstContribution.txt w/Documentation/MyFirstContribution.txt
index 9665951aeb..9eb6b98a82 100644
--- c/Documentation/MyFirstContribution.txt
+++ w/Documentation/MyFirstContribution.txt
@@ -1118,12 +1118,12 @@ valuable, such as changing the Reply-to address or adding more CC and BCC lines.
 
 :contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are +
 not part of the core `git` binary and must be called directly. Clone the Git +
-codebase and run `contrib/contacts/git-contacts` (you must have Perl installed +
-in your system).]
+codebase and run `perl contrib/contacts/git-contacts` (you must have Perl +
+installed in your system).]
 
 NOTE: If you're not sure whom to CC, running `contrib/contacts/git-contacts` can
 list potential reviewers. In addition, you can do `git send-email
---cc-cmd='contrib/contacts/git-contacts' feature/*.patch`{contrib-scripts} to
+--cc-cmd='perl contrib/contacts/git-contacts' feature/*.patch`{contrib-scripts} to
 automatically pass this list of emails to `send-email`.
 
 NOTE: When you are sending a real patch, it will go to git@vger.kernel.org - but
diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
index b616422197..1099040d7e 100644
--- c/Documentation/SubmittingPatches
+++ w/Documentation/SubmittingPatches
@@ -407,8 +407,8 @@ mailing list{security-ml}, instead of the public mailing list.
 
 :contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are +
 not part of the core `git` binary and must be called directly. Clone the Git +
-codebase and run `contrib/contacts/git-contacts` (you must have Perl installed +
-in your system).]
+codebase and run `perl contrib/contacts/git-contacts` (you must have Perl +
+installed in your system).]
 
 Send your patch with "To:" set to the mailing list, with "cc:" listing
 people who are involved in the area you are touching (the `git-contacts`
@@ -422,7 +422,7 @@ If you are using `send-email`, you can feed it the output of `git-contacts` like
 this:
 
 ....
-	git send-email --cc-cmd='contrib/contacts/git-contacts' feature/*.patch
+	git send-email --cc-cmd='perl contrib/contacts/git-contacts' feature/*.patch
 ....
 
 :current-maintainer: footnote:[The current maintainer: gitster@pobox.com]
