From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH 0/2] Mailmap in log improvements
Date: Sat, 22 Dec 2012 17:58:30 +0100
Message-ID: <1356195512-4846-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 22 18:06:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmSWk-0002j1-5R
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 18:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757Ab2LVRDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 12:03:43 -0500
Received: from mail-wi0-f171.google.com ([209.85.212.171]:48547 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695Ab2LVRDl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 12:03:41 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Dec 2012 12:03:41 EST
Received: by mail-wi0-f171.google.com with SMTP id hn14so5696893wib.4
        for <git@vger.kernel.org>; Sat, 22 Dec 2012 09:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=wUFx0/Z8kOcfkIDoR6Y+n6ylCwR5r4OkWoieFj1aXh8=;
        b=oozfuMLLiOwtD/GD9hdOl9tTnqycvvyy3BAa1Ij6ziIQWhClLtW8z5aRVVaB8XNvda
         ULj7tmFJivnF+LnWvh04xAx/a4xwslSBW85e6JSe7ZDjOsud3olZ8ctETOjdOXEd/IVp
         eZ4C3/w0aCe0Eb2xcRADQJmTbi4CmwbVFuCjdt3LDKs4xL7ljhgG9xZnfs/A7fjGVsvO
         /TKYXUEAC9deCmmWJDXbbo8/0lAJtJUG3CdlRLpTC1mhVuiH5bDBAf1d/fc4wYluuD2g
         twotnSaOs7niTJqO/WYPU7oZ+Dg30rdFYDsiIbuPoW/taHXxnvP/GDbPYM+o9/uqOPUZ
         YJZg==
X-Received: by 10.194.20.231 with SMTP id q7mr28979211wje.44.1356195519288;
        Sat, 22 Dec 2012 08:58:39 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id s10sm24125843wiw.4.2012.12.22.08.58.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 22 Dec 2012 08:58:38 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.39.g9092a12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212058>

The goal of these patches are to:

 - allow the use of mailmap when looking for commits
   authored/committed by a mapped name/email.

 - add an option so that --use-mailmap option can be used
   automatically.

Tests are included.

This series is based on ap/log-mailmap.

Antoine Pelisse (2):
  log: grep author/committer using mailmap
  log: add log.mailmap configuration option

 Documentation/config.txt |    4 ++++
 builtin/log.c            |    8 ++++++-
 revision.c               |   53 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t4203-mailmap.sh       |   42 ++++++++++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+), 1 deletion(-)

--
1.7.9.5
