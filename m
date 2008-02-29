From: Marius Storm-Olsen <marius@trolltech.com>
Subject: '.git file' alternative, native (cross-platform) workdir
 support.
Date: Fri, 29 Feb 2008 13:27:53 +0100
Message-ID: <47C7FA49.9010001@trolltech.com>
Reply-To: marius@trolltech.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="------------enig1BE77ACFD521D3EE37FD7A84"
To: Git Mailing List <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Fri Feb 29 13:28:41 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.170])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV4Lv-0007Fy-SH
	for gcvm-msysgit@m.gmane.org; Fri, 29 Feb 2008 13:28:40 +0100
Received: by py-out-1314.google.com with SMTP id p69so6044846pyb.5
        for <gcvm-msysgit@m.gmane.org>; Fri, 29 Feb 2008 04:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:received:message-id:date:from:user-agent:mime-version:to:subject:x-enigmail-version:face:content-type:x-virus-scanned:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=2XAEVNI+c6gZ0V6vmuOql1edB5oQ03twfVVEtq67mvo=;
        b=CAXc/CL0FHL7TQx5OZrROwmPSRvcg802Q+LA7SfIii263E0doixJ4riWqgz/neq31EEoePcoTQNAH549Dwu2UdasOIH6poCw/n7aRi2Zi+mCCMkUJgOHGJjj2RwE4IuYTMqRfsVCG49VFS8s/1FbmQ03muzD0WW+2zOeuDq9vyI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:message-id:date:from:user-agent:mime-version:to:subject:x-enigmail-version:face:content-type:x-virus-scanned:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=zL9UCkU3iBYX7y7fb3q6flSM3Rt63HCrigX7/LdGdTYHpeQ+j6L99BwvgpFrP9K3kpeZMcbj6pzeiFCwNXSFsYQOrlPUJTCY+Ch4rsM0FAzPGtsGRagHGKr8K5yYXVHh9ct8nL5ooTWYbwfZ6UY45N+hozww8zTnsGnqpedLbZQ=
Received: by 10.141.4.3 with SMTP id g3mr806584rvi.29.1204288082972;
        Fri, 29 Feb 2008 04:28:02 -0800 (PST)
Received: by 10.107.134.19 with SMTP id l19gr1854prn.0;
	Fri, 29 Feb 2008 04:28:02 -0800 (PST)
X-Sender: marius@trolltech.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.115.91.2 with SMTP id t2mr7253256wal.24.1204288081671; Fri, 29 Feb 2008 04:28:01 -0800 (PST)
Received: from hoat.troll.no ([62.70.27.150]) by mx.google.com with ESMTP id k36si4741337waf.0.2008.02.29.04.27.54; Fri, 29 Feb 2008 04:28:01 -0800 (PST)
Received-SPF: neutral (google.com: 62.70.27.150 is neither permitted nor denied by best guess record for domain of marius@trolltech.com) client-ip=62.70.27.150;
Authentication-Results: mx.google.com; spf=neutral (google.com: 62.70.27.150 is neither permitted nor denied by best guess record for domain of marius@trolltech.com) smtp.mail=marius@trolltech.com
Received: from localhost (localhost [127.0.0.1]) by hoat.troll.no (Postfix) with ESMTP id 5D16258129; Fri, 29 Feb 2008 13:27:11 +0100 (CET)
Received: from hoat.troll.no ([127.0.0.1]) by localhost (hoat.troll.no [127.0.0.1]) (amavisd-maia, port 10024) with LMTP id 07172-09; Fri, 29 Feb 2008 13:27:10 +0100 (CET)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215]) by hoat.troll.no (Postfix) with ESMTP id C524358092; Fri, 29 Feb 2008 13:27:10 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
X-Enigmail-Version: 0.95.6
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEXU1NTAwMABAQGsrKyE hIQwMDAEBAS8hGUfAAACQUlEQVQ4jV2TS47cMAxEKSDZW1CfwMB4PYLkrKchsveJRR2gEen+R0hR 9vziBmahhyqSRQ4NfF1FmIv3dH4usNAGoFprBVguQJmZ1nX0XiHgEukTCK3TairiZeXcVGzmZIoU 3738pehdVbiU9KFgMQWeZ1fpHZDfRS4rPb3eQVaZChGx4ikt5GDkAZQ2KKohzjklno4+iJpVhxka ZjSpasJ4gdGaEQMWTMjRa5uTqza0XDJjzhIdzGTMrqoopimoIPCKZtVOq265MAXpMLXycmVl2Y8C oE1FkT/faKauOjYoHJyOxHfvixjowvI0xZJsKykubgLYzuJMdBO+L86TjxfQ9hz9jpSudbnXXzRm tor5i3MUONpOfARAhlWbzWF7OhP2eSeEW9HUBNiHOxUM8HLWHhUAj3NZNsdqRZpNA+DJ+XlX+Qc9 Z4ZjHX8LRUzgTBBef84NQoCMOcS0+BMsj3klbTzRri03ugXr9em1GfgzDAyEn4J3fvFI5YwdTrYu 1ntAY1h5ysM2OMGm+cBOocCXHisAHu2PagnLghoG2krz8bzsA4fj7KxCGk+63jt+DDCtYjbFNkHD nRwpRqsQYx5WYzsbm/eBfn0I4TbOGvMWqhQAiEDzNs4apumCI0x2OyHtY7uAlZff/sanbH9+AGT1 KOEmUlJISdYPgEgehw+cTZEf6xeF
 yoEjCPgv+A62KhW3EOy9PL7WmCBMRWmfYN0OqW9krzl/Ay91 75HMqfDtP8UFckFUX2rwrm/kTVB2gH+hdu4avZVCuAAAAABJRU5ErkJggg==
