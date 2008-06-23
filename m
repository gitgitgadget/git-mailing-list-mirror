From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: MinGW port pull request
Date: Mon, 23 Jun 2008 13:54:44 +0200
Message-ID: <485F8F04.6090802@viscovery.net>
References: <485B6510.3080201@viscovery.net> <7vskv79l37.fsf@gitster.siamese.dyndns.org> <200806212318.47745.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Jun 23 13:56:00 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yx-out-2122.google.com ([74.125.44.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAkeN-00022z-Pf
	for gcvm-msysgit@m.gmane.org; Mon, 23 Jun 2008 13:56:00 +0200
Received: by yx-out-2122.google.com with SMTP id 22so2820838yxm.63
        for <gcvm-msysgit@m.gmane.org>; Mon, 23 Jun 2008 04:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-spam-score:x-spam-report:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere;
        bh=a5JZLsGQjUx1KBCsY4eJJhkNtTcJeeVFr5xbq/juagY=;
        b=xJ09VMX9FfD77aBSWiYDl8dvDmH3u6YnxjcQalyeV1ptxto9fv9CExMmVBwGbgCG80
         ulALslkKpGqD89dvp+mVsJillx6cW+nq6FUDkSwubvmjHMyCI26HM+ELOuk+yfv7L3rX
         uPl4oVzLQgFpuZLOL+Mw9zwBY/n4jf+8htiH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-spam-score:x-spam-report:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere;
        b=gtFEAIlnG3tPzkavEtckIOlXSf/Tcj4+ebuIIRDK27GEGhVFvjuMut/hROGumeSPgw
         MdpUqoV6VbdjwepmBqd4Zv5Jv6HN5xcDzCQnphU1pujLsP9yKdlipFnvJH2BaP/jOkD3
         Ou8e4VkF2vEp6jpdi9lRAnXW5Jcebs1B6Qbl8=
Received: by 10.142.83.4 with SMTP id g4mr422259wfb.7.1214222095911;
        Mon, 23 Jun 2008 04:54:55 -0700 (PDT)
Received: by 10.107.117.4 with SMTP id u4gr2415prm.0;
	Mon, 23 Jun 2008 04:54:55 -0700 (PDT)
X-Sender: j.sixt@viscovery.net
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.100.33.19 with SMTP id g19mr5555630ang.14.1214222095338; Mon, 23 Jun 2008 04:54:55 -0700 (PDT)
Received: from lilzmailso02.liwest.at (lilzmailso02.liwest.at [212.33.55.13]) by mx.google.com with ESMTP id 7si5380682yxg.1.2008.06.23.04.54.53; Mon, 23 Jun 2008 04:54:55 -0700 (PDT)
Received-SPF: neutral (google.com: 212.33.55.13 is neither permitted nor denied by best guess record for domain of j.sixt@viscovery.net) client-ip=212.33.55.13;
Authentication-Results: mx.google.com; spf=neutral (google.com: 212.33.55.13 is neither permitted nor denied by best guess record for domain of j.sixt@viscovery.net) smtp.mail=j.sixt@viscovery.net
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com) by lilzmailso02.liwest.at with esmtpa (Exim 4.66) (envelope-from <j.sixt@viscovery.net>) id 1KAkdH-0007ZN-0f; Mon, 23 Jun 2008 13:54:51 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42]) by linz.eudaptics.com (Postfix) with ESMTP id B8B136B7; Mon, 23 Jun 2008 13:54:50 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <200806212318.47745.johannes.sixt@telecom.at>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85854>


Johannes Sixt schrieb:
> On Samstag, 21. Juni 2008, Junio C Hamano wrote:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>> please pull the MinGW (Windows) port patch series from
>>>
>>> git://repo.or.cz/git/mingw/j6t.git for-junio

I've updated the branch (it's still based on v1.5.6). Please pull again.

>> Took a look.  A quick impression.
>>
>>  * Too many whitespace breakages in borrowed compat/regex.[ch] are very
>>    distracting.
> 
> Will fixup, no problem.

Done.

>>  * Shouldn't my_mktime() if exported out of date.c be named a bit better?
> 
> How about tm_to_time_t()?

Done. There's a new commit (for-junio~26) that does only the renaming.

