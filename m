From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/6] Change 'git' to 'Git' whenever the whole system
 is referred to #2
Date: Tue, 22 Jan 2013 18:48:50 -0800
Message-ID: <7vmww0k419.fsf@alter.siamese.dyndns.org>
References: <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <2009548606.632825.1358795980319.JavaMail.ngmail@webmail20.arcor-online.net>
 <7va9s0lnxn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davvid@gmail.com, git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Wed Jan 23 03:49:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxqOp-0004My-J5
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 03:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614Ab3AWCsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 21:48:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53506 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752346Ab3AWCsx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 21:48:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A712B2C3;
	Tue, 22 Jan 2013 21:48:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KeNRqT8UYBUz/NFAmLa1xSBYNtM=; b=wlxtIW
	rTMxWxgh49WFsksJE+d6jyfUMJy7lRROEoSMT+iIXZywoFmuRE/MWRW0uBYUSTYC
	BPDGj/ZvhoYgum7PS3YXoEYglQv0WAnjVgzTCzJuqR7ZUxMmHjv3lsTTui+KUCuy
	iYTSn4EfNIuZjW4HCfHZogeoHpu2jeDAkCdos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fMcRjV99IgK6v3cSZ7sOIy2xJBMZFKWS
	IvaXyGiADAxSMvExeQ1w38PjnLkysEVt3eyjK9RYviQEgMzxQG/SuQSsbHHjODqI
	ji64w4Sf42naBN5JetkkKqpItPrQOhBhjQdFq/NVhJbXTPFOCzGzQqqDAs0iMvyM
	HemQYXgS/pE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FB62B2C2;
	Tue, 22 Jan 2013 21:48:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FE32B2C0; Tue, 22 Jan 2013
 21:48:52 -0500 (EST)
In-Reply-To: <7va9s0lnxn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 22 Jan 2013 16:53:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6C04D12C-6507-11E2-B253-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214273>

Junio C Hamano <gitster@pobox.com> writes:

> As before, I'll locally create a fixup commit based on the above.
>
> After I am done with these patches, somebody (not Thomas or I, as
> our eyes are too used to staring at git and Git to notice mistakes)
> has to run "git grep -C3 -e '\<Git\>' Documentation/" and eyeball
> the output to spot mistakes that should have been "git" but was
> converted to "Git", as I am mostly concentrating on finding "git"
> that should have been converted in Thomas's series.

 Documentation/config.txt             | 4 ++--
 Documentation/git-remote-helpers.txt | 2 +-
 Documentation/git-verify-pack.txt    | 2 +-
 Documentation/gitattributes.txt      | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5a831ad2..3652ee0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2,7 +2,7 @@ CONFIGURATION FILE
 ------------------
 
 The Git configuration file contains a number of variables that affect
-the git command's behavior. The `.git/config` file in each repository
+the Git commands' behavior. The `.git/config` file in each repository
 is used to store the configuration for that repository, and
 `$HOME/.gitconfig` is used to store a per-user configuration as
 fallback values for the `.git/config` file. The file `/etc/gitconfig`
@@ -999,7 +999,7 @@ fetch.fsckObjects::
 	is used instead.
 
 fetch.unpackLimit::
-	If the number of objects fetched over the git native
+	If the number of objects fetched over the Git native
 	transfer is below this
 	limit, then the objects will be unpacked into loose object
 	files. However if the number of received objects equals or
diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index e18c3b0..e36fdcb 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -39,7 +39,7 @@ INVOCATION
 ----------
 
 Remote helper programs are invoked with one or (optionally) two
-arguments. The first argument specifies a remote repository as in git;
+arguments. The first argument specifies a remote repository as in Git;
 it is either the name of a configured remote or a URL. The second
 argument specifies a URL; it is usually of the form
 '<transport>://<address>', but any arbitrary string is possible.
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index d4ae05b..0eb9ffb 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -3,7 +3,7 @@ git-verify-pack(1)
 
 NAME
 ----
-git-verify-pack - Validate packed git archive files
+git-verify-pack - Validate packed Git archive files
 
 
 SYNOPSIS
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index b9c0eec..b322a26 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -449,7 +449,7 @@ String::
 	specify one or more options, as described in the following
 	section. The options for the diff driver "foo" are defined
 	by the configuration variables in the "diff.foo" section of the
-	git config file.
+	Git config file.
 
 
 Defining an external diff driver
@@ -675,7 +675,7 @@ attribute in the `.gitattributes` file:
 *.ps -diff
 ------------------------
 
-This will cause git to generate `Binary files differ` (or a binary
+This will cause Git to generate `Binary files differ` (or a binary
 patch, if binary patches are enabled) instead of a regular diff.
 
 However, one may also want to specify other diff driver attributes. For
-- 
1.8.1.1.507.g1754052