X-Virus-Scanned: Maia Mailguard 1.0.2a
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75528>


This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1BE77ACFD521D3EE37FD7A84
Content-Type: multipart/mixed;
 boundary="------------050108030800080001060205"

This is a multi-part message in MIME format.
--------------050108030800080001060205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi guys,

I just caught a glimpse of the '.git file' efforts, as a file for=20
redirection to a real repository.

As far as I can tell, the reason for adding the support is to in the=20
end provide a cross-platform way of supporting workdirs. (If this is=20
not the [main] point, please point me to the thread describing the=20
real reason, I couldn't find it.)

However, wouldn't simply redirecting everything into a real repo then=20
create problems with shared index file and more? A problem which could=20
be tacled by file suffixes or other methods, I'm sure, but which would=20
require even more patches to achieve the goal.


I was actually thinking about the whole workdir thing the other day,=20
since I mainly work on Windows, and constantly green of envy of the=20
'mainly Linux' guys. I figured, why not just add support for file=20
redirection in
     char *git_path(const char *fmt, ...)
which we use all over the place? That surely is easy and=20
cross-platform :-)


Attached you'll find a patch which will achieve 'native workdir'=20
support on all platforms, independent of underlying file system. And=20
if you ignore the code added to builtin-init-db.c &=20
builtin-rev-parse.c for minimal usage support, it's a mere 104 lines=20
touched. The patch should apply cleanly on both git's next branch, and=20
Hannes' j6t master branch (the mingw port).

Please note that the patch is not meant for end-user consumption, nor=20
does it follow Git coding standards. It's just meant as a proof of=20
concept, and as a means of discussion.
Also note that this way of supporting workdirs suffers from the same=20
'flaws' the current git-new-workdir has (locking of repo etc).

If people want, I can work with it, and implement this properly (with=20
its own builtin-workdir, test cases etc). As I see it, the '.git file'=20
concept still has some way to go. Maybe the '.git file' concept is the=20
best way in the end, but that this way is an 'ok' temporary way of=20
doing it?

^shrug^ - Input please!

To try out the patch, apply it on git 'next' branch, then in some=20
random directory:
     git init --workdir-for=3D<abs-path to repo>
     git reset --hard
     .. hack away as normal ..
(I know I know, it just a quick hack to let ppl play with it.)

PS. Sorry for the patch being an attachment, I'm a Thunderbird slave.=20
(Someone really needs to make a Thunderbird addon for sending Git=20
patches ;-)

--
=2Emarius

--------------050108030800080001060205
Content-Type: text/plain;
 name="0001-Add-cross-platform-workdir-support.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="0001-Add-cross-platform-workdir-support.patch"

=46rom a38bf926edcba780445ae2a67eb8fe33b266a94f Mon Sep 17 00:00:00 2001
From: Marius Storm-Olsen <marius@trolltech.com>
Date: Thu, 28 Feb 2008 13:22:42 +0100
Subject: [PATCH] Add cross-platform workdir support