>>  * The ifdef block in git.c::main() introduces decl-after-stmt which we
>>    tend to avoid, but it is much worse to solve it by adding another ifdef
>>    block just to enclose decl of char *bslash at the beginning of the
>>    function.  Perhaps enclose it in an extra block?

The #ifdef block is gone.

>>  * In sanitary_path_copy(), you left "break;" after /* (1) */ but now that
>>    "break" is not inside a switch() anymore, so you are breaking out of
>>    something else, aren't you?  -- Ah, the clean-up phase will be no-op in
>>    that case because src points at '\0'.  Tricky but looks correct ;-)
> 
> I'm pretty certain that it is an omission. I'll remove the 'break' in the next 
> round. It's just unnecessarily tricky.

Done.

>>  * There seem to be an unrelated general fix in upload-pack.c
> 
> Yes, indeed. It's the fflush(pack_pipe) that could make a difference. I wonder 
> why this ever worked without it. Notice that traverse_commit_list calls 
> show_object() last, but show_object() never flushes pack_pipe. Are fdopen()ed 
> pipes line-buffered or unbuffered?

I didn't change anything here because I don't know why the old code works
on *nix, and I only know that the change is *necessary* on Windows.

> To reduce #ifdef in other places I have some proposals. Please tell me which 
> you like or dislike:
> 
> * The #ifdef STRIP_EXTENSION can be removed with a conditional like this:
> 
> 	static const char ext[] = STRIP_EXTENSION; // "" or ".exe"
> 	if (sizeof(ext) > 1) {
> 		...
> 	}

Done.

> * The #ifdef in main() of git.c can be removed with a custom loop that checks 
> for is_dir_sep():
> 
> 	slash = cmd + strlen(cmd);
> 	while (slash > cmd && !is_dir_sep(*--slash))
> 		;
> 	if (slash >= cmd) {	// was: if (slash) {
> 		...

Done in a similar way.

> * We could wrap getenv(), so that the getenv("TEMPDIR") in path.c does not 
> need to be followed up with getenv("TMP") and getenv("TEMP"). I'll do that.

Done.

> * The #ifdef in setup.c, prefix_filename() could easily be removed by using 
> the MINGW32 arm everywhere. This would penalize non-Windows, however, 
> prefix_filename() is not performance critical.

NOT done.

>>  * There is an interaction with dr/ceiling topic that is already in 'next'
>>    that needs to be resolved before we merge this in 'next'.

Will take care of this next; I'm running out of time now.

The interdiff follows; I created it with diff -b to hide the whitespace
changes. As you can see, there are a few more editorial changes in
compat/mingw.c (in comments and error texts only).

-- Hannes


 compat/mingw.c    |   33 ++++++++++++++++++++++-----------
 compat/mingw.h    |    3 +++
 date.c            |   13 ++++++++-----
 git-compat-util.h |    5 +++++
 git.c             |   23 +++++++++++------------
 path.c            |    7 -------
 setup.c           |    1 -
 7 files changed, 49 insertions(+), 36 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index ee26df9..3a05fe7 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -218,7 +218,6 @@ int mkstemp(char *template)

 int gettimeofday(struct timeval *tv, void *tz)
 {
-	extern time_t my_mktime(struct tm *tm);
 	SYSTEMTIME st;
 	struct tm tm;
 	GetSystemTime(&st);
@@ -228,7 +227,7 @@ int gettimeofday(struct timeval *tv, void *tz)
 	tm.tm_hour = st.wHour;
 	tm.tm_min = st.wMinute;
 	tm.tm_sec = st.wSecond;
-	tv->tv_sec = my_mktime(&tm);
+	tv->tv_sec = tm_to_time_t(&tm);
 	if (tv->tv_sec < 0)
 		return -1;
 	tv->tv_usec = st.wMilliseconds*1000;
@@ -367,6 +366,19 @@ char *mingw_getcwd(char *pointer, int len)
 	return ret;
 }

+#undef getenv
+char *mingw_getenv(const char *name)
+{
+	char *result = getenv(name);
+	if (!result && !strcmp(name, "TMPDIR")) {
+		/* on Windows it is TMP and TEMP */
+		result = getenv("TMP");
+		if (!result)
+			result = getenv("TEMP");
+	}
+	return result;
+}
+
 /*
  * See http://msdn2.microsoft.com/en-us/library/17w5ykft(vs.71).aspx
  * (Parsing C++ Command-Line Arguments)
@@ -895,13 +907,12 @@ static int one_shot;
 static sig_handler_t timer_fn = SIG_DFL;

 /* The timer works like this:
- * The thread, ticktack(), is basically a trivial routine that most of the
- * time only waits to receive the signal to terminate. The main thread
- * tells the thread to terminate by setting the timer_event to the signalled
+ * The thread, ticktack(), is a trivial routine that most of the time
+ * only waits to receive the signal to terminate. The main thread tells
+ * the thread to terminate by setting the timer_event to the signalled
  * state.
- * But ticktack() does not wait indefinitely; instead, it interrupts the
- * wait state every now and then, namely exactly after timer's interval
- * length. At these opportunities it calls the signal handler.
+ * But ticktack() interrupts the wait state after the timer's interval
+ * length to call the signal handler.
  */

 static __stdcall unsigned ticktack(void *dummy)
@@ -927,7 +938,7 @@ static int start_timer_thread(void)
 				error("cannot start timer thread");
 	} else
 		return errno = ENOMEM,
