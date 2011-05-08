From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 00/48] i18n: Add shell script translations (depends on infrastructure)
Date: Sun,  8 May 2011 12:20:32 +0000
Message-ID: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:21:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ2zQ-0003Sr-8E
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881Ab1EHMVb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:21:31 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37472 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570Ab1EHMVa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:21:30 -0400
Received: by eyx24 with SMTP id 24so1325598eyx.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=/4j/CjrsLHTn8nlgotED5wYM1BO3nTXN3Jhc5ZoYn/I=;
        b=caNZEcEDG2dzD4ysDzhQtrEvXusJM0AeL7iy8AWcCacQZJfTd/5j4oVJvuScQ3Exp6
         RaRC9cllLHrdnXeqt3oRCqidpBKqKy9yTebuSSsvKpP6eU2VdNdeVOAbDdr/zsDrvOkk
         I+mzS6leltXXwKlQKSO0lUqTX4WMY9ryMhxnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=DUd3R4bQz9DvGK1wNfjRSzMQAsTZwmGMZFFlFSVFuXArU3XK5Kfaw0X3HA1izrOLbT
         rBcgUuUiopLJ16NNFw6QSvymCP8tbA4+pH5UIg3nnMe0eTzCKlwcabeeh/EQvVHWSStl
         /zhgUgtaMWeNwad2H84WgMqgpyd+/SCTfDG1g=
Received: by 10.213.12.196 with SMTP id y4mr160451eby.16.1304857289441;
        Sun, 08 May 2011 05:21:29 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.28
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173104>

This series builds on the "i18n: Add shell script translation
infrastructure" series and adds the translations for the common *.sh
programs.

Changes since last time:

 * Fixed up for new broken tests under gettext poison

 * Now using the test_i18ncmp and test_i18ngrep functions

 * Ejected some git-pull patches:

    pick 969ef13 i18n: git-pull split up "no candidate" message
    pick 8eb125e i18n: git-pull "You asked to pull" message
    pick c7d7d56 i18n: git-pull "[...] not currently on a branch" messa=
ge
    pick 43e6a9f i18n: git-pull "rebase against" / "merge with" message=
s

   These were all used by error_on_no_merge_candidates and recently
   split into git-parse-remote. It's too hard to keep rebasing these
   when the code is being changed from under me, I'll submit a series
   to do these separately once this series is in master.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (48):
  i18n: git-am add git-sh-i18n
  i18n: git-am one-line gettext $msg; echo
  i18n: git-am multi-line getttext $msg; echo
  i18n: git-am eval_gettext messages
  i18n: git-am echo + gettext message
  i18n: git-am die messages
  i18n: git-am cannot_fallback messages
  i18n: git-am clean_abort messages
  i18n: git-am "Apply?" message
  i18n: git-am "Falling back" say message
  i18n: git-am core say messages
  i18n: git-am printf(1) message to eval_gettext
  i18n: git-pull add git-sh-i18n
  i18n: git-pull die messages
  i18n: git-pull eval_gettext + die message
  i18n: git-pull eval_gettext + warning message
  i18n: git-submodule add git-sh-i18n
  i18n: git-submodule echo + eval_gettext messages
  i18n: git-submodule say + eval_gettext messages
  i18n: git-submodule die + eval_gettext messages
  i18n: git-submodule $update_module say + die messages
  i18n: git-submodule "cached cannot be used" message
  i18n: git-submodule "Submodule change[...]" messages
  i18n: git-submodule $errmsg messages
  i18n: git-submodule "Entering [...]" message
  i18n: git-submodule "[...] path is ignored" message
  i18n: git-submodule "path not initialized" message
  i18n: git-submodule "blob" and "submodule" messages
  i18n: git-stash add git-sh-i18n
  i18n: git-stash echo + gettext message
  i18n: git-stash say + gettext messages
  i18n: git-stash die + gettext messages
  i18n: git-stash die + eval_gettext messages
  i18n: git-stash die + eval_gettext $* messages
  i18n: git-stash die + eval_gettext $1 messages
  i18n: git-stash "unknown option" message
  i18n: git-stash drop_stash say/die messages
  i18n: git-bisect add git-sh-i18n
  i18n: git-bisect gettext + echo message
  i18n: git-bisect echo + gettext messages
  i18n: git-bisect echo + eval_gettext message
  i18n: git-bisect die + gettext messages
  i18n: git-bisect die + eval_gettext messages
  i18n: git-bisect bisect_run + $@ messages
  i18n: git-bisect bisect_reset + $1 messages
  i18n: git-bisect bisect_replay + $1 messages
  i18n: git-bisect [Y/n] messages
  i18n: git-bisect bisect_next_check "You need to" message

 git-am.sh                    |   74 ++++++++++++++++++----------------
 git-bisect.sh                |   92 +++++++++++++++++++++++-----------=
-------
 git-pull.sh                  |   31 +++++++-------
 git-stash.sh                 |   73 ++++++++++++++++++++-------------
 git-submodule.sh             |   92 +++++++++++++++++++++-------------=
-------
 t/t4150-am.sh                |    2 +-
 t/t4151-am-abort.sh          |    5 +-
 t/t7400-submodule-basic.sh   |    4 +-
 t/t7401-submodule-summary.sh |   12 +++---
 t/t7406-submodule-update.sh  |    2 +-
 t/t7407-submodule-foreach.sh |    4 +-
 11 files changed, 214 insertions(+), 177 deletions(-)

--=20
1.7.4.4
