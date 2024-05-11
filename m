Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AB47F
	for <git@vger.kernel.org>; Sat, 11 May 2024 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715445805; cv=none; b=LGjmAoXWhMBniDc+OMaq44eg9HCNCiw8CX2VgelFjRAq0DO6jMpoikGaBxsbUwsTL0dQHGepx3w7qnEVwLQ8z4jHcC3yDHEKPDQNkCAwiw/QOIndcliLiawMsy0YlPBYksoVhPojj2tq1+jIXczdwJRXtQiTLG+juBNSuw4nvus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715445805; c=relaxed/simple;
	bh=lX9oXc8b8SbSKJDajdn9HMDGBfvxc7MLtLBiAssalhM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oS+s9piepTPWVbu87xncc5mIyoOq29NlGgaqQ9FjT9+ca/PIDA8IlgTfCu1uki+sIOdoWbDBpSCIfAqxhLTxUeQYCbOQKssk76usAgcnWr6jQnkYywIRQXosK5LN5Y5q/0Tq3F/koSjkNrdXkAdMVNl2Cne3H5yeNX6+E8dWx9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NvtdbMrb; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NvtdbMrb"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 62F991D9C3;
	Sat, 11 May 2024 12:43:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lX9oXc8b8SbSKJDajdn9HMDGBfvxc7MLtLBiAs
	salhM=; b=NvtdbMrb9zfc2DZKCspeG+YaGHjKKq7pcz+NvQy0qgnkj7noj+an8o
	Xi8kv7xs0tAGC0QvXQlZHg6GlbJfrNQKR/Ey1wt2fEB4kURgrd3IzH6rLLj6v1iZ
	CK51dm/fyAEZKREyTGbjJWz4LwqEhZR7Yzrwn2RJUX6uttsev3eHU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CCD51D9C2;
	Sat, 11 May 2024 12:43:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AAEB61D9C1;
	Sat, 11 May 2024 12:43:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Pratyush Yadav <me@yadavpratyush.com>,  Git Mailing List
 <git@vger.kernel.org>
Subject: Re: Git-GUI change of maintainership
In-Reply-To: <25c0ec11-4b20-4c78-ba77-8d10ca2ef21b@kdbg.org> (Johannes Sixt's
	message of "Sat, 11 May 2024 17:25:50 +0200")
References: <0241021e-0b17-4031-ad9f-8abe8e0c0097@kdbg.org>
	<mafs0r0eob610.fsf@yadavpratyush.com>
	<25c0ec11-4b20-4c78-ba77-8d10ca2ef21b@kdbg.org>
Date: Sat, 11 May 2024 09:43:20 -0700
Message-ID: <xmqqbk5c1eqf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 93EEE096-0FB5-11EF-8D12-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Johannes Sixt <j6t@kdbg.org> writes:

> I am about to apply the patch below to note the new maintainer.

Thanks.  I have these planned.


diff --git i/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
index 384893be1c..0690ae2140 100644
--- i/Documentation/SubmittingPatches
+++ w/Documentation/SubmittingPatches
@@ -545,9 +545,9 @@ not a text/plain, it's something else.
 Some parts of the system have dedicated maintainers with their own
 repositories.
 
-- `git-gui/` comes from git-gui project, maintained by Pratyush Yadav:
+- `git-gui/` comes from git-gui project, maintained by Johannes Sixt:
 
-	https://github.com/prati0100/git-gui.git
+        https://github.com/j6t/git-gui
 
 - `gitk-git/` comes from Paul Mackerras's gitk project:
 

diff --git a/MaintNotes b/MaintNotes
index b1f0e63..00ffa91 100644
--- a/MaintNotes
+++ b/MaintNotes
@@ -278,9 +278,9 @@ and enhancements in contrib/ area to the primary contributors of them.
 Although the following are included in git.git repository, they have their
 own authoritative repository and maintainers:
 
- - git-gui/ comes from git-gui project, maintained by Pratyush Yadav:
+ - git-gui/ comes from git-gui project, maintained by Johannes Sixt:
 
-        https://github.com/prati0100/git-gui.git
+        https://github.com/j6t/git-gui
 
  - gitk-git/ comes from Paul Mackerras's gitk project:
 