-			error("cannot allocate resources timer");
+			error("cannot allocate resources for timer");
 	return 0;
 }

@@ -962,11 +973,11 @@ int setitimer(int type, struct itimerval *in, struct
itimerval *out)

 	if (out != NULL)
 		return errno = EINVAL,
-			error("setitmer param 3 != NULL not implemented");
+			error("setitimer param 3 != NULL not implemented");
 	if (!is_timeval_eq(&in->it_interval, &zero) &&
 	    !is_timeval_eq(&in->it_interval, &in->it_value))
 		return errno = EINVAL,
-			error("setitmer: it_interval must be zero or eq it_value");
+			error("setitimer: it_interval must be zero or eq it_value");

 	if (timer_thread)
 		stop_timer_thread();
diff --git a/compat/mingw.h b/compat/mingw.h
index 6965e3f..6bc049a 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -145,6 +145,9 @@ int mingw_open (const char *filename, int oflags, ...);
 char *mingw_getcwd(char *pointer, int len);
 #define getcwd mingw_getcwd

+char *mingw_getenv(const char *name);
+#define getenv mingw_getenv
+
 struct hostent *mingw_gethostbyname(const char *host);
 #define gethostbyname mingw_gethostbyname

diff --git a/compat/regex.c b/compat/regex.c
index 1d39e08..87b33e4 100644
diff --git a/compat/regex.h b/compat/regex.h
index 408dd21..6eb64f1 100644
diff --git a/date.c b/date.c
index d6f8bf6..35a5257 100644
--- a/date.c
+++ b/date.c
@@ -6,7 +6,10 @@

 #include "cache.h"

