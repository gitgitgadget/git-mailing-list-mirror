From: Adrien Schildknecht <adrien+dev@schischi.me>
Subject: [GSoC][PATCH] userdiff: funcname and word patterns for sh
Date: Mon,  9 Mar 2015 17:36:38 +0100
Message-ID: <1425918999-11992-1-git-send-email-adrien+dev@schischi.me>
Cc: Adrien Schildknecht <adrien+dev@schischi.me>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 17:37:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV0gN-0006Cn-Td
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 17:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbbCIQh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 12:37:26 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34775 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549AbbCIQhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 12:37:25 -0400
Received: by wiwl15 with SMTP id l15so21364459wiw.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 09:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oh0oJ9zhffT5QIzjPTJhi7g78HppBPH6apQnXw9JAgo=;
        b=HfzQoWzXmFPZ+pSDpcC67AgxXS4Pz3W31So6RzhpZR29c2W7zVutxZRlsjM0A5Rnm4
         OS050r7elEtcp81os1VVyYW2N5xFKp8ajbaA5wli7fAPqiqci3U2jpBoh5tWbTC0vBTN
         MBREUC7jQ23FqCsiVc70GNfGS3J+e2/fvy+Sa65niyxAMppdxJwtyfxZE7ueDrMyLVSW
         HxDyMB+SqdUirSniA/Q9G5rR4Vs0rV7zYmRGjVmRmCTYRknSNZbpsAyuM7YUNTWaBels
         jTA6T4C5ZI+QQzDxqEMkpFPwjQ8AFgrqEiZImiYHLwkxBnFxPt0kOq1yFXru7V0sX1KH
         2uGg==
X-Gm-Message-State: ALoCoQkoOoiZjicQNDBmkmoinIPZ1qHdVIblQVn8YVEAkvNnVV4b8t5MPYf2WpIqfeuwk4HO8KT+
X-Received: by 10.180.90.166 with SMTP id bx6mr60826943wib.65.1425919044021;
        Mon, 09 Mar 2015 09:37:24 -0700 (PDT)
Received: from archischi.lse.epita.fr (lse.epita.fr. [163.5.55.17])
        by mx.google.com with ESMTPSA id cn10sm16218646wib.15.2015.03.09.09.37.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Mar 2015 09:37:23 -0700 (PDT)
X-Mailer: git-send-email 2.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265176>

Hi,
I'm a french student from EPITA and I plan to apply for the GSoC.

Adrien Schildknecht (1):
  userdiff: funcname and word patterns for sh

 Documentation/gitattributes.txt |  2 ++
 t/t4018-diff-funcname.sh        |  1 +
 t/t4018/sh-function             |  4 ++++
 t/t4018/sh-function-comment     |  6 ++++++
 t/t4018/sh-function-nested      |  7 +++++++
 t/t4018/sh-function-prefix      |  4 ++++
 t/t4018/sh-function-string      |  4 ++++
 t/t4034-diff-words.sh           |  1 +
 t/t4034/sh/expect               | 46 +++++++++++++++++++++++++++++++++++++++++
 t/t4034/sh/post                 | 36 ++++++++++++++++++++++++++++++++
 t/t4034/sh/pre                  | 36 ++++++++++++++++++++++++++++++++
 userdiff.c                      |  7 +++++++
 12 files changed, 154 insertions(+)
 create mode 100644 t/t4018/sh-function
 create mode 100644 t/t4018/sh-function-comment
 create mode 100644 t/t4018/sh-function-nested
 create mode 100644 t/t4018/sh-function-prefix
 create mode 100644 t/t4018/sh-function-string
 create mode 100644 t/t4034/sh/expect
 create mode 100644 t/t4034/sh/post
 create mode 100644 t/t4034/sh/pre

-- 
Adrien Schildknecht
http://schischi.me
