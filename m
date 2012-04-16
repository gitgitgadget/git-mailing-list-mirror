From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH i18n 00/11] Mark more strings for translation
Date: Mon, 16 Apr 2012 19:49:52 +0700
Message-ID: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 14:51:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJlOX-0006Fw-N1
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 14:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744Ab2DPMu4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 08:50:56 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45268 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681Ab2DPMuz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 08:50:55 -0400
Received: by pbcun15 with SMTP id un15so6308548pbc.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 05:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=bd5DlDF8s28k4tfZ/Z2DxgxdwmTqSv1SyTtN//kXDe4=;
        b=wGv5Z1727ObuE6Sg6P1VdD6uoHmLjKGkbkIEvqXyLJ1Yqf2p8AMvcQRJvYFvWkffxe
         utiKjyr5GHD2C3mjZNmvVTpXVmV7ZRq2Hs7hXeKApImKBeEseF/wRwe2LGLRMMSpAhJU
         9teVbu2yv+qQnxzZeiTlB04qLDSdCky3lGPa2Q6knI/VigFjY73iBOe9wcCmdtQdRdlV
         KJKKBLc5cXu+3UUj2nNMniwa56NvpHCzgPt4nI997U6mIabFR5OnW/VHHfK+WQHid4j7
         ++tsA9cCrt7X8N+qC8YW2tc+3g9JLBZdLZeFWgauaLrjx0m6xpfXWbj90NxSol4mL6gh
         mwbw==
Received: by 10.68.202.167 with SMTP id kj7mr28308998pbc.9.1334580655550;
        Mon, 16 Apr 2012 05:50:55 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id l6sm17638306pbp.33.2012.04.16.05.50.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 05:50:54 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Apr 2012 19:50:03 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195623>

This series marks the following for translations

 - relative dates
 - git-help (and provide support for translating parseopt)
 - git-remote
 - git-index-pack
 - git-apply
 - git-bundle

Except git-help, other commands are chosen because they handle plural
form and I'd like to reuse gettext for that. There are a few conflicts
with topics on pu, but seem easy to resolve.

Jonathan Nieder (1):
  i18n: mark relative dates for translation

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (10):
  Add three convenient format printing functions with \n automatically =
appended
  i18n: parseopt: lookup help and argument translations when showing us=
age
  i18n: help: mark parseopt strings for translation
  i18n: help: mark strings for translation
  i18n: make warn_dangling_symref() automatically append \n
  i18n: remote: mark strings for translation
  i18n: apply: mark strings for translation
  i18n: apply: update say_patch_name to give translators complete sente=
nce
  i18n: index-pack: mark strings for translation
  i18n: bundle: mark strings for translation

 Makefile             |    2 +-
 builtin/apply.c      |  259 ++++++++++++++++++++++++++----------------=
--------
 builtin/fetch.c      |    4 +-
 builtin/help.c       |   58 ++++++------
 builtin/index-pack.c |  117 ++++++++++++-----------
 builtin/remote.c     |  252 ++++++++++++++++++++++++++----------------=
-------
 bundle.c             |   38 ++++----
 cache.h              |    6 +-
 date.c               |   95 +++++++++++--------
 generate-cmdlist.sh  |    2 +-
 git.c                |    2 +-
 help.c               |   34 ++++---
 parse-options.c      |   15 ++--
 parse-options.h      |    7 +-
 refs.c               |    1 +
 strbuf.c             |   33 +++++++
 strbuf.h             |    7 ++
 test-date.c          |    7 +-
 18 files changed, 517 insertions(+), 422 deletions(-)

--=20
1.7.3.1.256.g2539c.dirty
