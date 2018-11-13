Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5C8D1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 18:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbeKNEwC (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 23:52:02 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33184 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbeKNEwB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 23:52:01 -0500
Received: by mail-pf1-f194.google.com with SMTP id v68-v6so6527974pfk.0
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 10:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3SWzlfqz24EebsIPvIpVZPgld2xSVopb6XS5Jguk+Uo=;
        b=U4/pRebYSYDKZnn4kkb/P0bRLcIKSNxX1AoAc98Cm2unI1Jw4/6nRPCBibK7s7TyLb
         4wZpcuIPn9CjAWTtYYpt1xzRQqCHXb3hvNXkAiLfpQ1OO8rKrrkjfskpkrucPOOCNKKP
         ntnlyRIUIdFMYlNf9N14ONHP5L/tNhASWk3HC8lxhF0WxSJi70E3pWc6SkeNffjUpAg2
         lIGk9dt1n9SbXiV+NkJVVeDKnDPG2FI7TmycMFwYtx/aw9aJabXlHw963B8w+ngJrFQ0
         gdpVYblHPftfmhuYFwXI/QOH1Z074MLfa7SWjLqKRJ5xy4fEXkMkyhBj3Wm4bQs0IlYL
         /g/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3SWzlfqz24EebsIPvIpVZPgld2xSVopb6XS5Jguk+Uo=;
        b=fMIT8QAPaU66xMRfeu0smXt3R+iEnVpQkfV73WCWfvU95izBm4WejCAbOXPkpmAKax
         k6Fq3jpirbShzYFX/agj8Bodm0VreGYvc9oG+JLwPZBAXeYK0cGS0Ml1Qsh+Ad/+nlEc
         8M3uEMFiO29piBplKdJ9Z6x7+KEpC2Wi8G5njemNj7xzEskX4aGIqEi67N4Slj536h68
         k+ahEZK0GhVy2Axv8jIeWngLi1oZqOJIZZjuzeJH6eNb02AvB66MH3Jy5Vxs7lr0zsYA
         pxRKUP6k7d3nam5Y278AvVfFQ75mGue/Kf9+d3eCYNnY5VoXtOexyKBNtaQjBXfcDicd
         3GkQ==
X-Gm-Message-State: AGRZ1gIrkWtYs4JPyf5Wnr9CS8goZm1CtYLgAqODGdivBvY4BS4oCYry
        ty2Orhvcnl3O7z1QJOqWag5ogofT
X-Google-Smtp-Source: AJdET5ff5ALfuZ2IG2ElRkzlJ0Ny1uCIiEzAm+e2nQNnSxsZWYnyd9TT/f+SrKqBP9IlXDe74+3oOA==
X-Received: by 2002:a62:995c:: with SMTP id d89-v6mr6245338pfe.11.1542135156367;
        Tue, 13 Nov 2018 10:52:36 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id b5-v6sm23525194pfe.60.2018.11.13.10.52.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 10:52:35 -0800 (PST)
Date:   Tue, 13 Nov 2018 10:52:35 -0800 (PST)
X-Google-Original-Date: Tue, 13 Nov 2018 18:52:32 GMT
Message-Id: <315638630d27761ebdb7e7092ac347b17b9b30d4.1542135152.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.80.git.gitgitgadget@gmail.com>
References: <pull.80.git.gitgitgadget@gmail.com>
From:   "Loo Rong Jie via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] win32: replace pthread_cond_*() with much simpler code
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Loo Rong Jie <loorongjie@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Loo Rong Jie <loorongjie@gmail.com>

The Win32 CONDITION_VARIABLE has better performance and is easier to
maintain, as the code is a lot shorter now (the semantics of the
CONDITION_VARIABLE matches the pthread_cond_t very well).

Note: CONDITION_VARIABLE is not available in Windows XP and below,
but the declared minimal Windows version required to build and run
Git for Windows is Windows Vista (which is also beyond its
end-of-life, but for less long than Windows XP), so that's okay.

Signed-off-by: Loo Rong Jie <loorongjie@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/win32/pthread.c | 138 -----------------------------------------
 compat/win32/pthread.h |  28 +++------
 2 files changed, 7 insertions(+), 159 deletions(-)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index e18f5c6e2e..2e7eead42c 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -56,141 +56,3 @@ pthread_t pthread_self(void)
 	t.tid = GetCurrentThreadId();
 	return t;
 }
