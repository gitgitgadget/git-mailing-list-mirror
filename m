From: Dan Aloni <alonid@gmail.com>
Subject: Re: [PATCH] Trick to force setup of a specific configured E-Mail per
 repo
Date: Wed, 3 Feb 2016 10:21:12 +0200
Message-ID: <20160203082112.GA27454@gmail.com>
References: <1454442861-4879-1-git-send-email-alonid@gmail.com>
 <20160203035648.GA20732@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 03 09:21:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQsgm-0005aZ-HL
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 09:21:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933740AbcBCIVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 03:21:20 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:33245 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933572AbcBCIVP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 03:21:15 -0500
Received: by mail-wm0-f54.google.com with SMTP id l66so151664969wml.0
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 00:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=piL5wBCKalTcPbEfdwHAQpR26ttc3p3/mg5s68ozfPE=;
        b=XKqlLhDtvrM/TPltcjM9vjIIfrURTUgAS1K2c3BfVhUAnDn+2D0T/y8R6aRYB4foIZ
         eMrge4yTv7/gMYPe0dXyvLmtvJCyAlsOqfTnIYEBryRTiBZw0jUtDs7ZKDVIzUHgJ1KA
         k1KEXjrORe1ThXV5VrerFBJlLfcKuhOVMY8TjOkaY/BjjJTaEXh7XGMINx2PPMDSuuse
         AZXewP7GWleDJBqGGWai++Hp9sA07DBbST5jm84s5Jyp1FZZXkEa8Pq4ejsa89KzetCy
         nbDjX27xBCL28zNoies/mu4cIkYbArkW0xQoOS796w7arGBMtYyLJkpEiiWUAJj61xVN
         S3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=piL5wBCKalTcPbEfdwHAQpR26ttc3p3/mg5s68ozfPE=;
        b=CrKFaW8e8Udy0YCMU1bro2KGuX+9Ykz1zGQ5NK3jFmOjWC3kza1TxnkQ/DWigvPE2u
         Gxls/2rBrMt6VwN+GEx3s9p+qaZuGmEG85JP/BnCR9yaTMDn5d3UwGBOb1Gt8Jmv8d9Q
         /kmzxc0fq9umc+cy72josvwlIceFcy9zWMXAcbYHRQCXnuZwHO3G7SPqFrE/obo80ovp
         3Y5rEjgB7efy3aWF6uFXTdhKFxBVKAptemKjb1dKXLBfsDk36UDkElPHC6EJPrAIpnU5
         fBLFA0PvMof07BBvFc7fAfizxdn7aQFprKZP2P8RMj/2uXmqSEXo5fbdbEOzwzCVf1fi
         CkGA==
X-Gm-Message-State: AG10YOS9MReWig3UvZ1mdgxa4Q1U6npnDy2zNnN04SZUzLAg92PjYRGqQs88rCiWGeVBwg==
X-Received: by 10.28.101.131 with SMTP id z125mr21720809wmb.60.1454487674454;
        Wed, 03 Feb 2016 00:21:14 -0800 (PST)
Received: from localhost ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id ct2sm5171505wjb.46.2016.02.03.00.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 00:21:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160203035648.GA20732@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285340>


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

(resend - my mailer was misconfigured)

On Tue, Feb 02, 2016 at 10:56:48PM -0500, Jeff King wrote:
> On Tue, Feb 02, 2016 at 09:54:21PM +0200, Dan Aloni wrote:
>[..]
> > +	if (strict && email && !strcmp(email, "(per-repo)")) {
> > +		die("email is '(per-repo)', suggesting to set specific email "
> > +		    "for the current repo");
> > +	}
> 
> I find it disappointing that we go back to looking for magic sequences
> in the string. Could we perhaps do this more cleanly with a new config
> option? Like a "user.guessIdent" which defaults to true, but people can
> set to false. And without that, we do not do any automagic at all; we
> get the values from the GIT_COMMITTER_* environment or the
> user.{name,email} config variables, or we die().
>[..]

Agreed. New patch attached, feel free to amend.

-- 
Dan Aloni


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Add-user.explicit-boolean-for-when-ident-shouldn-t-b.patch"

>From 35d94d4a00af70eeaf6b291ec951f555b0bc99d3 Mon Sep 17 00:00:00 2001
From: Dan Aloni <alonid@gmail.com>
Date: Wed, 3 Feb 2016 10:09:40 +0200
Subject: [PATCH] Add user.explicit boolean for when ident shouldn't be guessed

Previously, before 5498c57cdd63, many people did the following:

   git config --global user.email "(none)"

This was helpful for people with more than one E-Mail address,
targeting different E-Mail addresses for different clones.
as it barred git from creating commit unless the user.email
config was set in the per-repo config to the correct E-Mail
address.

Now, since the original 'bug' was fixed, and practically every
string is acceptable for user.email and user.name, it is best
to reimplement the feature not as an exploit of a bug, but as
an actual feature.

Signed-off-by: Dan Aloni <alonid@gmail.com>
---
 Documentation/config.txt  |  8 ++++++++
 ident.c                   | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 t/t9904-per-repo-email.sh | 36 +++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)
 create mode 100755 t/t9904-per-repo-email.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 877cbc875ec3..4c99f8f1de4f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2791,6 +2791,14 @@ user.name::
 	Can be overridden by the 'GIT_AUTHOR_NAME' and 'GIT_COMMITTER_NAME'
 	environment variables.  See linkgit:git-commit-tree[1].
 
