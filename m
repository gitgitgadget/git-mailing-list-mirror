From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 00/51] i18n: Shell script translations
Date: Sun,  3 Apr 2011 16:45:24 +0000
Message-ID: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:46:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QRa-0004r3-EX
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702Ab1DCQqZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:46:25 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59126 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582Ab1DCQqY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:24 -0400
Received: by ewy4 with SMTP id 4so1505877ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=zYp2SwfKe+nMATBKjY5YPzXExrq9w5VsDq21fZKVS1k=;
        b=Ikblx9m23iedDLYxYqCUyfBMYcrjNCvYiURRy5U46Ju/Rf6208lkzwmtt1MNX3pozZ
         SpOp/4eQp3wwAm94QvTVGl8AeLO1cMJPCLlKTocrgw4Sn8QIbZ8cfTqXrs/ihX59yeQ1
         rqbpFX3ggkTyOqh8IwOPvatRZRFzFsRbp7ZB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=G65Q1qWOxPxiaUXvg86Go16O5KUwKlYbIG6CKpr6+4JlMR2ToAitvzndGAqp4zTdlM
         rsty/rfWNSwTvvr4kb9iF0l2Ev4SI4x87LOpDTi66/Fdv9s6tlUVeBAX5Hsz3tdHvPlP
         xHtPPsD7DaNIKhryUngCO+SEd/N0wtN7fj/ss=
Received: by 10.213.21.24 with SMTP id h24mr3139502ebb.117.1301849181853;
        Sun, 03 Apr 2011 09:46:21 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.21
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170706>

=46ollowing the "i18n: Shell script translation infrastructure"
series. These are the actual shell script translations. Together these
series add up to everything from:

    git://github.com/avar/git.git ab/i18n-sh-only

I'm hoping these two can follow the same pattern into pu/next/master
as the equivalent C series.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (51):
  i18n: git-am add git-sh-i18n
  i18n: git-am one-line gettext $msg; echo
  i18n: git-am multi-line getttext $msg; echo
  i18n: git-am eval_gettext messages
  i18n: git-am echo + gettext message
  i18n: git-am die messages
  i18n: git-am cannot_fallback messages
  i18n: git-am clean_abort messages
  i18n: git-am "Apply?" message
  i18n: git-am core say messages
  i18n: git-am printf(1) message to eval_gettext
  i18n: git-pull add git-sh-i18n
  i18n: git-pull die messages
  i18n: git-pull eval_gettext + die message
  i18n: git-pull eval_gettext + warning message
  i18n: git-pull split up "no candidate" message
  i18n: git-pull "You asked to pull" message
  i18n: git-pull "[...] not currently on a branch" message
  i18n: git-pull "rebase against" / "merge with" messages
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

 git-am.sh                    |   72 +++++++++++----------
 git-bisect.sh                |   92 +++++++++++++++------------
 git-pull.sh                  |  146 +++++++++++++++++++++++++---------=
--------
 git-stash.sh                 |   75 +++++++++++++--------
 git-submodule.sh             |   92 ++++++++++++++-------------
 t/t4150-am.sh                |    5 +-
 t/t4151-am-abort.sh          |    2 +-
 t/t7400-submodule-basic.sh   |    4 +-
 t/t7401-submodule-summary.sh |   12 ++--
 t/t7407-submodule-foreach.sh |    4 +-
 10 files changed, 284 insertions(+), 220 deletions(-)

--=20
1.7.4.1
