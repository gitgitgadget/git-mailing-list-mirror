From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 00/23] backend-struct-db
Date: Wed, 13 Aug 2014 13:14:44 -0700
Message-ID: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 22:15:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHexE-0008JA-0x
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 22:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753702AbaHMUPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 16:15:12 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:55960 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353AbaHMUPK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 16:15:10 -0400
Received: by mail-ob0-f202.google.com with SMTP id wp18so69949obc.5
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 13:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=LtiTWDz7ikVcoDKWfkLzIn1Wkaf2Va+p1sTVuYhvG0Q=;
        b=gW/E5djqqin4KNR6DxIyiILPVREIUVHZOwa8Rr+dCfHC2BfaWSVEj35dGzMsaOuBvj
         LF5rAujBduJb25z90z8hzZRE+Au2fSn6ZU982wx5LV3XE0HSU1YQ1bsNPbc13FtkAEHY
         L+EEYfnwYnwDn53WPqkn6ueNT9TBDID9tfgWZQKj5yWC6oqhk47poqEVPVrEc++++MpD
         gNO0fLOSH5u66+9ziN/xYiJegnCRyEgOwgW7jxX/5lQRbKmLuu49epxfSl99SkBHypq9
         wRzfZON89hpy6ub0bZDolBHWWVa7elejVRjBc87RzExIPAom35L5m+tXPn1ptSw57jMC
         nEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LtiTWDz7ikVcoDKWfkLzIn1Wkaf2Va+p1sTVuYhvG0Q=;
        b=dHmKlbb28wR4rOJdjBSXkEX4uEJFLympMAQA6zgS7SW9RNl4rfzACltcWpPAd8yMPT
         czbArwiqPQIlHhyOk9m2dYS6Fpu8HccTJfOatDQdAQmMqvIHYsVszUtc9e/5tLUW//9y
         QzY/C4MwWNDAC9bs+VQyI9jmxf30+voti2+sPsqtnX8cZvMMLivFC2f1QAflgtjdHfdh
         wv5pzTwet+r5rTKKZJIgFvB4UXDIeKmWg/ppWUCY/o0AVXLMM2tr0HwCXoVzUndUBx/t
         XeOoqj7t3cvCTQYuGnu/8YtJ4RhkofEDqEagvCPvB4XvQiuw4cPI2AAhXbwV0mbDMRFB
         O7vw==
X-Gm-Message-State: ALoCoQkm9m26z5KAvUrusYDgeBjdBfQXaDGfZ6YuR5m5xOh+GfEw94jD0VQvWLkDDFxAeiE1Vq6X
X-Received: by 10.182.45.162 with SMTP id o2mr2808584obm.20.1407960909833;
        Wed, 13 Aug 2014 13:15:09 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si209190yhk.4.2014.08.13.13.15.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Aug 2014 13:15:09 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id AB1A75A43D3;
	Wed, 13 Aug 2014 13:15:09 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4AD3DE0AA0; Wed, 13 Aug 2014 13:15:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.gfa712f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255231>

List, please review

This series is called backend-struct-db and is also available at
https://github.com/rsahlberg/git/tree/backend-struct-db

This series is built on and follows after the series
ref-transactions-send-pack


This series does not change any logic or behaviour but mainly just shuffles
code around and adds method pointers for the backend functions.

The first patch adds a new public function for checking if a refname is
available or not. This function is needed not because we want to have
different is_refname_available semantics for different backends, we don't,
but because its implementation is quite dependant on the backend type.

15 of the patches, the refs-common.c patches, focuses on moving all backend
agnostic refs functions to a common file. This file will contain all
backend agnostic refs functions.

The last 6 patches adds a backend structure with the methods we need to
describe a pluggable backend. Currently we only have one built in backend,
the current files based backend. These patches do not change any of the
behavior other than that we now call the methods through backend specific
wrapper functions rather than calling them directly.


At this stage we now have a defined set of methods needed for a refs
backend and we can start building and adding new types of ref backends
to git.


Version 2:
- Do not use C99 style initializers as suggested by David Turner.
- Make head_ref_namespaced a common function instead of a backend function


Ronnie Sahlberg (23):
  refs.c: create a public function for is_refname_available
  refs-common.c: create a file to host all common refs code
  refs-common.c: move update_ref to refs-common.c
  refs-common.c: move delete_ref to the common code
  refs-common.c: move rename_ref to the common code
  refs-common.c: move read_ref_at to the refs common file
  refs-common.c: move the hidden refs functions to the common code
  refs-common.c: move dwim and friend functions to refs common
  refs-common.c: move warn_if_dangling_symref* to refs-common
  refs-common.c: move read_ref, read_ref_full and ref_exists to common
  refs-common.c: move resolve_refdup to common
  refs-common.c: move check_refname_component to the common code
  refs-common.c: move is_branch to the common code
  refs-common.c: move names_conflict to the common code
  refs-common.c: move prettify_refname to the common code
  refs-common.c: move ref iterators to the common code
  refs-common.c: move head_ref_namespaced to the common file
  refs.c: add a backend method structure with transaction functions
  refs.c: add reflog backend methods
  refs.c: add methods for misc ref operations
  refs.c: add methods for head_ref*
  refs.c: add methods for the ref iterators
  refs-be-files.c: rename refs.c to refs-be-files.c

 Makefile        |    3 +-
 refs-be-files.c | 3323 ++++++++++++++++++++++++++++++++++++++++++++
 refs-common.c   |  966 +++++++++++++
 refs.c          | 4082 -------------------------------------------------------
 refs.h          |  111 ++
 5 files changed, 4402 insertions(+), 4083 deletions(-)
 create mode 100644 refs-be-files.c
 create mode 100644 refs-common.c
 delete mode 100644 refs.c

-- 
2.0.1.556.g3edca4c
