From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v5 3/4] githooks.txt: Minor improvements to the grammar & phrasing
Date: Wed,  4 May 2016 20:18:47 +0000
Message-ID: <1462393128-26762-4-git-send-email-avarab@gmail.com>
References: <xmqqinz4f8mg.fsf@gitster.mtv.corp.google.com>
 <1462393128-26762-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 22:20:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay3HA-0005bI-97
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 22:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755539AbcEDUTg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2016 16:19:36 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36095 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755157AbcEDUTe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 16:19:34 -0400
Received: by mail-wm0-f46.google.com with SMTP id n129so203639198wmn.1
        for <git@vger.kernel.org>; Wed, 04 May 2016 13:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U4SG3s9xAhEIQ71/onWuNeeLojX6dUk+FgYzrLeE35w=;
        b=ujlUl0jsoqOfF/sd4CIb1Re2O4/oJ1FdixqzR04fB4fBnPNzy0vpNS7PKNXlDizqPg
         erFV7oqiV71pwWCUJw4T8HcbKQymBu37gyof12JJ5m06r+QsiuL3GAWXuACNRvc+Fgpb
         /pYb5BEHXBzZl0Tv+cfYgOKWLjCIHmnqSPB4TIC3JlD15wTbX8WIET2bnPPacjKMRlnK
         4hRLUx4hX+t7l1olJalkRnc4PhFOM27N7UEu1AxMhiw0iM0uoEW22OhFsQTw/D1Wmuv6
         LeJBz2zpf/McQQBec14q5Wq8ha37QEyi/vmIWXZ94fICe/Ww5eJx3INS2+MJEvHGIfXP
         CqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U4SG3s9xAhEIQ71/onWuNeeLojX6dUk+FgYzrLeE35w=;
        b=YfVpMlH4Mycp3rm8/GftloXtN6MBVz8Of3H7cmH19ClUypEHXVhHuNc/qAa661Dxqu
         TlrnYYW9nTSdNlK28blHWsoggbrJNcW1X+5RYRT9jHcXfVonkGn5RpDPVUGwzTmOjk7s
         tWlG7FlYShvS5iGoK1R0MXmM7ywZpLsXzosMLnZamb2+05UPKO2mSBkdQA62Kd2LatkR
         Nf2r5JrNY5/ZcVYL8Fzgh5e5TUdkEd5j/wgcA2rK70tr8SpLwBqK2PwkMjf2HvYceda0
         5EG43bNpccdXZOjwoWbKAm/GTexgcBuGeLOJ31UKo2EQ/BMgTfHSjNFvgddKPIVpFbaw
         u0fg==
X-Gm-Message-State: AOPr4FU1XbVvVH1R7KMfEwNW/T4S6UVUp4e+NZzKxpUGXciqu0dZVSY2z2j1XHT4x/DFRg==
X-Received: by 10.28.54.157 with SMTP id y29mr30905318wmh.25.1462393173380;
        Wed, 04 May 2016 13:19:33 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w79sm6795893wme.19.2016.05.04.13.19.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2016 13:19:32 -0700 (PDT)
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1462393128-26762-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293586>

Change:

 * Sentences that needed "the" or "a" to either add those or change the=
m
   so they don't need them.

 * The little tangent about "You can use this to do X (if your project
   wants to do X)" can just be shortened to "e.g. if you want to do X".

 * s/parameter/parameters/ when the plural made more sense.

Most of this goes all the way back to the initial introduction of
hooks.txt in v0.99.5-76-g6d35cc7 by Junio.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Documentation/githooks.txt | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index d28dc4c..13f9a18 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -41,15 +41,15 @@ HOOKS
 applypatch-msg
 ~~~~~~~~~~~~~~
=20
-This hook is invoked by 'git am' script.  It takes a single
+This hook is invoked by 'git am'.  It takes a single
 parameter, the name of the file that holds the proposed commit
-log message.  Exiting with non-zero status causes
-'git am' to abort before applying the patch.
+log message.  Exiting with a non-zero status causes 'git am' to abort
+before applying the patch.
=20
 The hook is allowed to edit the message file in place, and can
 be used to normalize the message into some project standard
-format (if the project has one). It can also be used to refuse
-the commit after inspecting the message file.
+format. It can also be used to refuse the commit after inspecting
+the message file.
=20
 The default 'applypatch-msg' hook, when enabled, runs the
 'commit-msg' hook, if the latter is enabled.
@@ -82,10 +82,10 @@ pre-commit
 ~~~~~~~~~~
=20
 This hook is invoked by 'git commit', and can be bypassed
-with `--no-verify` option.  It takes no parameter, and is
+with the `--no-verify` option.  It takes no parameters, and is
 invoked before obtaining the proposed commit log message and
-making a commit.  Exiting with non-zero status from this script
-causes the 'git commit' to abort.
+making a commit.  Exiting with a non-zero status from this script
+causes the 'git commit' command to abort before creating a commit.
=20
 The default 'pre-commit' hook, when enabled, catches introduction
 of lines with trailing whitespaces and aborts the commit when
@@ -124,15 +124,15 @@ commit-msg
 ~~~~~~~~~~
=20
 This hook is invoked by 'git commit', and can be bypassed
-with `--no-verify` option.  It takes a single parameter, the
+with the `--no-verify` option.  It takes a single parameter, the
 name of the file that holds the proposed commit log message.
-Exiting with non-zero status causes the 'git commit' to
+Exiting with a non-zero status causes the 'git commit' to
 abort.
=20
-The hook is allowed to edit the message file in place, and can
-be used to normalize the message into some project standard
-format (if the project has one). It can also be used to refuse
-the commit after inspecting the message file.
+The hook is allowed to edit the message file in place, and can be used
+to normalize the message into some project standard format. It
+can also be used to refuse the commit after inspecting the message
+file.
=20
 The default 'commit-msg' hook, when enabled, detects duplicate
 "Signed-off-by" lines, and aborts the commit if one is found.
@@ -140,8 +140,8 @@ The default 'commit-msg' hook, when enabled, detect=
s duplicate
 post-commit
 ~~~~~~~~~~~
=20
-This hook is invoked by 'git commit'.  It takes no
-parameter, and is invoked after a commit is made.
+This hook is invoked by 'git commit'. It takes no parameters, and is
+invoked after a commit is made.
=20
 This hook is meant primarily for notification, and cannot affect
 the outcome of 'git commit'.
--=20
2.1.3
