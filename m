Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794476932;
	b=YiaDK/Rz2DDKcQnFcGSdYdczlaSWF0LVKy9CmkqwrI90aGfWdqhoVpWu7FsiUiAlWZpi
	 wrp/q1EIw2NynAe0gPxelUbWigqxH1zQ0CYhw/23o0iQfLRLmXiRT5lK9XWOejgdkP6pl
	 D/39Q/6OhxC+Y2z/ZqZN1dcDLQa58lSaT/ZWLd984NKBpp/gO44xeXlRyBTmIbBM0mJyH
	 XEPMSpWXkdLNXyNa+wb8mZr+4XgobBNdfSwikEx4BWB0aAx0T8Y46wpONXwGNg1BE8pBm
	 ebnvupdm8PmfGiFnQa4xhS9UkdIvPnF4W1Xca2YsZummXbW3RUZ4o6dZd3UZcRlMkpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476932;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=22ikrKWD57g0oYjjW3Wofz/pXffK4bXljYi/Vx7olMI=;
	b=LSgFpWAhXThp64UG+o0HTeH8RhPuKgmF4pmojTQL3yiwfTb/3uwphwqcvC/DKfP4Psn6
	 B2tcSN0wQ4H27Iz3i7lGiyPO1H1fQHs1JBUhkxI5Oq0kf6H5X9TVhGPoh+u44KVUl76CV
	 Fy5yVN8xsnzJlDy4j3TjKAWHR4Tw0egA4ZseILbeoHYTdJtF8RHO+YjBqcmwecq7oPM7d
	 ZokG4kW/21HifbHgS4uBob8QdcFaXzwvF4bzaQ6YXipgKx4ugNbUaL656p9MuKHbHUYVW
	 qHZWj/PyGZGMIn8f9L71h+ht9ch+uN8ml5nqjnqQZyoFqDM8cUY43Bgxl+umyEfMtqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6SJ3wMj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078B8606A321
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6SJ3wMj
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794476931;
	b=lWAGD/kELp/XazolZev1xOGqhxXwSFHX1yPFPGERyfAixBSPtMrFpaOSzYY2o6O9Gtl6
	 wxNQ5weFH+T+7J3qqFAZzCPmqXGg0Po9mfBJ4YFIINLLix3YBP/eNQfzci+nw+vnSLpK6
	 uK4erAps2Os+kOsWUU4VcVx/cbIYpOr4QFBsrwwTWm0RiIE4VcGVDPQNFjkjOuiVyjFBw
	 fx0YtyxgLfUal9ZFlVgMrl8AIujxPocvqoGipnXbcYRswmpzol3sryO32+2nQOHIR6WWa
	 P+q5e3e95qKli7qa9NJt1H9infvjMyjVyOevgHe+cCZ19r8KBaZk5x76VMlG7v48FiA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794476931;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=22ikrKWD57g0oYjjW3Wofz/pXffK4bXljYi/Vx7olMI=;
	b=JEDF3mAOJG4fyTRJpn4NCIQfgbz0at0npNHaYBR86t55KZMOL6lrr+7VswePkuAc1ppe
	 RcNnLXHxLxV0c5u9arUi+WjRzISpIwUdx0GDzD4Ru82mEDi+993TYCsQNyeOjvf3TpdXQ
	 HiRD0tKzzQyQqBNKH+7OXnhr9bplQEEh+uLm8mBNciTQRZStwvvTKvlGaknRvyAiKYXN1
	 VDGfx5Pg//TYGTReLrAt2qkxSDCBUsNaW572PvYKMpTnpudz0TMl7PQYkZd8wK+rLPaBR
	 dD08drXmIN1+VB6bfI6C6aWZ+enCKintn5KH+2zLJIyucAc0JYgzwb84hEY7caGtuTA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 33FB21F00A05;
	Thu, 12 Nov 2026 09:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794476931;
	bh=22ikrKWD57g0oYjjW3Wofz/pXffK4bXljYi/Vx7olMI=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=n6SJ3wMjTK78BrZMVidG05C54OHx63vAD+z0Gpnhoo91qCQLJ1+hdN5OwT7UsPYQ7
	 jKurptDWz/kww9USpT379FE4Dx+xZye33oaZo5++CWZptKSYx+UZCimR+5GzaCp+9+
	 mL8vakDys4mqnsm18c4l8OCu4xzKeP/JZymj+eEdp2vl73Ebm8PTU9ri/uqAW7CbcB
	 ChzD0wFTsBOICGUdRJy8RP3C5JI1NsKKrSyGZL7feCPbYD81uPIZDlz7aOfxubUSPx
	 IjizQSWcyJNKLeHwRH/WrYK4ler4qKtz7AbkYhA3m9SSTFS5PeALAK93L6OevL9KJh
	 6brd0WkPnEwaw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 868BF49430;
	Thu, 12 Nov 2026 09:48:50 +0000 (UTC)
