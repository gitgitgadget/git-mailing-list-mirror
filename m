From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] .mailmap: Map "H.Merijn Brand" to "H. Merijn Brand"
Date: Tue, 25 Jun 2013 18:39:15 +0200
Message-ID: <1372178355-18540-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: h.m.brand@xs4all.nl, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 25 18:39:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrWHI-000575-Vm
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 18:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385Ab3FYQja convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Jun 2013 12:39:30 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:53087 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358Ab3FYQj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 12:39:28 -0400
Received: by mail-ee0-f43.google.com with SMTP id l10so6860589eei.2
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 09:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=MvZssEaSlmEgML9uTStt9lyOTliSDcg40/6X2eHGWqs=;
        b=YPJWjjxMEsc4ln5XF/RnEhLAX4EYuMPqe+RyfVOItbrpLmjrd5Dfkb/RjU80nP5hsA
         1L7Hy/Ee/vFQEms8eIQ3x+kFKR2AqLiRFIEZlvGk9Ww4oEbM75nLnOeUDyZ/tjnJk6am
         u4fZaqTe7nc8ipGH2zkAGPx23zdVpsGAuke/hbnQJ3dJdy/u43jqdorQ/Vrhf+Z6qggW
         rXJHjkD/D0Izhhr8nYQNArjlxHGT92kVm6h5LN5oG6SBt6UnY7+O0MHx7IsCY/Req2PD
         KC6lgTAn+cKaG5o+ThOwQBE8vQ2ZbfWXGI6flHBWxkwHNO6ZRGl5cEBX9scM0r7rDlEn
         sOIA==
X-Received: by 10.15.54.198 with SMTP id t46mr30916544eew.74.1372178367310;
        Tue, 25 Jun 2013 09:39:27 -0700 (PDT)
Received: from localhost (ip-176-199-212-200.unitymediagroup.de. [176.199.212.200])
        by mx.google.com with ESMTPSA id b3sm37129617eev.10.2013.06.25.09.39.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 25 Jun 2013 09:39:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.587.g803fe36
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228980>

This patch was created by searching for duplicates of email addresses
in the shortlog by
    git shortlog -sne |awk '{ print $NF }' |sort |uniq -d

This will yield all email addresses, which are found multiple times wit=
hin
the shortlog. We can assume that commiters having the same email addres=
s
are indeed the same person.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 48d7acf..345cce6 100644
--- a/.mailmap
+++ b/.mailmap
@@ -24,6 +24,7 @@ Eric S. Raymond <esr@thyrsus.com>
 Erik Faye-Lund <kusmabite@gmail.com> <kusmabite@googlemail.com>
 Fredrik Kuivinen <freku045@student.liu.se>
 Fr=C3=A9d=C3=A9ric Heitzmann <frederic.heitzmann@gmail.com>
+H. Merijn Brand <h.m.brand@xs4all.nl> H.Merijn Brand <h.m.brand@xs4all=
=2Enl>
 H. Peter Anvin <hpa@bonde.sc.orionmulti.com>
 H. Peter Anvin <hpa@tazenda.sc.orionmulti.com>
 H. Peter Anvin <hpa@trantor.hos.anvin.org>
--=20
1.8.3.1.587.g803fe36
