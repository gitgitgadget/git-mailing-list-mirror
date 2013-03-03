From: Greg Price <price@MIT.EDU>
Subject: Re: [PATCH 2/2] describe: Exclude --all --match=PATTERN
Date: Sun, 3 Mar 2013 15:52:32 -0500
Message-ID: <20130303205232.GL22203@biohazard-cafe.mit.edu>
References: <7v1uc1jyq0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qlTNgmc+xy1dBmNv"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 03 21:53:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCFuB-0003rn-Er
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 21:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417Ab3CCUwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 15:52:37 -0500
Received: from DMZ-MAILSEC-SCANNER-1.MIT.EDU ([18.9.25.12]:45961 "EHLO
	dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753367Ab3CCUwh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Mar 2013 15:52:37 -0500
X-AuditID: 1209190c-b7f046d00000094c-b4-5133b814f781
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	by dmz-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id B4.79.02380.418B3315; Sun,  3 Mar 2013 15:52:36 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH-1.MIT.EDU [18.9.28.11])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id r23KqYw9018183;
	Sun, 3 Mar 2013 15:52:35 -0500
Received: from localhost (BIOHAZARD-CAFE.MIT.EDU [18.9.64.18])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id r23KqWYJ020535;
	Sun, 3 Mar 2013 15:52:33 -0500
Content-Disposition: inline
In-Reply-To: <7v1uc1jyq0.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsUixG6nriuywzjQoHeKoEXXlW4mi4beK8wO
	TB4XLyl7fN4kF8AUxWWTkpqTWZZapG+XwJXx7sIRxoLFUhUNC26zNjDOF+1i5OSQEDCRmHn3
	BRuELSZx4d56IJuLQ0hgH6PE4pUroZwNjBK//rayQDifGCX+f73BCtLCIqAi0XNjI5jNJqAg
	8WP+OmYQW0RATWJi2yEWEJtZQFxi3dzz7CC2sICDxOcNi8BqeAWsJe6e+cQGYQtKnJz5BKie
	A6jeSqJlAR+EKS2x/B8HxBR5ieats5lBwpwCZhILd6eChEWBDri2v51tAqPgLCRzZiHMmYUw
	ZxaSORC2jsTOrXfY8CrRlng4cSoThJ0ocartANMCRs5VjLIpuVW6uYmZOcWpybrFyYl5ealF
	uoZ6uZkleqkppZsYQTHEKcmzg/HNQaVDjAIcjEo8vBMWGAUKsSaWFVfmHmKU5GBSEuWdt8U4
	UIgvKT+lMiOxOCO+qDQntfgQowrQrkcbVl9glGLJy89LVRLh3RAOVMebklhZlVqUD1MmzcGi
	JM57OeWmv5BAemJJanZqakFqEUxWhoNDSYL33zagRsGi1PTUirTMnBKENBMH5yFGCQ4eoOGa
	20GGFxck5hZnpkPkTzHqciy49ugFoxDYBVLivHdABgmAFGWU5sHNgaXEV4ziQC8K8/4HqeIB
	plO4Sa+AljABLZmbbgCypCQRISXVwDjp7o3/eV1rOdUUDp5y9mZk8jC+cpvtqmDE9YOXprLs
	6jcqjNG9YNB0t2XfkUNZPH6aq84Jyc385f/Ya+HbK6eVD19prF2lJ9Cm/od9lkKY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217358>


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Feb 27, 2013 at 12:20:07PM -0800, Junio C Hamano wrote:
> Without "--all" the command considers only the annotated tags to
> base the descripion on, and with "--all", a ref that is not
> annotated tags can be used as a base, but with a lower priority (if
> an annotated tag can describe a given commit, that tag is used).
> 
> So naïvely I would expect "--all" and "--match" to base the
> description on refs that match the pattern without limiting the
> choice of base to annotated tags, and refs that do not match the
> given pattern should not appear even as the last resort.  It appears
> to me that the current situation is (3).

Hmm.  It seems to me that "--all" says two things:

 (a) allow unannotated (rather than only annotated)

 (b) allow refs of any name (rather than only tags)

With "--match", particularly because the pattern always refers only to
tags, (b) is obliterated, and your proposed semantics are (a) plus a
sort of inverse of (b):

 (c) allow only refs matching the pattern

which is what "--match" means alone.  But if what we are going for is
(a) and (c), then we don't need "--all" for (a) -- we can get
precisely that with "--tags".  So these semantics make "--all --match=PAT"
equivalent to "--tags --match=PAT".

Given that, I think the user is better off if we reject "--all
--match" with an error message -- and perhaps the error message should
advise them to use "--tags" instead.  Otherwise we have "--all"
telling us (b) as well as (a), and "--match" countermanding (b) and
going precisely the other direction to (c).  If the user has written
that by hand, then they may be confused, and if the command line was
generated, perhaps called from a script, then I fear a bug in the
script is likely, what with the conflicting expectations expressed by
"--all" and "--match".

Patch below to suggest "--tags" in the error message.

Greg

--qlTNgmc+xy1dBmNv
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-describe-Better-error-message-on-all-match.patch"

>From 66f985b2510c870e62e313732de4b6709894b074 Mon Sep 17 00:00:00 2001
From: Greg Price <price@mit.edu>
Date: Sun, 3 Mar 2013 12:19:57 -0800
Subject: [PATCH] describe: Better error message on --all --match

The reason they conflict is that --all means
 (a) allow unannotated, and
 (b) allow refs of any name (rather than only tags),
while --match contradicts (b) and goes further to
 (c) allow only tags matching pattern.

If what the user wants is (a) and (c), they can use --tags to get (a)
without (b).
---
 builtin/describe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 2ef3f10..6581c40 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -436,7 +436,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		die(_("--long is incompatible with --abbrev=0"));
 
 	if (pattern && all)
-		die(_("--match is incompatible with --all"));
+		die(_("--all conflicts with --match; do you mean --tags?"));
 
 	if (contains) {
 		const char **args = xmalloc((7 + argc) * sizeof(char *));
-- 
1.7.11.3


--qlTNgmc+xy1dBmNv--
