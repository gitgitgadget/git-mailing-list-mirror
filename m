From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] git-patch-id.txt: show that you can pipe in git-log
Date: Wed, 16 Feb 2011 10:53:06 +0000
Message-ID: <1297853586-812-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 16 11:53:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppf0e-0004eH-Um
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 11:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313Ab1BPKxU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Feb 2011 05:53:20 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34045 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107Ab1BPKxT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 05:53:19 -0500
Received: by wyb28 with SMTP id 28so1180544wyb.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 02:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=pIk91SRtapV6kL4McU41W+DrcJvhgZfDN7dRP3aUBoY=;
        b=p/a5HfOLIPsqmvIXQX2eSF8H8lJMOCM36OtD0FYn4mBGxF/tXBqDoc9CoE6FCUl/jh
         De74/LUXP3trGxEWGYNfrSy30jgaJh+CCQ1CzSf96+Kp+zMyxfxOYLkQSF6F0nt/ZOET
         0PEnIurg3mLCyPyL8E7+v+RkMRoanaCgxNMFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=a32fXKdm8MS5Vv5mmh6SVBcV7oH4PcPbM+nKluU7lEw7jDRHa1jdhpbGnTbuMuVRtW
         frJtthD9xgUtzrrrgI0iOWu9PyyyFltOSRqqKAb286+GAYJkWERG9KV4WvjlM1SYu88W
         q1++GXQJ/rgWAWXwbKo+Smw53qHfThWtasygE=
Received: by 10.227.146.144 with SMTP id h16mr341800wbv.221.1297853597918;
        Wed, 16 Feb 2011 02:53:17 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id r80sm7444wei.15.2011.02.16.02.53.14
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Feb 2011 02:53:15 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166957>

Change the manual page for git-patch-id(1) to mention in the SYNOPSIS
that you can pipe in the git-log(1) output.

The manual page only mentioned that you could pipe in `< patch`, I had
to grep the test suite to find that you could do things like `git log
-p -1 | git patch-id`.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Documentation/git-patch-id.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-i=
d.txt
index 4dae139..fec2cf3 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -9,6 +9,8 @@ SYNOPSIS
 --------
 'git patch-id' < <patch>
=20
+'git log --pretty=3Dformat:%H -p | git patch-id'
+
 DESCRIPTION
 -----------
 A "patch ID" is nothing but a SHA1 of the diff associated with a patch=
, with
--=20
1.7.2.3
