From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/7] Diff rename, manual correction, round 2
Date: Wed, 20 Jan 2016 18:06:01 +0700
Message-ID: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 12:06:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLqay-0003OR-2F
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 12:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbcATLG1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2016 06:06:27 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36328 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934160AbcATLGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 06:06:25 -0500
Received: by mail-pf0-f195.google.com with SMTP id n128so256937pfn.3
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 03:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=IPPJWuy/Zi2mrc4LDybxvqeCsdkimZoFMJ7z7B/w7iE=;
        b=xMXzwnn9Z7lb4siqEo4dJOtxxDkzCujXtHPm0rlceSx18liWWr/Maw1YM99/lsdlPK
         ud/LIlsYOhKjY74dKJj53Htsy1Qf6ek8EjsQDSxGyp/cyOlDrUldPjrxxfG5V03TQs37
         gypQPfYMX3m5INEATAH1iqsG2UM13cr06hnXc8VZbS5UqjXDzWY5+Zhbaa8pP9P0V3ME
         lsaaIr3akKedsxoLhGlWFErHqfb6rcqXawtTtoWn0jfaKLimG2LrDB8+MSOPfBgPUIli
         PVanOporjQkcrSXsX8QXI+Y6qJBJgQwD5tZVdW7Hg2B0Z8yapdKKljsR8nS1NAojKofC
         hyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=IPPJWuy/Zi2mrc4LDybxvqeCsdkimZoFMJ7z7B/w7iE=;
        b=evJUEKAo8hgZZIYhW3HDe+Fe/Ew1koUFb4RHNCS/8UYzfkXW0BzGjn4dnek8np/jtf
         7mnnI9HgniCDN4vx4jhIEu7sQ2/WiQeaYYuIZPdhQyE61CL+KB/X/4WLvSs+TZaMJQ6a
         KA20bUIdCzcMsd/QBuw9VYaeG48Ce1OjA/kGD+YKdFb1aQLh+uAmBrX3tF6C8DwfPcIH
         7/wM2LmNvw5+I4g9ZwlaZFepZVXs2hvYIilIE9OOhKVPV1w77SJUv3/8gqlyoqbqeXMd
         rTwZMljMdShalhZnw5dinQnqzkrkNCkb2N8mUD9NSyEONlcwKRrHznoHH43KPCy1rSLf
         OkxQ==
X-Gm-Message-State: ALoCoQmavjRNgs23zM9B7j4+tP+GHR3Ee6vDQ9L9u5zAXoHcEcThzj/KBKmLCuDn20KEiJ3kA1QmQ+Dgc4XffIAQncyMlOJERA==
X-Received: by 10.98.12.21 with SMTP id u21mr51160305pfi.36.1453287984720;
        Wed, 20 Jan 2016 03:06:24 -0800 (PST)
Received: from lanh ([115.72.43.83])
        by smtp.gmail.com with ESMTPSA id tp3sm48360170pac.16.2016.01.20.03.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2016 03:06:23 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Jan 2016 18:06:19 +0700
X-Mailer: git-send-email 2.7.0.125.g9eec362
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284448>

Git is amazing. It can detect file renames without you telling it. But
even the best fails sometimes. And when it fails, we have no way to
correct it. Not so amazing..

Round 1 was three years ago. The idea back then [1] was to let the
user say "rename this path to this path". Jeff quickly pointed out it
didn't help merge. And it should help merge to reduce merge conflicts.
=46or merge to take advantage of rename correction, the user needs to
spell out "rename this blob to this blob" instead. Then I went away
doing something and dropped it.

Round 2. I still want to keep "rename path to path", at least on the
user interface level. For git-merge, I do exactly what Jeff wrote back
then, traversing the whole notes tree to collect rename hints. But now
I cache the result, so while traversing is expensive, we don't have to
pay often.

The first two patches are preparation. Patch 3 adds --rename-file
where you can tell Git to "rename this path to that path" by writing a
file with lines like this

    this path =3D> that path

I will need to support quoting, but that can come later. Patch 5 is
similar.

Patch 4 adds --rename-notes, where you can now store the above file in
a notes tree. The note will be used when its associate commit A is
diff'ed against A^.

Patch 6 introduces a new syntax to that file, "blob SHA-1 =3D> SHA-1".
This is the basis for patch 7, where we traverse the whole notes tree,
convert all non-blob lines into blob ones. Then we simply tell
git-merge to use that as a rename instruction file.

Expect round 3 in 2019 (hopefully not)

[1] http://thread.gmane.org/gmane.comp.version-control.git/202654

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (7):
  diff-no-index: do not take a redundant prefix argument
  diff.c: take "prefix" argument in diff_opt_parse()
  diff: add --rename-file
  log: add --rename-notes to correct renames per commit
  merge: add --rename-file
  diffcore-rename: allow to say "rename this blob to that blob"
  merge: add --rename-notes

 Documentation/diff-options.txt   |   7 +++
 Documentation/pretty-options.txt |   5 ++
 builtin/am.c                     |   2 +-
 builtin/diff.c                   |   2 +-
 builtin/merge.c                  | 123 +++++++++++++++++++++++++++++++=
++++++++
 diff-no-index.c                  |   7 ++-
 diff.c                           |  13 ++++-
 diff.h                           |   5 +-
 diffcore-rename.c                | 104 +++++++++++++++++++++++++++++++=
+-
 log-tree.c                       |  32 ++++++++++
 merge-recursive.c                |   1 +
 merge-recursive.h                |   1 +
 revision.c                       |  12 +++-
 revision.h                       |   1 +
 t/t4001-diff-rename.sh           |  82 ++++++++++++++++++++++++++
 15 files changed, 386 insertions(+), 11 deletions(-)

--=20
2.7.0.125.g9eec362
