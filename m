From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: [PATCH v7 0/5] Reroll patches against v1.8.3.1
Date: Wed, 26 Jun 2013 14:19:45 +0400
Message-ID: <cover.1372240998.git.Alex.Crezoff@gmail.com>
References: <cover.1372149305.git.Alex.Crezoff@gmail.com>
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 26 12:20:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urmpf-0002gz-8R
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 12:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646Ab3FZKUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 06:20:05 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:46788 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574Ab3FZKUD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 06:20:03 -0400
Received: by mail-la0-f51.google.com with SMTP id fq12so13514478lab.10
        for <git@vger.kernel.org>; Wed, 26 Jun 2013 03:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=LGo7WkKW3Jcx4csseQWlGGX6Zeae62qF4nd1W6n8p6Q=;
        b=mxT0aBUGhcVwjsxEj24e2RhGXNQBE0xPkHkYESve0V6GdcQqcI/lLU5MwHltyBJf+y
         5Kmfk3KLFsYJSute7bL55wB7FRhDeFwhrXR+xypG87BW5YOx1SG1LvcCHIGQxuDbwwV3
         xn4q/1MN0zLSVeOOXP+bq/Doda6ON/BYWxSNw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=LGo7WkKW3Jcx4csseQWlGGX6Zeae62qF4nd1W6n8p6Q=;
        b=CohaX1mb2LODVEnw8JDmUt893iX+jbnF0uSBSFOeXRjBF88dWpCxk4LpH0EiKL7JPC
         6SVnFuhWrFtP5//bI1fpPPEvivZBnqUbrSNh8oF0exJHcRZ0ET+qc53IexVUBdyeAHM9
         aLszzR6t4D2J+zVIG+9WqHZFNSiZGxOKqSUTAujKFLpQYdR0VaZvqEey0L581tDtdKZD
         F29VoWL3HeVrx8bx4Nv9LMZdkYGhJPczYvaZNeMaOlvC0LyOR0S8E1v05ASy08HZ2Ii5
         Pznmy0mx2VLJzq+1FsOdMdjMghnk2Or/zIO1lLDDC8MLHE+ISj4XzH4U+mbWYvaM3mRK
         EIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=LGo7WkKW3Jcx4csseQWlGGX6Zeae62qF4nd1W6n8p6Q=;
        b=PSc+R1DhjN3XwzqxFAmfcIKOAbNaZn2kNd2RwY4wYP9sdvcg93C825L0UfQn9pvGvn
         y6ClxKMQbBpw44TIllSz3pt/Z7MJHcC/OZvEiznQCzw/zt/7kSGotBBpkAjfMmrg0pKQ
         JaJ29F8bKbjYbCxWduGDtkRqxfVd7wGirXueA8iA0/rxJahstrp5aDH18eL74oU+KzET
         t7M7jiwz0qK4pYbSsi1YdH2Fkjt7zcHiNtYL9ZwYyarLjAjKDm/S98YePCPHYnWW2t2K
         obsOGDnD0hS3aAmFfR9fPLR5gUQTvIVM1tH+dBgUjQSi88c7wbXpjbV5f6TTP5TePWLo
         4KwA==
X-Received: by 10.112.54.161 with SMTP id k1mr1835927lbp.21.1372242001272;
        Wed, 26 Jun 2013 03:20:01 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id a9sm6092746lbj.9.2013.06.26.03.19.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 26 Jun 2013 03:20:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.15.g5c23c1e
In-Reply-To: <cover.1372149305.git.Alex.Crezoff@gmail.com>
X-Gm-Message-State: ALoCoQlHt2wuu7FjQtw33pY2GIF7nkMSr/cf5WkmZJwi2aApFM665Ane0c+m/1IyQgBKW/NxegKj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229034>

v7 of this patch series includes the following changes against v6:
1. [PATCH v7 1/5] t6006 (rev-list-format): don't hardcode SHA-1 in expected outputs
	untouched
2. [PATCH v7 2/5] t7102 (reset): don't hardcode SHA-1 in expected outputs
	untouched
3. [PATCH v7 3/5] t4205 (log-pretty-formats): don't hardcode SHA-1 in expected outputs
	untouched
4. [PATCH v7 4/5] pretty: Add failing tests: --format output should honor logOutputEncoding
    cp1251 encoding changed to iso-8859-1 encoding already used in tests
    Test commit messages contain words ("changed" and "added") in German
    (which is covered by iso-8859-1 encoding)
    They are translated from English (verified in Russian) with Google Translate
5. [PATCH v7 5/5] pretty: --format output should honor logOutputEncoding
    builtin/reset.c:
        "const char ..., *msg;" declaration replaced with "char *msg;"
        to avoid compiler warning on the line "logmsg_free(msg, commit);"

P.S.
It's all started here [http://thread.gmane.org/gmane.comp.version-control.git/177634]

Alexey Shumkin (5):
  t6006 (rev-list-format): don't hardcode SHA-1 in expected outputs
  t7102 (reset): don't hardcode SHA-1 in expected outputs
  t4205 (log-pretty-formats): don't hardcode SHA-1 in expected outputs
  pretty: Add failing tests: --format output should honor
    logOutputEncoding
  pretty: --format output should honor logOutputEncoding

 builtin/reset.c                  |   5 +-
 builtin/rev-list.c               |   1 +
 builtin/shortlog.c               |   1 +
 log-tree.c                       |   1 +
 submodule.c                      |   1 +
 t/t4041-diff-submodule-option.sh |  25 +++--
 t/t4205-log-pretty-formats.sh    | 179 ++++++++++++++++++++-------------
 t/t6006-rev-list-format.sh       | 207 ++++++++++++++++++++++++---------------
 t/t7102-reset.sh                 |  37 ++++++-
 9 files changed, 293 insertions(+), 164 deletions(-)

-- 
1.8.3.1.15.g5c23c1e
