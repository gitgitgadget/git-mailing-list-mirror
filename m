From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 14/17] po/is.po: msgmerge and add Language: header
Date: Mon, 30 Aug 2010 21:28:20 +0000
Message-ID: <1283203703-26923-15-git-send-email-avarab@gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 23:30:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqBvb-0000N5-Nh
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 23:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755395Ab0H3V3T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 17:29:19 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45001 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755988Ab0H3V3O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 17:29:14 -0400
Received: by mail-wy0-f174.google.com with SMTP id 35so7081766wyb.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 14:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=pVNPNwQ24qPun0lA3hZA0fb2cjHtl3NJJazLhPnaB1I=;
        b=unc/SSpYzR1DgxNcnWdEe9quurMEb1nF4kyEmmf7WO9MhDov6sRKQv7HzsCEj6M6gB
         w6KjA0AYJWMTH05j9X15d+6GDCAJoJfuyGxOlYJCzeBqoAh8pOxc9sHBy3J8GDYJmWjg
         A0+p4Ikt31UoVZzp41Iha+oAxP9OsQMYVGwec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=a0MnFnKanVHxym8kejk5XjGNoOv084Sa5Jcu8bQSRm2wFXd1KRv+V6B+TEB0RuLGmD
         HAZGIabDYYGMNWQ5j5nj++GMbVVI+K66THcJtAGUpf06XrNi25sO2oVOb6892rD3/dtw
         RaXApMI0dsXLxZKVwpTb3JgVwp75hzwDKRslg=
Received: by 10.227.145.69 with SMTP id c5mr5181832wbv.168.1283203754304;
        Mon, 30 Aug 2010 14:29:14 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b23sm6923116wbb.22.2010.08.30.14.29.12
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 14:29:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.536.g3f548
In-Reply-To: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154859>

Change is.po to use the header order added by msgmerge(1), this'll
make subsequent diffs to it smaller and easier to manage. While I'm at
it add a Language header indicating that the file is in
Icelandic.

When we add more *.po files later we should add a Language header to
those as well.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 po/is.po |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/po/is.po b/po/is.po
index dfa3804..3bbfb97 100644
--- a/po/is.po
+++ b/po/is.po
@@ -1,10 +1,12 @@
 msgid ""
 msgstr ""
 "Project-Id-Version: Git\n"
-"PO-Revision-Date: 2010-06-05 19:06 +0000\n"
-"Language-Team: Git Mailing List <git@vger.kernel.org>\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
+"POT-Creation-Date: 2010-08-28 17:38+0000\n"
+"PO-Revision-Date: 2010-08-28 17:27+0000\n"
 "Last-Translator: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail=
=2Ecom>\n"
+"Language-Team: Git Mailing List <git@vger.kernel.org>\n"
+"Language: is\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
--=20
1.7.2.2.536.g3f548