-time_t my_mktime(struct tm *tm)
+/*
+ * This is like mktime, but without normalization of tm_wday and tm_yday.
+ */
+time_t tm_to_time_t(const struct tm *tm)
 {
 	static const int mdays[] = {
 	    0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334
@@ -67,7 +70,7 @@ static int local_tzoffset(unsigned long time)

 	t = time;
 	localtime_r(&t, &tm);
-	t_local = my_mktime(&tm);
+	t_local = tm_to_time_t(&tm);

 	if (t_local < t) {
 		eastwest = -1;
@@ -322,7 +325,7 @@ static int is_date(int year, int month, int day,
struct tm *now_tm, time_t now,
 		if (!now_tm)
 			return 1;

-		specified = my_mktime(r);
+		specified = tm_to_time_t(r);

 		/* Be it commit time or author time, it does not make
 		 * sense to specify timestamp way into the future.  Make
@@ -572,7 +575,7 @@ int parse_date(const char *date, char *result, int maxlen)
 	}

 	/* mktime uses local timezone */
-	then = my_mktime(&tm);
+	then = tm_to_time_t(&tm);
 	if (offset == -1)
 		offset = (then - mktime(&tm)) / 60;

@@ -611,7 +614,7 @@ void datestamp(char *buf, int bufsize)

 	time(&now);

-	offset = my_mktime(localtime(&now)) - now;
+	offset = tm_to_time_t(localtime(&now)) - now;
 	offset /= 60;

 	date_string(now, offset, buf, bufsize);
diff --git a/git-compat-util.h b/git-compat-util.h
index 46fc2d3..51823ae 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -114,6 +114,10 @@
 #define PATH_SEP ':'
 #endif

+#ifndef STRIP_EXTENSION
+#define STRIP_EXTENSION ""
+#endif
+
 #ifndef has_dos_drive_prefix
 #define has_dos_drive_prefix(path) 0
 #endif
@@ -143,6 +147,7 @@ extern void set_error_routine(void (*routine)(const
char *err, va_list params));
 extern void set_warn_routine(void (*routine)(const char *warn, va_list
params));

 extern int prefixcmp(const char *str, const char *prefix);
+extern time_t tm_to_time_t(const struct tm *tm);

 #ifdef NO_MMAP

diff --git a/git.c b/git.c
index a4b0a5e..871b93c 100644
--- a/git.c
+++ b/git.c
@@ -369,15 +369,16 @@ static void handle_internal_command(int argc, const
char **argv)
 		{ "pack-refs", cmd_pack_refs, RUN_SETUP },
 	};
 	int i;
+	static const char ext[] = STRIP_EXTENSION;

-#ifdef STRIP_EXTENSION
-	i = strlen(argv[0]) - strlen(STRIP_EXTENSION);
-	if (i > 0 && !strcmp(argv[0] + i, STRIP_EXTENSION)) {
+	if (sizeof(ext) > 1) {
+		i = strlen(argv[0]) - strlen(ext);
+		if (i > 0 && !strcmp(argv[0] + i, ext)) {
 		char *argv0 = strdup(argv[0]);
 		argv[0] = cmd = argv0;
 		argv0[i] = '\0';
 	}
-#endif
+	}

 	/* Turn "git cmd --help" into "git help cmd" */
 	if (argc > 1 && !strcmp(argv[1], "--help")) {
@@ -395,8 +396,8 @@ static void handle_internal_command(int argc, const
char **argv)

 int main(int argc, const char **argv)
 {
-	const char *cmd = argv[0] ? argv[0] : "git-help";
-	char *slash = strrchr(cmd, '/');
+	const char *cmd = argv[0] && *argv[0] ? argv[0] : "git-help";
+	char *slash = (char *)cmd + strlen(cmd);
 	const char *cmd_path = NULL;
 	int done_alias = 0;

@@ -405,12 +406,10 @@ int main(int argc, const char **argv)
 	 * name, and the dirname as the default exec_path
 	 * if we don't have anything better.
 	 */
-#ifdef __MINGW32__
-	char *bslash = strrchr(cmd, '\\');
-	if (!slash || (bslash && bslash > slash))
-		slash = bslash;
-#endif
-	if (slash) {
+	do
+		--slash;
+	while (cmd <= slash && !is_dir_sep(*slash));
+	if (cmd <= slash) {
 		*slash++ = 0;
 		cmd_path = cmd;
 		cmd = slash;
diff --git a/path.c b/path.c
index 5da41c7..7a35a26 100644
--- a/path.c
+++ b/path.c
@@ -75,13 +75,6 @@ int git_mkstemp(char *path, size_t len, const char
*template)
 	size_t n;

 	tmp = getenv("TMPDIR");
-#ifdef __MINGW32__
-	/* on Windows it is TMP and TEMP */
-	if (!tmp)
-	    tmp = getenv("TMP");
-	if (!tmp)
-	    tmp = getenv("TEMP");
-#endif
 	if (!tmp)
 		tmp = "/tmp";
 	n = snprintf(path, len, "%s/%s", tmp, template);
diff --git a/setup.c b/setup.c
index ec33147..8bb7b10 100644
--- a/setup.c
+++ b/setup.c
@@ -35,7 +35,6 @@ static int sanitary_path_copy(char *dst, const char *src)
 			if (!src[1]) {
 				/* (1) */
 				src++;
-				break;
 			} else if (is_dir_sep(src[1])) {
 				/* (2) */
 				src += 2;
