From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 0/4] [PULL] ab/i18n-prereqs, prerequisites for ab/i18n
Date: Sun, 14 Nov 2010 14:44:13 +0000
Message-ID: <1289745857-16704-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 14 15:45:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHdpg-0003SW-37
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 15:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755868Ab0KNOpP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 09:45:15 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52333 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725Ab0KNOpO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 09:45:14 -0500
Received: by wyb28 with SMTP id 28so3561989wyb.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 06:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=61pScFYVjhp+zHtosRJwvOkvFAfnyqwlTk0OqsYXgi0=;
        b=abRfVQN22CWn2JTyD6q/ziU0GDIQdxI6hT03gkatyyCA7ZCjrP4s3vY6rphTIeEMIU
         6vV4v9Jj4SSLexCQwte9e3cE4SdCh8+4d2vMzcr3OMK3SjcjqqVzN4EVmDBrwPSM41K1
         GEYzTyQEkqqmUcyrzRM4zZHKbRl1jA/N3UQpE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=e6gAfxPWmIE83Nbd5snoPorVS8Y2VRG5/HXg8FepdvnMsnPN+4vUHLZ+ADLjhdolS3
         9KAv21z7E+bOUlx8DJR2NEra2qaXdqSD/9DyD936NjTS+lLOYh7xmbJLnNpHWBDYnCp6
         cZld/9f8eiB2oHFBrIhs8nBy+yEtTEgCVJeQI=
Received: by 10.227.144.13 with SMTP id x13mr4966766wbu.213.1289745912616;
        Sun, 14 Nov 2010 06:45:12 -0800 (PST)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id y15sm3208613weq.6.2010.11.14.06.45.11
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 06:45:11 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.326.g36065a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161411>

These are the first four patches in the ab/i18n series which aren't
strictly related to it, but merely fixes to issues I encountered.

I'm submitting these separately now in the hope that they'll make it
to the next & master branches before ab/i18n. Having these separately
reviewed should be easier for everyone.

These patches can also be fetched from:

    git://github.com/avar/git.git ab/i18n-prereqs

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
  Makefile: move "Platform specific tweaks" above LIB_{H,OBJS}
  t7004-tag.sh: re-arrange git tag comment for clarity
  tests: use test_cmp instead of piping to diff(1)
  builtin: use builtin.h for all builtin commands

 Makefile                         |  687 +++++++++++++++++++-----------=
--------
 builtin/clone.c                  |    3 +-
 builtin/fetch-pack.c             |    2 +-
 builtin/hash-object.c            |    2 +-
 builtin/index-pack.c             |    2 +-
 builtin/merge-index.c            |    2 +-
 builtin/merge-recursive.c        |    2 +-
 builtin/merge-tree.c             |    2 +-
 builtin/mktag.c                  |    2 +-
 builtin/pack-redundant.c         |    2 +-
 builtin/pack-refs.c              |    2 +-
 builtin/patch-id.c               |    2 +-
 builtin/receive-pack.c           |    2 +-
 builtin/remote.c                 |    3 +-
 builtin/reset.c                  |    2 +-
 builtin/send-pack.c              |    2 +-
 builtin/unpack-file.c            |    2 +-
 builtin/var.c                    |    2 +-
 t/t4041-diff-submodule-option.sh |   96 ++++--
 t/t7004-tag.sh                   |   20 +-
 t/t7401-submodule-summary.sh     |   47 ++-
 wt-status.c                      |    2 +-
 22 files changed, 472 insertions(+), 416 deletions(-)

--=20
1.7.2.3
