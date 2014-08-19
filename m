From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 00/23] backend-struct-db
Date: Tue, 19 Aug 2014 09:30:24 -0700
Message-ID: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:30:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmJD-0002Gk-Gg
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbaHSQav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:30:51 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:41613 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbaHSQau (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:30:50 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so798402yhl.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kYUHJycTZe9D0dwmEvFrGAxex14xqrE34GjrZHtSSPU=;
        b=e5m4P+MKc+GFD7dj3Q27VCNy/U8CHzfzwUpGBUpI2chV7IIfjK4Wyg7/LSKibsSSUb
         Pc8qnjtF7+qbyUPDW8MT7tf123PC6sDf3CrfKB9q0qYRogAnnXXyzWPGhXWBc9CmYOSe
         XIE9gFS9LwwsNgVEhGGRYtETXgIM7WV6HNDU1ymEAQnKelWjUNc22V2FW6bk37qqJe2Y
         GMoHS6CkstsgXag0Q4sQt5uvb4M6oA1Eeau84ftC2dlJC+UlJ3d7RCC9W3aZ9spuAkfA
         XnIWpaU16OYHdbliNKNbwd1WhGy+qAE7HiwS3ojBUdQKXafC3sqZxMf3c+p3DbN0Wu5l
         mSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kYUHJycTZe9D0dwmEvFrGAxex14xqrE34GjrZHtSSPU=;
        b=XV2GAM9oc3AymHKRArOEv4Zxegeb7OQBCUgzGk7lA9YiAqbF0vYzIBfgqmqTEkkF6I
         EcIh4H0BbmdHLJiI2iJoBWvmSCG39MkaHbYeEGdoEnyuwVoS7/FWGZQTGqutBca7hwZN
         munwdq57itPwY6b0/0u7pU2f5mJvY5mdjJLELM/8qbord5HMqhZt2X+MRLsI13okR5tS
         Aup6q4cpnm+xzjE+3Y5nHaQiDcMBZD5awxyMQonYc+tFLDuYHRVkWA+SFLKTzZc0NG5r
         8YzlIbb1UVpzC5hwK4eEh6tV5Dqht+MjbrdG+hwXaKiZDdml+zbN7BHxcLXT8orvyPAN
         QGWQ==
X-Gm-Message-State: ALoCoQnE2STVfjjQ2Wu0TNvdNlp2qqU9XGDf+eWBwWJYVUA3UDi4VYnFEiLpLCDHOv8yCaRNT4bY
X-Received: by 10.236.108.172 with SMTP id q32mr10144662yhg.0.1408465850162;
        Tue, 19 Aug 2014 09:30:50 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id x19si332767yhg.0.2014.08.19.09.30.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:30:50 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 01B0831C534;
	Tue, 19 Aug 2014 09:30:50 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 9620DE0E84; Tue, 19 Aug 2014 09:30:49 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.552.g1af257a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255476>

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


Version 3:
- Rework the patches so that we host the common functions in refs.c
  instead of refs-common.c
Version 2:
- Do not use C99 style initializers as suggested by David Turner.
- Make head_ref_namespaced a common function instead of a backend function


Ronnie Sahlberg (23):
  refs.c: create a public function for is_refname_available
  refs-be-files.c: rename refs to refs-be-files
  refs.c: add a new refs.c file to hold all common refs code
  refs.c: move update_ref to refs.c
  refs.c: move delete_ref to the common code
  refs.c: move rename_ref to the common code
  refs.c: move read_ref_at to the common refs file
  refs.c: move the hidden refs functions to the common code
  refs.c: move dwim and friend functions to the common refs code
  refs.c: move warn_if_dangling_symref* to the common code
  refs.c: move read_ref, read_ref_full and ref_exists to the common code
  refs.c: move resolve_refdup to common
  refs.c: move check_refname_component to the common code
  refs.c: move is_branch to the common code
  refs.c: move names_conflict to the common code
  refs.c: move prettify_refname to the common code
  refs.c: move ref iterators to the common code
  refs.c: move head_ref_namespaced to the common code
  refs-be-files.c: add a backend method structure with transaction
    functions
  refs-be-files.c: add reflog backend methods
  refs-be-files.c: add methods for misc ref operations
  refs-be-files.c: add methods for head_ref*
  refs-be-files.c: add methods for the ref iterators

 Makefile        |    1 +
 refs-be-files.c | 3330 +++++++++++++++++++++++++++++++++++++++++
 refs.c          | 4457 +++++++++----------------------------------------------
 refs.h          |  107 ++
 4 files changed, 4110 insertions(+), 3785 deletions(-)
 create mode 100644 refs-be-files.c

-- 
2.0.1.552.g1af257a