---
 builtin-init-db.c   |   53 ++++++++++++++++++++++++++++++++++++++-----
 builtin-rev-parse.c |   19 +++++++++++++++
 cache.h             |    2 +
 environment.c       |   63 +++++++++++++++++++++++++++++++++++++++++++++=
-----
 path.c              |   37 +++++++++++++++++++++++++++--
 setup.c             |    2 +-
 6 files changed, 159 insertions(+), 17 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 79eaf8d..94622f9 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -310,7 +310,7 @@ static void guess_repository_type(const char *git_dir=
)
 }
=20
 static const char init_db_usage[] =3D
-"git-init [-q | --quiet] [--template=3D<template-directory>] [--shared]"=
;
+"git-init [-q | --quiet] [--template=3D<template-directory>] [--shared] =
[--workdir-for=3D<repository>]";
=20
 /*
  * If you want to, you can share the DB area with any number of branches=
=2E
@@ -323,8 +323,9 @@ int cmd_init_db(int argc, const char **argv, const ch=
ar *prefix)
 	const char *git_dir;
 	const char *sha1_dir;
 	const char *template_dir =3D NULL;
+	char *repo_dir =3D NULL;
 	char *path;
-	int len, i, reinit;
+	int len, i, reinit, workdir_fd;
 	int quiet =3D 0;
=20
 	for (i =3D 1; i < argc; i++, argv++) {
@@ -337,7 +338,10 @@ int cmd_init_db(int argc, const char **argv, const c=
har *prefix)
 			shared_repository =3D git_config_perm("arg", arg+9);
 		else if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet"))
 		        quiet =3D 1;
-		else
+		else if (!prefixcmp(arg, "--workdir-for=3D")) {
+			repo_dir =3D xmalloc(PATH_MAX);
+			strcpy(repo_dir, arg+14);
+		} else
 			usage(init_db_usage);
 	}
=20
@@ -406,11 +410,48 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
 		git_config_set("receive.denyNonFastforwards", "true");
 	}
=20
-	if (!quiet)
-		printf("%s%s Git repository in %s/\n",
+	if (repo_dir) {
+		len =3D strlen(git_dir);
+		memcpy(path, git_dir, len);
+		strcpy(path+len, "/workdir_for");
+		len =3D strlen(repo_dir);
+#ifdef __MINGW32__
+		for(i =3D 0; i < len; ++i) {
+			if (repo_dir[i] =3D=3D '\\')
+				repo_dir[i] =3D '/';
+		}
+#endif
+		if (!is_git_directory(repo_dir)) {
+			strcpy(repo_dir+len, "/.git");
+			if (!is_git_directory(repo_dir))
+				die("specified --workdir-for path is not a git repository (%s)", rep=
o_dir);
+		}
+		workdir_fd =3D open(path, O_CREAT | O_EXCL | O_WRONLY, 0666);
+		if (!workdir_fd)
+			die("couldn't create workdir redirection file: %s", strerror(errno));=

+		write_or_die(workdir_fd, repo_dir, strlen(repo_dir));
+		if (close(workdir_fd) < 0)
+			die("closing file %s: %s", path, strerror(errno));
+
+		/* Copy current HEAD */
+		strcpy(repo_dir+len, "/HEAD");
+		len =3D strlen(git_dir);
+		strcpy(path+len, "/HEAD");
+		copy_file(path, repo_dir, 0);
+
+		/* Should force a checkout of the current HEAD. Oh well.. */
+	}
+
+	if (!quiet) {
+		printf("%s%s %s repository in %s/\n",
 		       reinit ? "Reinitialized existing" : "Initialized empty",
 		       shared_repository ? " shared" : "",
+		       repo_dir ? "workdir" : "Git",
 		       git_dir);
-
+		if (repo_dir)
+			printf("You now either need to do a 'git reset --hard', or force a sw=
itch to another branch.\n");
+	}
+	if (repo_dir)
+		free(repo_dir);
 	return 0;
 }
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 90dbb9d..d83ba59 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -511,6 +511,25 @@ int cmd_rev_parse(int argc, const char **argv, const=
 char *prefix)
 				printf("%s/.git\n", cwd);
 				continue;
 			}