From: Mustafa Bayar via B4 Relay <devnull+mbayar.gitlab.com@kernel.org>
Date: Thu, 12 Nov 2026 10:48:41 +0100
Subject: [PATCH] ref-filter: fix double free when an object is missing
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-mb-ref-filter-missing-object-double-free-maint-v1-1-d6d56a3c8dbe@gitlab.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yWNwQ7CIBAFf6XZs5u4HDT6K8YDlEddU8AANSZN/
 12sxznMzEoVRVHpOqxU8NaqOXWQw0Djw6YJrL4zmaM5iYjh6LggcNC5oXDUWjVNnN0TY2OfFze
 DQwE4Wk2NL7DeBYjgLNSjry7rZx/e7n+uyy7/LrRtX9M8mmCSAAAA
X-Change-ID: 20261112-mb-ref-filter-missing-object-double-free-maint-9eadbfe11e71
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Mustafa Bayar <mbayar@gitlab.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794476930; l=3161;
 i=mbayar@gitlab.com; s=20261112; h=from:subject:message-id;
 bh=17NMEKwQrzxXBwY9i9TNeZiPlUzKGWgLZuhnC15Ryjc=;
 b=iOM2yA0Rlz2Y/aVunYcpa7j2Vu5sBTK24l/YZ3uKX58eHG78qV83Hj3cdIXkn0PKrekuny9/h
 alrxfQt9MgFDeysVvKsLvY8Dj9oiYORmaXLoCuBT0aX1IOBRItMoqAK
X-Developer-Key: i=mbayar@gitlab.com; a=ed25519;
 pk=y0gEEr1TaZuk0b9DG9SOBVMs0YNrf+G51ueJbMsIBCc=
X-Endpoint-Received: by B4 Relay for mbayar@gitlab.com/20261112 with
 auth_id=1496
X-Original-From: Mustafa Bayar <mbayar@gitlab.com>
Reply-To: mbayar@gitlab.com
Content-Transfer-Encoding: 7bit

From: Mustafa Bayar <mbayar@gitlab.com>

When a ref points to a missing object, git-for-each-ref(1) may abort
with a double free instead of reporting the missing object:

    free(): double free detected in tcache 2

get_object() frees `oi->content` but leaves the pointer unchanged. Since
the expand_data structures are reused across refs, a later call can
start with `content` pointing to a freed buffer. Then, if the object
lookup in that call fails before it overwrites the pointer, the cleanup
path frees the buffer a second time.

a29e2e8fe (ref-filter: parse objects on demand, 2025-10-23) introduced
this by making object lookup failures jump to the cleanup label.
bea37f1d6 (ref-filter: fix stale parsed objects, 2025-11-04) later fixed
a related stale-state bug by resetting `maybe_object`.

Similar to `maybe_object`, reset `content` at the start of get_object().
Add a regression test that exercises this path.

Signed-off-by: Mustafa Bayar <mbayar@gitlab.com>
---
This is based on maint, since the bug first appeared in v2.53.0.

We ran into this on GitLab.com, where a repository with a tag pointing
to a missing object made `git for-each-ref` abort instead of reporting
the missing object.

A note on the test: the double free only happens when a valid annotated
tag is processed before the broken ref, so that an earlier get_object()
call has already freed its content buffer. The test therefore names the
refs `annotated` and `missing`, which sort in that order.
---
 ref-filter.c                   |  1 +
 t/t6301-for-each-ref-errors.sh | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index bdf54f6f..6c4df521 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2349,6 +2349,7 @@ static int get_object(struct ref_array_item *ref, int deref,
 	int ret;
 
 	oi->maybe_object = NULL;
+	oi->content = NULL;
 
 	if (oi->info.contentp) {
 		/* We need to know that to use parse_object_buffer properly */
diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
index 72b27c8b..e955f66a 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -52,6 +52,21 @@ test_expect_success 'Missing objects are reported correctly' '
 	test_must_be_empty brief-err
 '
 
+test_expect_success 'missing objects after a tag are reported correctly' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit --no-tag initial &&
+		git tag -a -m annotated annotated &&
+		test-tool ref-store main update-ref msg refs/tags/missing "$MISSING" "$ZERO_OID" REF_SKIP_OID_VERIFICATION &&
+		git rev-parse HEAD >expect &&
+		test_must_fail git for-each-ref --format="%(*objectname)" refs/tags/ >actual 2>err &&
+		test_cmp expect actual &&
+		test_grep "fatal: missing object $MISSING for refs/tags/missing" err
+	)
+'
+
 test_expect_success 'missing ancestors are reported by contains filters' '
 	test_when_finished "git update-ref -d refs/heads/missing-parent" &&
 	{

---
base-commit: 03b41523c576f26ad34085378717a0c1b287470f
change-id: 20261112-mb-ref-filter-missing-object-double-free-maint-9eadbfe11e71