-
-int pthread_cond_init(pthread_cond_t *cond, const void *unused)
-{
-	cond->waiters = 0;
-	cond->was_broadcast = 0;
-	InitializeCriticalSection(&cond->waiters_lock);
-
-	cond->sema = CreateSemaphore(NULL, 0, LONG_MAX, NULL);
-	if (!cond->sema)
-		die("CreateSemaphore() failed");
-
-	cond->continue_broadcast = CreateEvent(NULL,	/* security */
-				FALSE,			/* auto-reset */
-				FALSE,			/* not signaled */
-				NULL);			/* name */
-	if (!cond->continue_broadcast)
-		die("CreateEvent() failed");
-
-	return 0;
-}
-
-int pthread_cond_destroy(pthread_cond_t *cond)
-{
-	CloseHandle(cond->sema);
-	CloseHandle(cond->continue_broadcast);
-	DeleteCriticalSection(&cond->waiters_lock);
-	return 0;
-}
-
-int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex)
-{
-	int last_waiter;
-
-	EnterCriticalSection(&cond->waiters_lock);
-	cond->waiters++;
-	LeaveCriticalSection(&cond->waiters_lock);
-
-	/*
-	 * Unlock external mutex and wait for signal.
-	 * NOTE: we've held mutex locked long enough to increment
-	 * waiters count above, so there's no problem with
-	 * leaving mutex unlocked before we wait on semaphore.
-	 */
-	LeaveCriticalSection(mutex);
-
-	/* let's wait - ignore return value */
-	WaitForSingleObject(cond->sema, INFINITE);
-
-	/*
-	 * Decrease waiters count. If we are the last waiter, then we must
-	 * notify the broadcasting thread that it can continue.
-	 * But if we continued due to cond_signal, we do not have to do that
-	 * because the signaling thread knows that only one waiter continued.
-	 */
-	EnterCriticalSection(&cond->waiters_lock);
-	cond->waiters--;
-	last_waiter = cond->was_broadcast && cond->waiters == 0;
-	LeaveCriticalSection(&cond->waiters_lock);
-
-	if (last_waiter) {
-		/*
-		 * cond_broadcast was issued while mutex was held. This means
-		 * that all other waiters have continued, but are contending
-		 * for the mutex at the end of this function because the
-		 * broadcasting thread did not leave cond_broadcast, yet.
-		 * (This is so that it can be sure that each waiter has
-		 * consumed exactly one slice of the semaphor.)
-		 * The last waiter must tell the broadcasting thread that it
-		 * can go on.
-		 */
-		SetEvent(cond->continue_broadcast);
-		/*
-		 * Now we go on to contend with all other waiters for
-		 * the mutex. Auf in den Kampf!
-		 */
-	}
-	/* lock external mutex again */
-	EnterCriticalSection(mutex);
-
-	return 0;
-}
-
-/*
- * IMPORTANT: This implementation requires that pthread_cond_signal
- * is called while the mutex is held that is used in the corresponding
- * pthread_cond_wait calls!
- */
-int pthread_cond_signal(pthread_cond_t *cond)
-{
-	int have_waiters;
-
-	EnterCriticalSection(&cond->waiters_lock);
-	have_waiters = cond->waiters > 0;
-	LeaveCriticalSection(&cond->waiters_lock);
-
-	/*
-	 * Signal only when there are waiters
-	 */
-	if (have_waiters)
-		return ReleaseSemaphore(cond->sema, 1, NULL) ?
-			0 : err_win_to_posix(GetLastError());
-	else
-		return 0;
-}
-
-/*
- * DOUBLY IMPORTANT: This implementation requires that pthread_cond_broadcast
- * is called while the mutex is held that is used in the corresponding
- * pthread_cond_wait calls!
- */
-int pthread_cond_broadcast(pthread_cond_t *cond)
-{
-	EnterCriticalSection(&cond->waiters_lock);
-
-	if ((cond->was_broadcast = cond->waiters > 0)) {
-		/* wake up all waiters */
-		ReleaseSemaphore(cond->sema, cond->waiters, NULL);
-		LeaveCriticalSection(&cond->waiters_lock);
-		/*
-		 * At this point all waiters continue. Each one takes its
-		 * slice of the semaphor. Now it's our turn to wait: Since
-		 * the external mutex is held, no thread can leave cond_wait,
-		 * yet. For this reason, we can be sure that no thread gets
-		 * a chance to eat *more* than one slice. OTOH, it means
-		 * that the last waiter must send us a wake-up.
-		 */
-		WaitForSingleObject(cond->continue_broadcast, INFINITE);
-		/*
-		 * Since the external mutex is held, no thread can enter
-		 * cond_wait, and, hence, it is safe to reset this flag
-		 * without cond->waiters_lock held.
-		 */
-		cond->was_broadcast = 0;
-	} else {
-		LeaveCriticalSection(&cond->waiters_lock);
-	}
-	return 0;
-}
diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index 1c164088fb..c6cb8dd219 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -32,27 +32,13 @@ typedef int pthread_mutexattr_t;
 #define pthread_mutexattr_settype(a, t) 0
 #define PTHREAD_MUTEX_RECURSIVE 0
 
-/*
- * Implement simple condition variable for Windows threads, based on ACE
- * implementation.
- *
- * See original implementation: http://bit.ly/1vkDjo
- * ACE homepage: http://www.cse.wustl.edu/~schmidt/ACE.html
- * See also: http://www.cse.wustl.edu/~schmidt/win32-cv-1.html
- */
-typedef struct {
-	LONG waiters;
-	int was_broadcast;
-	CRITICAL_SECTION waiters_lock;
-	HANDLE sema;
-	HANDLE continue_broadcast;
-} pthread_cond_t;
-
-extern int pthread_cond_init(pthread_cond_t *cond, const void *unused);
-extern int pthread_cond_destroy(pthread_cond_t *cond);
-extern int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex);
-extern int pthread_cond_signal(pthread_cond_t *cond);
-extern int pthread_cond_broadcast(pthread_cond_t *cond);
+#define pthread_cond_t CONDITION_VARIABLE
+
+#define pthread_cond_init(a,b) InitializeConditionVariable((a))
+#define pthread_cond_destroy(a) do {} while (0)
+#define pthread_cond_wait(a,b) return_0(SleepConditionVariableCS((a), (b), INFINITE))
+#define pthread_cond_signal WakeConditionVariable
+#define pthread_cond_broadcast WakeAllConditionVariable
 
 /*
  * Simple thread creation implementation using pthread API
-- 
gitgitgadget