+			if (!strcmp(arg, "--git-redirection-dir")) {
+				const char *redir =3D get_git_redirection_dir();
+				printf("%s\n", redir ? redir
+						: "");
+				continue;
+			}
+			if (!strcmp(arg, "--git-object-dir")) {
+				printf("%s\n", get_object_directory());
+				continue;
+			}
+			if (!strcmp(arg, "--git-refs-dir")) {
+				printf("%s\n", get_refs_directory());
+				continue;
+			}
+			if (!strcmp(arg, "--uses-git-redirection")) {
+				printf("%s\n", get_git_redirection_dir() ? "true"
+						: "false");
+				continue;
+			}
 			if (!strcmp(arg, "--is-inside-git-dir")) {
 				printf("%s\n", is_inside_git_dir() ? "true"
 						: "false");
diff --git a/cache.h b/cache.h
index 660ea04..e8b6879 100644
--- a/cache.h
+++ b/cache.h
@@ -301,6 +301,7 @@ static inline enum object_type object_type(unsigned i=
nt mode)
 extern int is_bare_repository_cfg;
 extern int is_bare_repository(void);
 extern int is_inside_git_dir(void);
+extern int is_git_directory(const char *suspect);
 extern char *git_work_tree_cfg;
 extern int is_inside_work_tree(void);
 extern const char *get_git_dir(void);
@@ -310,6 +311,7 @@ extern char *get_index_file(void);
 extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
 extern const char *get_git_work_tree(void);
+extern const char *get_git_redirection_dir(void);
=20
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
=20
diff --git a/environment.c b/environment.c
index 6739a3f..74391de 100644
--- a/environment.c
+++ b/environment.c
@@ -44,7 +44,7 @@ char *git_work_tree_cfg;
 static const char *work_tree;
=20
 static const char *git_dir;
-static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_=
file;
+static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_=
file, *git_workdir_redirection;
=20
 static void setup_git_env(void)
 {
@@ -53,15 +53,12 @@ static void setup_git_env(void)
 		git_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
 	git_object_dir =3D getenv(DB_ENVIRONMENT);
 	if (!git_object_dir) {
-		git_object_dir =3D xmalloc(strlen(git_dir) + 9);
-		sprintf(git_object_dir, "%s/objects", git_dir);
+		git_object_dir =3D xstrdup(git_path("objects"));
 	}
-	git_refs_dir =3D xmalloc(strlen(git_dir) + 6);
-	sprintf(git_refs_dir, "%s/refs", git_dir);
+	git_refs_dir =3D xstrdup(git_path("refs"));
 	git_index_file =3D getenv(INDEX_ENVIRONMENT);
 	if (!git_index_file) {
-		git_index_file =3D xmalloc(strlen(git_dir) + 7);
-		sprintf(git_index_file, "%s/index", git_dir);
+		git_index_file =3D xstrdup(git_path("index"));
 	}
 	git_graft_file =3D getenv(GRAFT_ENVIRONMENT);
 	if (!git_graft_file)
@@ -101,6 +98,58 @@ const char *get_git_work_tree(void)
 	return work_tree;
 }
=20
+static char *workdir_for =3D "/workdir_for";
+const char *get_git_redirection_dir(void)
+{
+	static int checked_for_redirection =3D 0;
+	if (!checked_for_redirection && git_dir) {
+		char *buf;
+		struct stat st;
+		int fd;
+		size_t len;
+		int gitdirlen =3D strlen(git_dir);
+		int workdirlen =3D strlen(workdir_for);
+
+		checked_for_redirection =3D 1;
+
+		/* Check if we have a .git/workdir_for redirection file */
+		buf =3D xmalloc(gitdirlen + workdirlen + 1);
+		memcpy(buf, git_dir, gitdirlen);
+		memcpy(buf + gitdirlen, workdir_for, strlen(workdir_for));
+		buf[gitdirlen + workdirlen] =3D '\0';
+
+		if (stat(buf, &st) || !S_ISREG(st.st_mode)) {
+			free(buf);
+			return 0;
+		}
+
+		/* Read the 1st line of the file */
+		fd =3D open(buf, O_RDONLY);
+		if (fd < 0) {
+			fprintf(stderr, "Error opening %s: %s", buf, strerror(errno));
+			free(buf);
+			return 0;
+		}
+		buf =3D xrealloc(buf, st.st_size + 1);
+		len =3D read_in_full(fd, buf, st.st_size);
+		close(fd);
+		buf[len] =3D '\0';
+
+		if (len !=3D st.st_size)
+			fprintf(stderr, "Error reading .git%s", workdir_for);
+
+		if (len < 4 || !is_git_directory(buf)) {
+			fprintf(stderr, ".git%s pointing to a non-proper git repo path '%s'\n=
", workdir_for, buf);
+			free(buf);
+			return 0;
+		}
+
+		git_workdir_redirection =3D buf;
+		/* buf not freed, since redirected_gitpath now points to it */
+	}
+	return git_workdir_redirection;
+}
+
 char *get_object_directory(void)
 {
 	if (!git_object_dir)
diff --git a/path.c b/path.c
index 4260952..f6332d6 100644
--- a/path.c
+++ b/path.c
@@ -46,12 +46,28 @@ char *mkpath(const char *fmt, ...)
 	return cleanup_path(pathname);
 }
=20
+static char *redirection_paths[] =3D { "config", "refs" ,"logs/refs", "o=
bjects", "info", "hooks", "packed-refs", "remotes", "rr-cache", 0 };
+static const char *get_redirected_dir(const char *req_path)
+{
+	int i =3D 0;
+	const char *redir =3D get_git_redirection_dir();
+	if (redir) {
+		do {
+			if (!memcmp(req_path, redirection_paths[i], strlen(redirection_paths[=
i]))) {
+				/* fprintf(stderr, "Looking for '%s', returning in '%s' instead of w=
orkdir/.git '%s'\n", req_path, redir, get_git_dir()); */
+				return redir;
+			}
+		} while(redirection_paths[++i]);
+	}
+	return 0;
+}
+
 char *git_path(const char *fmt, ...)
 {
 	const char *git_dir =3D get_git_dir();
 	char *pathname =3D get_pathname();
 	va_list args;
-	unsigned len;
+	unsigned len, newlen, rdlen, minlen;
=20
 	len =3D strlen(git_dir);
 	if (len > PATH_MAX-100)
@@ -60,10 +76,25 @@ char *git_path(const char *fmt, ...)
 	if (len && git_dir[len-1] !=3D '/')
 		pathname[len++] =3D '/';
 	va_start(args, fmt);
-	len +=3D vsnprintf(pathname + len, PATH_MAX - len, fmt, args);
+	newlen =3D len + vsnprintf(pathname + len, PATH_MAX - len, fmt, args);
 	va_end(args);
-	if (len >=3D PATH_MAX)
+	if (newlen >=3D PATH_MAX)
 		return bad_path;
+
+	{ /* Redirect certain files when in a workdir */
+		const char *redir =3D get_redirected_dir(pathname + len);
+		if (redir) {
+			char *pathname_redir =3D get_pathname();
+			rdlen =3D strlen(redir);
+			memcpy(pathname_redir, redir, rdlen);
+			if (rdlen && redir[rdlen-1] !=3D '/')
+				pathname_redir[rdlen++] =3D '/';
+			minlen =3D MIN(PATH_MAX-rdlen, strlen(pathname+len));
+			memcpy(pathname_redir+rdlen, pathname+len, minlen);
+			pathname_redir[rdlen + minlen] =3D '\0';
+			pathname =3D pathname_redir;
+		}
+	}
 	return cleanup_path(pathname);
 }
=20
diff --git a/setup.c b/setup.c
index 89c81e5..2c507d5 100644
--- a/setup.c
+++ b/setup.c
@@ -221,7 +221,7 @@ const char **get_pathspec(const char *prefix, const c=
har **pathspec)
  *    a proper "ref:", or a regular file HEAD that has a properly
  *    formatted sha1 object name.
  */
-static int is_git_directory(const char *suspect)
+int is_git_directory(const char *suspect)
 {
 	char path[PATH_MAX];
 	size_t len =3D strlen(suspect);
--=20
1.5.4.3.394.ga38b


--------------050108030800080001060205--

--------------enig1BE77ACFD521D3EE37FD7A84
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFHx/pJKzzXl/njVP8RArpfAJ4qqNkNIacEbVhyjqqNm5YhIbF8EgCgt/tj
9BNv+k5Mscd6bNBdpdtLeSw=
=I+U3
-----END PGP SIGNATURE-----

--------------enig1BE77ACFD521D3EE37FD7A84--