+user.explicit::
+	This instruct Git to avoid trying to guess defaults for 'user.email'
+	and 'user.name' other than strictly from environment or config.
+	If you have multiply E-Mail addresses that you would like to set
+	up per repository, you may want to set this to 'true' in the global
+	config, and then Git would prompt you to set user.email separately,
+	in each of the cloned repositories.
+
 user.signingKey::
 	If linkgit:git-tag[1] or linkgit:git-commit[1] is not selecting the
 	key you want it to automatically when creating a signed tag or
diff --git a/ident.c b/ident.c
index 9dd3ae345255..305dc32a8eaf 100644
--- a/ident.c
+++ b/ident.c
@@ -18,6 +18,7 @@ static int default_name_is_bogus;
 #define IDENT_ALL_GIVEN (IDENT_NAME_GIVEN|IDENT_MAIL_GIVEN)
 static int committer_ident_explicitly_given;
 static int author_ident_explicitly_given;
+static int ident_explicit = 0;
 
 #ifdef NO_GECOS_IN_PWENT
 #define get_gecos(ignored) "&"
@@ -373,6 +374,23 @@ const char *fmt_ident(const char *name, const char *email,
 		die("unable to auto-detect email address (got '%s')", email);
 	}
 
+	if (ident_explicit) {
+		if (name == git_default_name.buf  &&
+		    !(committer_ident_explicitly_given & IDENT_NAME_GIVEN) &&
+		    !(author_ident_explicitly_given & IDENT_NAME_GIVEN)) {
+			die("requested explicitly given ident in config, "
+			    "but user.name is not set, or environment is "
+			    "not set");
+		}
+		if (email == git_default_email.buf  &&
+		    !(committer_ident_explicitly_given & IDENT_MAIL_GIVEN) &&
+		    !(author_ident_explicitly_given & IDENT_MAIL_GIVEN)) {
+			die("requested explicitly given ident in config, "
+			    "but user.email is not set, or environment is "
+			    "not set");
+		}
+	}
+
 	strbuf_reset(&ident);
 	if (want_name) {
 		strbuf_addstr_without_crud(&ident, name);
@@ -405,6 +423,20 @@ const char *git_author_info(int flag)
 		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
 	if (getenv("GIT_AUTHOR_EMAIL"))
 		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
+
+	if (ident_explicit) {
+		if (!(author_ident_explicitly_given & IDENT_NAME_GIVEN)) {
+			die("requested explicitly given ident in config, "
+			    "but user.name is not set, or GIT_AUTHOR_NAME "
+			    "is not set");
+		}
+		if (!(author_ident_explicitly_given & IDENT_MAIL_GIVEN)) {
+			die("requested explicitly given ident in config, "
+			    "but user.email is not set, or GIT_AUTHOR_EMAIL "
+			    "is not set");
+		}
+	}
+
 	return fmt_ident(getenv("GIT_AUTHOR_NAME"),
 			 getenv("GIT_AUTHOR_EMAIL"),
 			 getenv("GIT_AUTHOR_DATE"),
@@ -417,6 +449,20 @@ const char *git_committer_info(int flag)
 		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
 	if (getenv("GIT_COMMITTER_EMAIL"))
 		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
+
+	if (ident_explicit) {
+		if (!(committer_ident_explicitly_given & IDENT_NAME_GIVEN)) {
+			die("requested explicitly given ident in config, "
+			    "but user.name is not set, or GIT_COMMITTER_NAME "
+			    "is not set");
+		}
+		if (!(committer_ident_explicitly_given & IDENT_MAIL_GIVEN)) {
+			die("requested explicitly given ident in config, "
+			    "but user.email is not set, or GIT_COMMITTER_EMAIL "
+			    "is not set");
+		}
+	}
+
 	return fmt_ident(getenv("GIT_COMMITTER_NAME"),
 			 getenv("GIT_COMMITTER_EMAIL"),
 			 getenv("GIT_COMMITTER_DATE"),
@@ -444,6 +490,11 @@ int author_ident_sufficiently_given(void)
 
 int git_ident_config(const char *var, const char *value, void *data)
 {
+	if (!strcmp(var, "user.explicit")) {
+		ident_explicit = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "user.name")) {
 		if (!value)
 			return config_error_nonbool(var);
diff --git a/t/t9904-per-repo-email.sh b/t/t9904-per-repo-email.sh
new file mode 100755
index 000000000000..5876c9150ca6
--- /dev/null
+++ b/t/t9904-per-repo-email.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+#
+# Copyright (c) 2016 Dan Aloni
+#
+
+test_description='per-repo forced setting of E-Mail address'
+
+. ./test-lib.sh
+
+test_expect_failure 'fails commiting if clone email is not set' '
+	echo "Initial" >foo &&
+	git add foo &&
+	unset GIT_AUTHOR_NAME &&
+	unset GIT_AUTHOR_EMAIL &&
+	(git config --global --unset user.name || true) &&
+	(git config --global --unset user.email || true) &&
+	(git config --unset user.name || true) &&
+	(git config --unset user.email || true) &&
+	git config --global user.explicit true &&
+	EDITOR=: VISUAL=: git commit -m msg
+
+'
+
+test_expect_success 'succeeds commiting if clone email is set' '
+	echo "Initial" >foo &&
+	git add foo &&
+	unset GIT_AUTHOR_EMAIL &&
+	(git config --global --unset user.name || true) &&
+	(git config --global --unset user.email || true) &&
+	git config --global user.explicit true &&
+	git config user.name "test" &&
+	git config user.email "test@ok.com" &&
+	EDITOR=: VISUAL=: git commit -m msg
+'
+
+test_done
-- 
2.5.0


--r5Pyd7+fXNt84Ff3--
