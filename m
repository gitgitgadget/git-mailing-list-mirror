From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 0/7] Improvements for t/README
Date: Fri,  2 Jul 2010 14:59:42 +0000
Message-ID: <1278082789-19872-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 02 17:00:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUhjL-00048m-By
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 17:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757672Ab0GBPAe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 11:00:34 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57428 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755703Ab0GBPAd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 11:00:33 -0400
Received: by wyf23 with SMTP id 23so1196622wyf.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 08:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=vgy7bHIgt91SxsG4RzF/i/Ff+oeRQdiiaNVIo5l+BmA=;
        b=mYeCD+nGj7DX8oZxjjTD3jGh760UM7+KAIVBcI7t//aLr2SD6JUIF/0C0XxggweEuZ
         GPyUOCMlxryNSMnKLzl3TTIf7BJob/LWK5EhhweQpL2TwWZgOZ85nhGLoDijkhg6sw4S
         +HebWJWeIPy3Y1cRIbYNjzc6hEO+0mYKIkpfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=iYc2kkGZyj+W5qQoc7l9RoW0xsEK84N7y5xCanSMvyk89DY4mLFOzL3DN1tCWONsZQ
         MAcuD+jMyUbWqs/I7b/HSzA99+t3CsNW+caL9jmebCOyqJ0AqYJ6FcMKumYPXKLO1t46
         nYvDy/Uyg8QgQaSLQSrw69MbJTi7cG1ruqTVc=
Received: by 10.213.34.205 with SMTP id m13mr3914146ebd.2.1278082831474;
        Fri, 02 Jul 2010 08:00:31 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id a48sm6206858eei.19.2010.07.02.08.00.29
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 02 Jul 2010 08:00:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150128>

Since last time:

 * Dropped the s[sh ./][./] patch
 * Typo fix: gleam -> glean

Here's the diff since v3:
   =20
    diff --git a/t/README b/t/README
    index 4d0526d..e481657 100644
    --- a/t/README
    +++ b/t/README
    @@ -55 +55 @@ You can also run each test individually from command =
line, like this:
    -    $ ./t3010-ls-files-killed-modified.sh
    +    $ sh ./t3010-ls-files-killed-modified.sh
    @@ -297 +297 @@ Don't:
    -   You can gleam some further possible issues from the TAP grammar
    +   You can glean some further possible issues from the TAP grammar

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (7):
  t/README: The trash is in 't/trash directory.$name'
  t/README: Typo: paralell -> parallel
  t/README: Document the prereq functions, and 3-arg test_*
  t/README: Document test_external*
  t/README: Document test_expect_code
  t/README: Add a section about skipping tests
  t/README: Document the do's and don'ts of tests

 t/README |  170 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++---
 1 files changed, 163 insertions(+), 7 deletions(-)
