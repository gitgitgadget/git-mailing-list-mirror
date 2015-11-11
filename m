From: =?UTF-8?B?0JDQvdC00YDQtdC5INCg0YvQsdCw0Lo=?= <rybak.a.v@gmail.com>
Subject: [PATCH] Documentation: make formatting more consistent
Date: Wed, 11 Nov 2015 18:47:25 +0300
Message-ID: <CACayv=gEGY-JNfu26fOzztXwhV_bkG8pv_iOXLC5L-Mig9f0kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 16:47:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwXcl-0002xf-Ks
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 16:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbbKKPrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 10:47:47 -0500
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35558 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbbKKPrr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 10:47:47 -0500
Received: by lfdo63 with SMTP id o63so18359263lfd.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 07:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=d/wMejo3/s23+nNzB6WVAmXO+sFVqZoGet/CUNz1rwE=;
        b=F4D5N4BMAnX1/WRN6mq6qEiHbsdT3NMVhLu5XGka4Os2ZxPpSawSSjdziI5RIJEyCl
         HqSTxA/Ke2u9C5s2FqszykQwzqkuWCtXnTvHsUPiUaz9LjQdsew/QF2TFXRwlbkDtTvA
         UO+uar4dMsguZIfYP8d7mbGD14eq3Lsvm57/5H0ldvtYCeI9TvqlHinPAteiekoyGNsa
         T29KYAit0q/QQMxbzN5Ef6iYJZ3PnAZz2iT8ar3fuKjxQF4ZSqilCQQV8XbIpoe4VbAy
         r+2c5Yl1p2VVQpuLbWLUx2Ts+Ea56Z5C+SkeGa00P8OnMF5OFn6b0q9ZU8W2VM2E75Jm
         EAXg==
X-Received: by 10.25.18.93 with SMTP id h90mr4886301lfi.7.1447256865355; Wed,
 11 Nov 2015 07:47:45 -0800 (PST)
Received: by 10.112.185.68 with HTTP; Wed, 11 Nov 2015 07:47:25 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281170>

Documentation/git.txt: enclose all Environment Variables in single quotes.

Signed-off-by: Andrey Rybak <rybak.a.v@gmail.com>
---
Documentation/git.txt is not consistent in the way it stylizes mentions
of Environment Variables. Most of them are enclosed in single quotes,
some are enclosed in backticks, some are not enclosed.

 Documentation/git.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index c2e2a94..900272b 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1056,7 +1056,7 @@ of clones and fetches.
  cloning of shallow repositories.
  See 'GIT_TRACE' for available trace output options.

-GIT_LITERAL_PATHSPECS::
+'GIT_LITERAL_PATHSPECS'::
  Setting this variable to `1` will cause Git to treat all
  pathspecs literally, rather than as glob patterns. For example,
  running `GIT_LITERAL_PATHSPECS=1 git log -- '*.c'` will search
@@ -1065,15 +1065,15 @@ GIT_LITERAL_PATHSPECS::
  literal paths to Git (e.g., paths previously given to you by
  `git ls-tree`, `--raw` diff output, etc).

-GIT_GLOB_PATHSPECS::
+'GIT_GLOB_PATHSPECS'::
  Setting this variable to `1` will cause Git to treat all
  pathspecs as glob patterns (aka "glob" magic).

-GIT_NOGLOB_PATHSPECS::
+'GIT_NOGLOB_PATHSPECS'::
  Setting this variable to `1` will cause Git to treat all
  pathspecs as literal (aka "literal" magic).

-GIT_ICASE_PATHSPECS::
+'GIT_ICASE_PATHSPECS'::
  Setting this variable to `1` will cause Git to treat all
  pathspecs as case-insensitive.

@@ -1087,7 +1087,7 @@ GIT_ICASE_PATHSPECS::
  variable when it is invoked as the top level command by the
  end user, to be recorded in the body of the reflog.

-`GIT_REF_PARANOIA`::
+'GIT_REF_PARANOIA'::
  If set to `1`, include broken or badly named refs when iterating
  over lists of refs. In a normal, non-corrupted repository, this
  does nothing. However, enabling it may help git to detect and
@@ -1098,7 +1098,7 @@ GIT_ICASE_PATHSPECS::
  an operation has touched every ref (e.g., because you are
  cloning a repository to make a backup).

-`GIT_ALLOW_PROTOCOL`::
+'GIT_ALLOW_PROTOCOL'::
  If set, provide a colon-separated list of protocols which are
  allowed to be used with fetch/push/clone. This is useful to
  restrict recursive submodule initialization from an untrusted
-- 
2.5.3.windows.1
