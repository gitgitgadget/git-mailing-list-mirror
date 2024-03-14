Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015C82E410
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710444869; cv=none; b=VfXeLQeWKKyyjVgBuGwuc7Fui8srcXeO/9G65dTSsvSWqrYEupGvSGsn9oco1cs1ml2Kh/1L4olccxNIOJNEzUrdqFWYd7LvHGds3W0KBX+wxswlVRyuj6+5NGP6xp6sexRoDyjYJEer0/rSdjTtEF8c8gbIPhrSSoKMIUWk9Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710444869; c=relaxed/simple;
	bh=uObKiqtWXmfYuOpFW9QRvIXOF20wHWncSRz88JlB5uU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sSsbwzGsaHIYIq5UyXEvpWsw6iZLrJbW8GhWF6hQBEwJbNY7SrSj/JqRPVD8TIRupuOsbYgBCtzF4vwuhbwfE4TT7sAn010EeXLd5Yzl+CzrGFHr4Vggh9b9cfGjR8V+xirZdroSkFAff3+SMFX5ywDpUtZ/wPKuFXGyelx6rG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=y0OEoqAG; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="y0OEoqAG"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710444865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FMONbzarC+c427zSam2PTpN6BHHTUCTFS73o73N/gBk=;
	b=y0OEoqAGl8J/tkXHugYnrXGKVnNwx+8anCoS8F+6nhhke5eq8puAmIvVn94oWmC06Su39t
	tf6Ad942JVj6yfuglrBEJ+YkYPpVoJgP4aEvhmxRGumcX9f3JXm8/nTNM5ha2UoFkp4Pqw
	x+DK4N4he6Gkq6wCiS+ye9KheYnl/7nJUd5sogNks0N6V0eyfdsPeh3VkH8lTd9UX4hSTQ
	EjcUqn/Ve+vZmqDcHJl6vQOzSY1aScp52L2u5peQ8NTVZc/QeCEGDrqC+ymYIiuydYuHTj
	Go7ur4KwuAn0CYExIzCdcJn8PZGbsnugDVa8ryVS7QQ+UWmAj5rjGRLRDQm5nw==
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: [PATCH] config.txt: perform some minor reformatting
Date: Thu, 14 Mar 2024 20:34:21 +0100
Message-Id: <97bdaf075bf5a68554cca1731eca78aff2662907.1710444774.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Reformat a few lines a bit, to utilize the available horizontal space better.
There are no changes to the actual contents of the documentation.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    This patch, in a slightly less extensive form, previously belonged to
    a small series. [1]  After some discussion, [2] this patch was taken out
    of the series, because the cleanups it introduces are rather unrelated
    to the future purpose of the series. [3]
    
    [1] https://lore.kernel.org/git/d50c0f22c41ec36b574e1ff67e68485d9a6f2a84.1710258538.git.dsimic@manjaro.org/
    [2] https://lore.kernel.org/git/f7fa6d9bc9835ad1139bced5ea2b20b3@manjaro.org/T/#u
    [3] https://lore.kernel.org/git/f7fa6d9bc9835ad1139bced5ea2b20b3@manjaro.org/T/#mde1232c9e30b237e425fce9a0810d31e3a56ba2b

 Documentation/config.txt | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 782c2bab906c..450424ee830e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -57,11 +57,11 @@ compared case sensitively. These subsection names follow the same
 restrictions as section names.
 
 All the other lines (and the remainder of the line after the section
-header) are recognized as setting variables, in the form
-'name = value' (or just 'name', which is a short-hand to say that
-the variable is the boolean "true").
-The variable names are case-insensitive, allow only alphanumeric characters
-and `-`, and must start with an alphabetic character.
+header) are recognized as setting variables, in the form 'name = value'
+(or just 'name', which is a short-hand to say that the variable is the
+boolean "true").  The variable names are case-insensitive, allow only
+alphanumeric characters and `-`, and must start with an alphabetic
+character.
 
 A line that defines a value can be continued to the next line by
 ending it with a `\`; the backslash and the end-of-line are
@@ -95,10 +95,10 @@ to be included. The variable takes a pathname as its value, and is
 subject to tilde expansion. These variables can be given multiple times.
 
 The contents of the included file are inserted immediately, as if they
-had been found at the location of the include directive. If the value of the
-variable is a relative path, the path is considered to
-be relative to the configuration file in which the include directive
-was found.  See below for examples.
+had been found at the location of the include directive.  If the value of
+the variable is a relative path, the path is considered to be relative to
+the configuration file in which the include directive was found.  See
+below for examples.
 
 Conditional includes
 ~~~~~~~~~~~~~~~~~~~~
