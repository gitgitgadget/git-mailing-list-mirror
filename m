Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F7342047F
	for <e@80x24.org>; Mon, 18 Sep 2017 14:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754315AbdIROZF (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 10:25:05 -0400
Received: from mout.gmx.net ([212.227.15.15]:52156 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754129AbdIROZE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 10:25:04 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M2Ldk-1db2e83YDk-00s3XI; Mon, 18
 Sep 2017 16:24:45 +0200
Date:   Mon, 18 Sep 2017 16:24:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Ben Peart <benpeart@microsoft.com>
cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        pclouds@gmail.com, peff@peff.net
Subject: Re: [PATCH v6 12/12] fsmonitor: add a performance test
In-Reply-To: <20170915192043.4516-13-benpeart@microsoft.com>
Message-ID: <alpine.DEB.2.21.1.1709181615040.219280@virtualbox>
References: <20170610134026.104552-1-benpeart@microsoft.com> <20170915192043.4516-1-benpeart@microsoft.com> <20170915192043.4516-13-benpeart@microsoft.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:J3hG/gQA8PuRQ3DWU4lUK3p/mY4EZJ77LJM6YPiokf1zbt87rHM
 fCDWIW4TRRVjJyuc4GF6HCibSFvORoF4cJ3Eif7gayt30IzgzZEbjtLDkjeefkuTcjN5YmB
 aDGAtSJ6PiXUB5idHfKpMCo6TV9vNOmXmnAXNVj0CRT4ZPdc/2mzu256Rq8TxTPgEFYMQDW
 T1MjZxApP35WEmHQ40suw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:P8/ZR1dzutU=:ujjpTIlhGzscc253b0cVQZ
 b8QlO5e/E0dvTwVAWWf2Fd/1oQdHpwnJANtjqV/r+z+i6AyJ7VyY3nzL9oyqAx7tVFjgXT3q4
 T1DzHXPN+7Ep2G+8EH5jvl/ks8BMbaF9nmb1wFHe6ywEcVkd+Q5BxjrBi5cgMag/eqfwY6w/F
 44IdNTeqPUUJocLyselP3HSKqQQbLSedDhU71/jq4XY56Wr6jL0bGtl6ixmb+3uDr18LgolIn
 aFr5UpErgu3bX/j2IYInPkWu57IfCz9nLg3rbk5UVyxj+Dybl0zZoIX9EPsswTmGcItarMWFz
 bQV7bcj9S/mg9bNaLxPd9ty/CCfRpZ/JENfFeFkCuu0lzbJL/fOOnN88Sz8Q+TnPoWN2RmW2w
 OgzWjSx7BM82/rR3gKJRNE1xcmt9v/QoP8DPHJ5jHQiw8b5fMJDt6Z4DYEB567YPOWJOTfr95
 YaWU7ekW4DiGGWzWA1UJZUpBImkT1VfZCEt5orEcKoPeEV4MVDtXQnf0TqM/6U1ZHBTx1s0I4
 eD7vhTCR0/pkHkeCuwkuBDCuX0R+CU8aPMovUlfJCt2yHYB4YP84E4FE0mMtS2ykeCZqczgWx
 YrgP4Vgru+EDav756DSfcVPPJwDv4TFtrlRCg88B8oGHQa6ho901FICiXwT9ejPCKBunnAWdc
 j/fCmTOfesCAq5hUNsZf6C/Yd0FFg4OoGbrTcwfe1pUEHSjOkH03UL/eUy/39E5aiHa/nkvo/
 FOE5P2sI3a6FYNAvcqboHxyStEnG8lLDVhthnHjIEowD/mdy2FVImDQeruVKDpHzYfYpqUCMA
 Zkp8hN0wY1+lLEBbRzU2wpOG3aUhfz14qx4RVgiyXZHk9FF7FQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

sorry for not catching this earlier:

On Fri, 15 Sep 2017, Ben Peart wrote:

> [...]
> +
> +int cmd_dropcaches(void)
> +{
> +	HANDLE hProcess = GetCurrentProcess();
> +	HANDLE hToken;
> +	int status;
> +
> +	if (!OpenProcessToken(hProcess, TOKEN_QUERY | TOKEN_ADJUST_PRIVILEGES, &hToken))
> +		return error("Can't open current process token");
> +
> +	if (!GetPrivilege(hToken, "SeProfileSingleProcessPrivilege", 1))
> +		return error("Can't get SeProfileSingleProcessPrivilege");
> +
> +	CloseHandle(hToken);
> +
> +	HMODULE ntdll = LoadLibrary("ntdll.dll");

Git's source code still tries to abide by C90, and for simplicity's sake,
this extends to the Windows-specific part. Therefore, the `ntdll` variable
needs to be declared at the beginning of the function (I do agree that it
makes for better code to reduce the scope of variables, but C90 simply did
not allow variables to be declared in the middle of functions).

I wanted to send a patch address this in the obvious way, but then I
encountered these lines:

> +	DWORD(WINAPI *NtSetSystemInformation)(INT, PVOID, ULONG) =
> +		(DWORD(WINAPI *)(INT, PVOID, ULONG))GetProcAddress(ntdll, "NtSetSystemInformation");
> +	if (!NtSetSystemInformation)
> +		return error("Can't get function addresses, wrong Windows version?");

It turns out that we have seen this plenty of times in Git for Windows'
fork, so much so that we came up with a nice helper to make this all a bit
more robust and a bit more obvious, too: the DECLARE_PROC_ADDR and
INIT_PROC_ADDR helpers in compat/win32/lazyload.h.

Maybe this would be the perfect excuse to integrate this patch into
upstream Git? This would be the patch (you can also cherry-pick it from
25c4dc3a73352e72e995594cf1b4afa46e93d040 in https://github.com/dscho/git):

-- snip --
From 25c4dc3a73352e72e995594cf1b4afa46e93d040 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Tue, 10 Jan 2017 23:14:20 +0100
Subject: [PATCH] Win32: simplify loading of DLL functions

Dynamic loading of DLL functions is duplicated in several places in Git
for Windows' source code.

This patch adds a pair of macros to simplify the process: the
DECLARE_PROC_ADDR(<dll>, <return-type>, <function-name>,
...<function-parameter-types>...) macro to be used at the beginning of a
code block, and the INIT_PROC_ADDR(<function-name>) macro to call before
using the declared function. The return value of the INIT_PROC_ADDR()
call has to be checked; If it is NULL, the function was not found in the
specified DLL.

Example:

        DECLARE_PROC_ADDR(kernel32.dll, BOOL, CreateHardLinkW,
                          LPCWSTR, LPCWSTR, LPSECURITY_ATTRIBUTES);

        if (!INIT_PROC_ADDR(CreateHardLinkW))
                return error("Could not find CreateHardLinkW() function";

	if (!CreateHardLinkW(source, target, NULL))
		return error("could not create hardlink from %S to %S",
			     source, target);
	return 0;

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/win32/lazyload.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 compat/win32/lazyload.h

diff --git a/compat/win32/lazyload.h b/compat/win32/lazyload.h
new file mode 100644
index 00000000000..91c10dad2fb
--- /dev/null
+++ b/compat/win32/lazyload.h
@@ -0,0 +1,44 @@
+#ifndef LAZYLOAD_H
+#define LAZYLOAD_H
+
+/* simplify loading of DLL functions */
+
+struct proc_addr {
+	const char *const dll;
+	const char *const function;
+	FARPROC pfunction;
+	unsigned initialized : 1;
+};
+
+/* Declares a function to be loaded dynamically from a DLL. */
+#define DECLARE_PROC_ADDR(dll, rettype, function, ...) \
+	static struct proc_addr proc_addr_##function = \
+	{ #dll, #function, NULL, 0 }; \
+	static rettype (WINAPI *function)(__VA_ARGS__)
+
+/*
+ * Loads a function from a DLL (once-only).
+ * Returns non-NULL function pointer on success.
+ * Returns NULL + errno == ENOSYS on failure.
+ */
+#define INIT_PROC_ADDR(function) \
+	(function = get_proc_addr(&proc_addr_##function))
+
+static inline void *get_proc_addr(struct proc_addr *proc)
+{
+	/* only do this once */
+	if (!proc->initialized) {
+		HANDLE hnd;
+		proc->initialized = 1;
+		hnd = LoadLibraryExA(proc->dll, NULL,
+				     LOAD_LIBRARY_SEARCH_SYSTEM32);
+		if (hnd)
+			proc->pfunction = GetProcAddress(hnd, proc->function);
+	}
+	/* set ENOSYS if DLL or function was not found */
+	if (!proc->pfunction)
+		errno = ENOSYS;
+	return proc->pfunction;
+}
+
+#endif
-- snap --

With this patch, this fixup to your patch would make things compile (you
can also cherry-pick d05996fb61027512b8ab31a36c4a7a677dea11bb from my
fork):

-- snipsnap --
From d05996fb61027512b8ab31a36c4a7a677dea11bb Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Mon, 18 Sep 2017 14:56:40 +0200
Subject: [PATCH] fixup! fsmonitor: add a performance test

---
 t/helper/test-drop-caches.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
index 717079865cb..b27358528f7 100644
--- a/t/helper/test-drop-caches.c
+++ b/t/helper/test-drop-caches.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 
 #if defined(GIT_WINDOWS_NATIVE)
+#include "compat/win32/lazyload.h"
 
 int cmd_sync(void)
 {
@@ -82,6 +83,9 @@ int cmd_dropcaches(void)
 	HANDLE hProcess = GetCurrentProcess();
 	HANDLE hToken;
 	int status;
+	SYSTEM_MEMORY_LIST_COMMAND command;
+	DECLARE_PROC_ADDR(ntll,
+			  DWORD, NtSetSystemInformation, INT, PVOID, ULONG);
 
 	if (!OpenProcessToken(hProcess, TOKEN_QUERY | TOKEN_ADJUST_PRIVILEGES, &hToken))
 		return error("Can't open current process token");
@@ -91,16 +95,10 @@ int cmd_dropcaches(void)
 
 	CloseHandle(hToken);
 
-	HMODULE ntdll = LoadLibrary("ntdll.dll");
-	if (!ntdll)
-		return error("Can't load ntdll.dll, wrong Windows
 		version?");
-
-	DWORD(WINAPI *NtSetSystemInformation)(INT, PVOID, ULONG) =
-		(DWORD(WINAPI *)(INT, PVOID, ULONG))GetProcAddress(ntdll,
 		"NtSetSystemInformation");
-	if (!NtSetSystemInformation)
+	if (!INIT_PROC_ADDR(NtSetSystemInformation))
 		return error("Can't get function addresses, wrong Windows version?");
 
-	SYSTEM_MEMORY_LIST_COMMAND command = MemoryPurgeStandbyList;
+	command = MemoryPurgeStandbyList;
 	status = NtSetSystemInformation(
 		SystemMemoryListInformation,
 		&command,
@@ -111,8 +109,6 @@ int cmd_dropcaches(void)
 	else if (status != STATUS_SUCCESS)
 		error("Unable to execute the memory list command %d", status);
 
-	FreeLibrary(ntdll);
-
 	return status;
 }
 
-- 
2.14.1.windows.1.510.g0cb6d35d23
