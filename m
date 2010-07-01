From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 0/8] Improvements for t/README
Date: Thu,  1 Jul 2010 15:09:56 +0000
Message-ID: <1277997004-29504-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 17:17:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OULWM-0001tu-4u
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 17:17:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755501Ab0GAPRl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 11:17:41 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52757 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377Ab0GAPRk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 11:17:40 -0400
Received: by ewy23 with SMTP id 23so814121ewy.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 08:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=NDPafOn5ZdZMvGwXaTFp3eShSzb5nbpez9jL89sMkLs=;
        b=vZAxESVbqkPyBytwrZf4XxFhVJ+iseQ5pN5K/Q23vJ5Fb7BZTQ4DVCsFWRXK4Kexfs
         jK+8VIUle9OkZpfn/LZumsEGyFf7H78qqpTvDgnvUTn4ck5kf+WEjEW6dZrqJfJFC/+l
         6AbLq4Pm6DjdPQSktAIR/w2emLvdcGKyOLJtw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=pgF6yH5I0pCSxk4UPi59VkJ1ooZiaIKCxEY0P2HE8JwE8vJxiWWdI87BefyTCyg/cs
         Eoodu+Dj4UQpf+593dj/u4j+4zP7Y01jQiz6CVPJk0cqpXC404czrChjQrGrsyzlSDwq
         fvnWlfLA00cuHMPvmqvEIvdUopZXV/JfzuFLE=
Received: by 10.213.90.78 with SMTP id h14mr5346578ebm.57.1277997020284;
        Thu, 01 Jul 2010 08:10:20 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id v59sm10377672eeh.12.2010.07.01.08.10.18
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 08:10:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150045>

Here are the the t/README improvements I promised Junio in
<AANLkTilYoGtTIr9lIQD4sx4PRjlWYjIwSDMquREzv6eq@mail.gmail.com>, and
more. I took the opportunity while I was at it to document some
non-TAP things in the test suite like the prereq functions and
test_external_*.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (8):
  t/README: Tests are all +x, ./test, not sh ./test
  t/README: The trash is in 't/trash directory.$name'
  t/README: Typo: paralell -> parallel
  t/README: Document the prereq functions, and 3-arg test_*
  t/README: Document test_external*
  t/README: Document test_expect_code
  t/README: Add a section about skipping tests
  t/README: Document the dangers of printing "ok" / "not ok"

 t/README |  100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-----
 1 files changed, 92 insertions(+), 8 deletions(-)
