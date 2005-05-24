From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 20:46:12 +0200
Message-ID: <20050524184612.GA23637@cip.informatik.uni-erlangen.de>
References: <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org> <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org> <4292A08A.5050108@cobite.com> <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org> <20050524161745.GA9537@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Cc: David Mansfield <david@cobite.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 20:46:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaeOt-0004WY-6A
	for gcvg-git@gmane.org; Tue, 24 May 2005 20:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVEXSqq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 14:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVEXSqq
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 14:46:46 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:1935 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261208AbVEXSqV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 14:46:21 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4OIkCS8024504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 May 2005 18:46:12 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4OIkCrx024503;
	Tue, 24 May 2005 20:46:12 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	David Mansfield <david@cobite.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

> And if this doesn't work for you, point me to the CVS archive that causes 
> you trouble.

you should try the mutt cvs repository[1].

I have the following issues all seem easy to fix:

	- PatchSet 1 depends on PatchSet 2 (but cvsps gets the ordering wrong;
	  should be easy fixable) (I just swichted the two before
	  running cvs2git)

	- Some Shell escapes (I didn't looked into them yet)

		(faui02new) [/var/tmp/sithglan/mutt-cvs] bash ~/work/cvsps/sane
		defaulting to local storage area
		Committing initial tree 7e68fd9a5104b61192a7da7357549d95b3a0620c
		Ignoring path .cvsignore
		...
		/home/cip/adm/sithglan/work/cvsps/sane: line 1: ...: command not found
		/home/cip/adm/sithglan/work/cvsps/sane: command substitution: line 1: unexpected EOF while looking for matching `''
		/home/cip/adm/sithglan/work/cvsps/sane: command substitution: line 4: syntax error: unexpected end of file
		/home/cip/adm/sithglan/work/cvsps/sane: command substitution: line 1: unexpected EOF while looking for matching `''
		/home/cip/adm/sithglan/work/cvsps/sane: command substitution: line 5: syntax error: unexpected end of file
		/home/cip/adm/sithglan/work/cvsps/sane: command substitution: line 1: unexpected EOF while looking for matching `''
		/home/cip/adm/sithglan/work/cvsps/sane: command substitution: line 2: syntax error: unexpected end of file
		/home/cip/adm/sithglan/work/cvsps/sane: command substitution: line 1: unexpected EOF while looking for matching `''
		/home/cip/adm/sithglan/work/cvsps/sane: command substitution: line 3: syntax error: unexpected end of file
		/home/cip/adm/sithglan/work/cvsps/sane: command substitution: line 1: unexpected EOF while looking for matching `''
		/home/cip/adm/sithglan/work/cvsps/sane: command substitution: line 26: syntax error: unexpected end of file

But hey this looks really good: :-))))))

(faui02new) [/var/tmp/sithglan/mutt-cvs] git parent ~/work/mutt/git/mutt-cvs
(faui02new) [/var/tmp/sithglan/mutt-cvs] git parentdiff
(faui02new) [/var/tmp/sithglan/mutt-cvs]

I think I will run my 'import patch by patch script again' and check the
changesets against the cvs2git tree, but it looks fine for me.

	Thomas

[1] To make it reproducable for you:

I used the attached patch against cvsps-2.0rc1 which fixes date
covnersion problems and of course includes the ancestor thing.

rsync -r rsync://cvs.gnupg.org/mutt-cvs-rep mutt-cvs-rep

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diff

diff --git a/cvs_direct.c b/cvs_direct.c
--- a/cvs_direct.c
+++ b/cvs_direct.c
@@ -126,7 +126,7 @@ CvsServerCtx * open_cvs_server(char * p_
 	send_string(ctx, "Root %s\n", ctx->root);
 
 	/* this is taken from 1.11.1p1 trace - but with Mbinary removed. we can't handle it (yet!) */
-	send_string(ctx, "Valid-responses ok error Valid-requests Checked-in New-entry Checksum Copy-file Updated Created Update-existing Merged Patched Rcs-diff Mode Mod-time Removed Remove-entry Set-static-directory Clear-static-directory Set-sticky Clear-sticky Template Set-checkin-prog Set-update-prog Notified Module-expansion Wrapper-rcsOption M E F MT\n", ctx->root);
+	send_string(ctx, "Valid-responses ok error Valid-requests Checked-in New-entry Checksum Copy-file Updated Created Update-existing Merged Patched Rcs-diff Mode Mod-time Removed Remove-entry Set-static-directory Clear-static-directory Set-sticky Clear-sticky Template Set-checkin-prog Set-update-prog Notified Module-expansion Wrapper-rcsOption M E F\n", ctx->root);
 
 	send_string(ctx, "valid-requests\n");
 
@@ -894,6 +894,7 @@ char * cvs_rlog_fgets(char * buff, int b
     }
     else if (strcmp(lbuff, "ok") == 0 ||strcmp(lbuff, "error") == 0)
     {
+	debug(DEBUG_TCP, "cvs_direct: rlog: got command completion");
 	return NULL;
     }
 
diff --git a/cvsps.1 b/cvsps.1
--- a/cvsps.1
+++ b/cvsps.1
@@ -3,7 +3,7 @@
 CVSps \- create patchset information from CVS
 .SH SYNOPSIS
 .B cvsps
-[-h] [-x] [-u] [-z <fuzz>] [-g] [-s <patchset>] [-a <author>] [-f <file>] [-d <date1> [-d <date2>]] [-l <text>] [-b <branch>] [-r <tag> [-r <tag>]] [-p <directory>] [-v] [-t] [--norc] [--summary-first] [--test-log <filename>] [--bkcvs] [--no-rlog] [--diff-opts <option string>] [--cvs-direct] [--debuglvl <bitmask>] [-Z <compression>] [--root <cvsroot>] [-q] [<repository>] 
+[\-h] [\-x] [\-u] [\-z <fuzz>] [\-g] [\-s <patchset>] [\-a <author>] [\-f <file>] [\-d <date1> [\-d <date2>]] [\-l <text>] [\-b <branch>] [\-r <tag> [\-r <tag>]] [\-p <directory>] [\-v] [\-t] [\-\-norc] [\-\-summary-first] [\-\-test\-log <filename>] [\-\-bkcvs] [\-\-no\-rlog] [\-\-diff\-opts <option string>] [\-\-cvs\-direct] [\-\-debuglvl <bitmask>] [\-Z <compression>] [\-\-root <cvsroot>] [\-q] [<repository>] 
 .SH DESCRIPTION
 CVSps is a program for generating 'patchset' information from a CVS
 repository.  A patchset in this case is defined as a set of changes made
@@ -29,7 +29,7 @@ set the timestamp fuzz factor for identi
 .B \-g
 generate diffs of the selected patch sets
 .TP
-.B \-s <patchset>[-[<patchset>]][,<patchset>...]
+.B \-s <patchset>[\-[<patchset>]][,<patchset>...]
 generate a diff for a given patchsets and patchset ranges
 .TP
 .B \-a <author>
@@ -38,7 +38,7 @@ restrict output to patchsets created by 
 .B \-f <file>
 restrict output to patchsets involving file
 .TP
-.B \-d <date1> -d <date2>
+.B \-d <date1> \-d <date2>
 if just one date specified, show
 revisions newer than date1.  If two dates specified,
 show revisions between two dates.
@@ -50,7 +50,7 @@ restrict output to patchsets matching re
 restrict output to patchsets affecting history of branch.
 If you want to restrict to the main branch, use a branch of 'HEAD'.
 .TP
-.B \-r <tag1> -r <tag2>
+.B \-r <tag1> \-r <tag2>
 if just one tag specified, show
 revisions since tag1. If two tags specified, show
 revisions between the two tags.
@@ -64,47 +64,47 @@ show very verbose parsing messages
 .B \-t
 show some brief memory usage statistics
 .TP
-.B \--norc
+.B \-\-norc
 when invoking cvs, ignore the .cvsrc file
 .TP
-.B \--summary-first
+.B \-\-summary\-first
 when multiple patchset diffs are being generated, put the patchset
 summary for all patchsets at the beginning of the output.
 .TP
-.B \--test-log <captured cvs log file>
+.B \-\-test\-log <captured cvs log file>
 for testing changes, you can capture cvs log output, then test against
 this captured file instead of hammering some poor CVS server
 .TP
-.B \--bkcvs
+.B \-\-bkcvs
 (see note below) for use in parsing the BK->CVS tree log formats only.  This enables
 some hacks which are not generally applicable.
 .TP
-.B \--no-rlog
+.B \-\-no\-rlog
 disable the use of rlog internally.  Note: rlog is
 required for stable PatchSet numbering.  Use with care.
 .TP
-.B \--diffs-opts <option string>
+.B \-\-diffs\-opts <option string>
 send a custom set of options to diff, for example to increase
 the number of context lines, or change the diff format.
 .TP
-.B \--cvs-direct (--no-cvs-direct)
-enable (disable) built-in cvs client code. This enables the 'pipelining' of multiple
+.B \-\-cvs\-direct (\-\-no-cvs\-direct)
+enable (disable) built\-in cvs client code. This enables the 'pipelining' of multiple
 requests over a single client, reducing the overhead of handshaking and
 authentication to one per PatchSet instead of one per file.
 .TP
-.B \--debuglvl <bitmask>
+.B \-\-debuglvl <bitmask>
 enable various debug output channels.
 .TP
 .B \-Z <compression>
 A value 1-9 which specifies amount of compression.  A value of 0 disables compression.
 .TP
-.B \--root <cvsroot>
+.B \-\-root <cvsroot>
 Override the setting of CVSROOT (overrides working dir. and environment)
 .TP
 .B \-q
 Be quiet about warnings.
 .TP
-.B \<repository>
+.B <repository>
 Operate on the specified repository (overrides working dir.)
 .SH "NOTE ON TAG HANDLING"
 Tags are fundamentally 'file at a time' in cvs, but like everything else,
@@ -159,17 +159,17 @@ directory in the path, and -p0 will be r
 diffs are generated in cvs-direct mode (see below), however, they will always
 be -p1 style patches.
 .SH "NOTE ON BKCVS"
-The --bkcvs option is a special operating mode that should only be used when parsing
+The \-\-bkcvs option is a special operating mode that should only be used when parsing
 the log files from the BK -> CVS exported linux kernel trees.  cvsps uses special
 semantics for recreating the BK ChangeSet metadata that has been embedded in the log
-files for those trees.  The --bkcvs option should only be specified when the cache
-file is being created or updated (i.e. initial run of cvsps, or when -u and -x options
+files for those trees.  The \-\-bkcvs option should only be specified when the cache
+file is being created or updated (i.e. initial run of cvsps, or when \-u and \-x options
 are used).
 .SH "NOTE ON CVS-DIRECT"
 As of version 2.0b6 cvsps has a partial implementation of the cvs client code built 
 in.  This reduces the RTT and/or handshaking overhead from one per patchset member
 to one per patchset.  This dramatically increases the speed of generating diffs
-over a slow link, and improves the consistency of operation.  Currently the --cvs-direct
+over a slow link, and improves the consistency of operation.  Currently the \-\-cvs-direct
 option turns on the use of this code, but it very well may be default by the time
 2.0 comes out.  The built-in cvs code attempts to be compatible with cvs, but may
 have problems, which should be reported.  It honors the CVS_RSH and CVS_SERVER 
@@ -179,7 +179,9 @@ CVSps parses an rc file at startup.  Thi
 The file should contain arguments, in the exact syntax as the command line, one per line.
 If an argument takes a parameter, the parameter should be on the same line as the argument.
 .SH "NOTE ON DATE FORMATS"
-Dates have formats.  Fixme.
+Dates must be in the format 'yyyy/mm/dd hh:mm:ss'; for example,
+.IP "" 4
+$ cvsps -d '2004/05/01 00:00:00' -d '2004/07/07 12:00:00'
 .SH "SEE ALSO"
 .BR cvs ( 1 ),
 .BR ci ( 1 ),
diff --git a/cvsps.c b/cvsps.c
--- a/cvsps.c
+++ b/cvsps.c
@@ -1402,6 +1402,16 @@ static void print_patch_set(PatchSet * p
 	   tm->tm_hour, tm->tm_min, tm->tm_sec);
     printf("Author: %s\n", ps->author);
     printf("Branch: %s\n", ps->branch);
+    
+    /* check if ancestor was different branch */
+    if (!list_empty(&ps->members)) 
+    {
+	    PatchSetMember * psm = list_entry(ps->members.next, PatchSetMember, link);
+	    const char * abr = psm->pre_rev ? psm->pre_rev->branch : NULL;
+	    if (abr && strcmp(ps->branch, abr) != 0)
+		    printf("Ancestor branch: %s\n", abr);
+    }
+
     printf("Tag: %s %s\n", ps->tag ? ps->tag : "(none)", tag_flag_descr[ps->tag_flags]);
     printf("Log:\n%s\n", ps->descr);
     printf("Members: \n");
@@ -1646,6 +1656,7 @@ static void do_cvs_diff(PatchSet * ps)
     const char * dopts;
     const char * utype;
     char use_rep_path[PATH_MAX];
+    char esc_use_rep_path[PATH_MAX];
 
     fflush(stdout);
     fflush(stderr);
@@ -1666,6 +1677,8 @@ static void do_cvs_diff(PatchSet * ps)
 	dtype = "rdiff";
 	utype = "co";
 	sprintf(use_rep_path, "%s/", repository_path);
+	/* the rep_path may contain characters that the shell will barf on */
+	escape_filename(esc_use_rep_path, PATH_MAX, use_rep_path);
     }
     else
     {
@@ -1673,6 +1686,7 @@ static void do_cvs_diff(PatchSet * ps)
 	dtype = "diff";
 	utype = "update";
 	use_rep_path[0] = 0;
+	esc_use_rep_path[0] = 0;
     }
 
     for (next = ps->members.next; next != &ps->members; next = next->next)
@@ -1740,7 +1754,7 @@ static void do_cvs_diff(PatchSet * ps)
 	    else
 	    {
 		snprintf(cmdbuff, PATH_MAX * 2, "cvs %s %s %s -p -r %s %s%s | diff %s %s /dev/null %s | sed -e '%s s|^\\([+-][+-][+-]\\) -|\\1 %s%s|g'",
-			 compress_arg, norc, utype, rev, use_rep_path, esc_file, dopts,
+			 compress_arg, norc, utype, rev, esc_use_rep_path, esc_file, dopts,
 			 cr?"":"-",cr?"-":"", cr?"2":"1",
 			 use_rep_path, psm->file->filename);
 	    }
@@ -1760,7 +1774,7 @@ static void do_cvs_diff(PatchSet * ps)
 
 		snprintf(cmdbuff, PATH_MAX * 2, "cvs %s %s %s %s -r %s -r %s %s%s",
 			 compress_arg, norc, dtype, dopts, psm->pre_rev->rev, psm->post_rev->rev, 
-			 use_rep_path, esc_file);
+			 esc_use_rep_path, esc_file);
 	    }
 	}
 
@@ -2113,7 +2127,7 @@ static void resolve_global_symbols()
 	    Tag * tag = list_entry(next, Tag, global_link);
 	    CvsFileRevision * rev = tag->rev;
 
-	    if (!rev->present)
+	    if (!rev->present || !rev->post_psm)
 	    {
 		struct list_head *tmp = next->prev;
 		debug(DEBUG_APPERROR, "revision %s of file %s is tagged but not present",
diff --git a/cvsps.h b/cvsps.h
--- a/cvsps.h
+++ b/cvsps.h
@@ -11,6 +11,10 @@
 typedef struct _CvsServerCtx CvsServerCtx;
 #endif
 
+#ifndef PATH_MAX
+#define PATH_MAX 4096
+#endif
+
 extern struct hash_table * file_hash;
 extern const char * tag_flag_descr[];
 extern CvsServerCtx * cvs_direct_ctx;
diff --git a/util.c b/util.c
--- a/util.c
+++ b/util.c
@@ -13,6 +13,7 @@
 #include <time.h>
 #include <errno.h>
 #include <signal.h>
+#include <regex.h>
 #include <sys/stat.h>
 #include <sys/time.h>
 #include <sys/types.h>
@@ -140,24 +141,51 @@ char *get_string(char const *str)
     return *res;
 }
 
+static int get_int_substr(const char * str, const regmatch_t * p)
+{
+    char buff[256];
+    memcpy(buff, str + p->rm_so, p->rm_eo - p->rm_so);
+    buff[p->rm_eo - p->rm_so] = 0;
+    return atoi(buff);
+}
+
 void convert_date(time_t * t, const char * dte)
 {
-    /* HACK: this routine parses two formats,
-     * 1) 'cvslog' format YYYY/MM/DD HH:MM:SS
-     * 2) time_t formatted as %d
-     */
-       
-    if (strchr(dte, '/'))
+    static regex_t date_re;
+    static int init_re;
+
+#define MAX_MATCH 16
+    size_t nmatch = MAX_MATCH;
+    regmatch_t match[MAX_MATCH];
+
+    if (!init_re) 
+    {
+	if (regcomp(&date_re, "([0-9]{4})[-/]([0-9]{2})[-/]([0-9]{2}) ([0-9]{2}):([0-9]{2}):([0-9]{2})", REG_EXTENDED)) 
+	{
+	    fprintf(stderr, "FATAL: date regex compilation error\n");
+	    exit(1);
+	}
+	init_re = 1;
+    }
+    
+    if (regexec(&date_re, dte, nmatch, match, 0) == 0)
     {
+	regmatch_t * pm = match;
 	struct tm tm;
+
+	/* first regmatch_t is match location of entire re */
+	pm++;
 	
-	memset(&tm, 0, sizeof(tm));
-	sscanf(dte, "%d/%d/%d %d:%d:%d", 
-	       &tm.tm_year, &tm.tm_mon, &tm.tm_mday, 
-	       &tm.tm_hour, &tm.tm_min, &tm.tm_sec);
-	
+	tm.tm_year = get_int_substr(dte, pm++);
+	tm.tm_mon  = get_int_substr(dte, pm++);
+	tm.tm_mday = get_int_substr(dte, pm++);
+	tm.tm_hour = get_int_substr(dte, pm++);
+	tm.tm_min  = get_int_substr(dte, pm++);
+	tm.tm_sec  = get_int_substr(dte, pm++);
+
 	tm.tm_year -= 1900;
 	tm.tm_mon--;
+	tm.tm_isdst = 0;
 	
 	*t = mktime(&tm);
     }
diff --git a/util.h b/util.h
--- a/util.h
+++ b/util.h
@@ -6,6 +6,10 @@
 #ifndef UTIL_H
 #define UTIL_H
 
+#ifndef PATH_MAX
+#define PATH_MAX 4096
+#endif
+
 #define CVSPS_PREFIX ".cvsps"
 
 char *xstrdup(char const *);

--k+w/mQv8wyuph6w0--
