From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 12/17] Documentation: remove stray backslashes in rev-parse
 manual
Date: Fri, 20 Aug 2010 05:35:03 -0500
Message-ID: <20100820103503.GL10407@burratino>
References: <20100820101902.GA10356@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 12:36:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmOy2-0004yJ-FI
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 12:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683Ab0HTKgt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Aug 2010 06:36:49 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46311 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510Ab0HTKgo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 06:36:44 -0400
Received: by iwn5 with SMTP id 5so688982iwn.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 03:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=UEUkGsFx7n+BhgzFnrLplVtRFn3Cccc7pqeixL95URg=;
        b=IMHnZh3jf2qYrD/5MCmIIFHfI4avg4zS1JUVeiGG5nHtyqa3M7cObw1ocDAYeBRvrk
         N+jOmZ6Wpmckdl3ndKTA2+TB3d/fV2Sp0+kl46+JlsjzaDKo/waP7SqFJ/cD/+i1QKmT
         bsF6f6F554FPJrXXXDMfz4HWjbXLNnZ7zTDPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=IXr9Xg3bwWt8LlqIBuH/o46HM9gvGbJwh5m88fANOKSDS42Crh6un6YJepkybXmk51
         hOvV5j5BKpZ63vylhvWwNaHcVj4AobojcSgJIgA251BeAZpzGKAUTIpm0d72NUydEffY
         ZsQkw9+dJ8t0O9NANEQhnmLIgbSo4lPSiBcls=
Received: by 10.231.183.200 with SMTP id ch8mr1417611ibb.124.1282300603865;
        Fri, 20 Aug 2010 03:36:43 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id e8sm2497109ibb.20.2010.08.20.03.36.43
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 03:36:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100820101902.GA10356@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154007>

Use the {asterisk} entity instead of \* or * to avoid both
stray backslashes in output and suppression of asterisks
misinterpreted as a bold-text delimiter.

Reported-by: Fr=C3=A9d=C3=A9ric Bri=C3=A8re <fbriere@fbriere.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-rev-parse.txt |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-pa=
rse.txt
index be4c053..341ca90 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -74,7 +74,7 @@ OPTIONS
 	properly quoted for consumption by shell.  Useful when
 	you expect your parameter to contain whitespaces and
 	newlines (e.g. when using pickaxe `-S` with
-	'git diff-\*'). In contrast to the `--sq-quote` option,
+	'git diff-{asterisk}'). In contrast to the `--sq-quote` option,
 	the command input is still interpreted as usual.
=20
 --not::
@@ -112,14 +112,15 @@ OPTIONS
 +
 If a `pattern` is given, only refs matching the given shell glob are
 shown.  If the pattern does not contain a globbing character (`?`,
-`\*`, or `[`), it is turned into a prefix match by appending `/\*`.
+`{asterisk}`, or `[`), it is turned into a prefix match by
+appending `/{asterisk}`.
=20
 --glob=3Dpattern::
 	Show all refs matching the shell glob pattern `pattern`. If
 	the pattern does not start with `refs/`, this is automatically
 	prepended.  If the pattern does not contain a globbing
-	character (`?`, `\*`, or `[`), it is turned into a prefix
-	match by appending `/\*`.
+	character (`?`, `{asterisk}`, or `[`), it is turned into a prefix
+	match by appending `/{asterisk}`.
=20
 --show-toplevel::
 	Show the absolute path of the top-level directory.
--=20
1.7.2.2.536.g42dab.dirty
