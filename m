From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 0/5] ref-transactions-rename
Date: Wed, 18 Jun 2014 10:24:26 -0700
Message-ID: <1403112271-21331-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 19:24:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxJbG-0007Qo-BM
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 19:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858AbaFRRYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 13:24:38 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:61608 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbaFRRYf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 13:24:35 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so146553qcz.2
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 10:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=JJHPmvNR6ZOij0K416OC6lsjI4qYJ2tLkg0JdgCSK5A=;
        b=HaGDX79qM/6QF4ZwADrYPAgTkV6Sllmmak544hxd0EVHjqUVN3VaCjMvDC9okT07Uh
         FKqPvPu0ykAad2yNrK59AfbZk6aq1rER0uJbpk9ncOSsi4fmOAIF8yNtr52E2PMMXSMB
         o90VnWFvFImDv2lt8Y5hgivC4Ykh5xcLn1Hz9wpkqx9ebM0AVy59Lr9wONXNbvdxCZWi
         IopCifF+RMLXsLuUI6WN+nVC2cTleqWwTRKcUXUwdJ277OcgPQ+Tg0rjnSGtYcLvFim5
         iGkuhE2YTFjA56VIYmf3tqFpzG6/HsOHZvOaBi+5W92Ne9VNg1bjhVkHiz2ktxPQhr57
         RCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JJHPmvNR6ZOij0K416OC6lsjI4qYJ2tLkg0JdgCSK5A=;
        b=iUB1ZFw2XFjpCFUxpFvTfW4UBFnZ2A5+/c/L9ikVTd1Ak/8q0zF5R7ti7BcMCT1LTy
         ancI3x17srXVofkCr3SlS6Xv/+21BOvNbBja9IP3B5L+YuftN/egUCk0hv23qKPGN6CD
         pnMSK8+9dt1MrSjuHfSXIkFeEP0IwD/k92kfUzV7D+7D4IoEcNNLhXsYFmM4dGREBZMV
         h7iCrqEMY30xTY9xu4nDvbJpcJEHX5vLcvuPYiNZXgk6rPlnE4S3E+rN3JIxDSUwJ8x1
         GYGy5HDK5OsGaf8CGlmKE3jZWH1rcYwfqkgp4DeNb2Bu2XHwB3ce5Pjnorgy4nSZTqFQ
         f/WQ==
X-Gm-Message-State: ALoCoQnoamL3j5bg7sZAWTbArWDC88oABBjfm1IjLFkZrNdF4R3QeMYy1HzO/h6E9sx/J9du9RrD
X-Received: by 10.58.99.2 with SMTP id em2mr1370689veb.33.1403112274775;
        Wed, 18 Jun 2014 10:24:34 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si175014yhl.7.2014.06.18.10.24.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jun 2014 10:24:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 9EEF45A48AF;
	Wed, 18 Jun 2014 10:24:34 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3CA2AE075A; Wed, 18 Jun 2014 10:24:34 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.467.g08c0633
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252007>

These patches can also be found at:
https://github.com/rsahlberg/git/tree/ref-transactions-rename
This series is based on, and applies ontop of, the previous
ref-transactions-reflog series, also found at my githup repo.

This series updates the reflog handling and converts rename_ref to use a
single transaction to delete the old ref, create the new ref and to move
the reflog.

In order to make the transaction fully atomic we also introduce support
for using the packed refs file for performing the delete-and-create that
is done during the rename. This means that the rename operation is
fully atomic for all external observers and there is no longer a point in
time where the sha1 is unreferenced, after the old ref has been deleted
but before the new ref has been created.

Additionally, since we now use the transaction API for the reflog changes
we no longer need to disallow renames for refs whose reflogs are symbolic
links.


Version 3:
 - Updated to build ontop of current ref-transactions-reflog


Ronnie Sahlberg (5):
  refs.c: allow passing raw git_committer_info as email to
    _update_reflog
  refs.c: return error instead of dying when locking fails during
    transaction
  refs.c: use packed refs when deleting refs during a transaction
  refs.c: update rename_ref to use a transaction
  refs.c: rollback the lockfile before we die() in repack_without_refs

 builtin/remote.c  |  13 +-
 refs.c            | 368 +++++++++++++++++++++++++++++-------------------------
 refs.h            |   1 +
 t/t3200-branch.sh |   7 --
 4 files changed, 209 insertions(+), 180 deletions(-)

-- 
2.0.0.467.g08c0633
