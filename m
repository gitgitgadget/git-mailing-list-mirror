Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 667281FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 17:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932654AbdJ3RVS (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:21:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:63067 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932252AbdJ3RVA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:21:00 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYsEZ-1ddXhO1NH1-00VhzV; Mon, 30
 Oct 2017 18:20:45 +0100
Date:   Mon, 30 Oct 2017 18:20:44 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     =?UTF-8?Q?Jakub_Bere=C5=BCa=C5=84ski?= <kuba@berezanscy.pl>,
        Junio C Hamano <gitster@pobox.com>,
        Karsten Blees <blees@dcon.de>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/2] wincred: handle empty username/password correctly
In-Reply-To: <cover.1509383993.git.johannes.schindelin@gmx.de>
Message-ID: <71cf372b57f88784ca467840512dac2e9e01767b.1509383993.git.johannes.schindelin@gmx.de>
References: <cover.1509383993.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2130059316-1509384045=:6482"
X-Provags-ID: V03:K0:z+cP/mu1c8m1D/a9BfSLMCiAiR0d4sHnyO8Hwig2+i5On9pyO19
 hmfGtQT/OaklisVOvM+77urvoaqPcYXiUBZyqQwL1fwp3s7X73x4g28jy2DnxBlIa2UFca6
 1uns6Em188rJ1zDH+sE4C0/qeQm1AfHyLJHf5E26qq2YqYzEoNJBVvKQzqGUgG5jnzSoAJV
 lL+PI5Zzo7ljy9pdSyQiw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xjK+jHxiZ2o=:YdC2FkgjiCWhqivL3abahV
 jaK1WQZ5GYuqIKGKDPI9D53u/ubWZ+akr9x72/SfsNVTtEdmLgV6Mro70P8Ut1ujiKsOEq32e
 xcxV0VklhWF9WCxLDnFIAXZMsdMuJl16W6CwGgRR8eI7ZpOUVZToaCkeI7lK/QPhmle2OBni4
 bbYWUZTxa3lNQEVA/igjpsh9aW1vd4XLVwaGXUjUbwwt7oQ0HLZ9k6k56KjlRMsQuqwaTlpmz
 sCCvuwrPN88M4hHipVfoagxDlZc2QbxfLe6OqkYZSOXvgi0N1q/vUIeOebw6whVz7SaUOKun/
 D6wXRiIuCBd4iX5yqTqtrFP1gVCjMoCE5PyiGqQlviOqYMOEn5K0jeKqL/GMljV1uBb+izIip
 7iCwtZVn40IsmpJXX2aplej18ttbCR44+n/aN4h8MPntJqth2C1uKuS4sQ3S3WlefFU5ZFNvq
 CYZUaEfMe1f2P0Jg2P52laGDJxOvXvY+IyLTMrtx7bJk5jXG7eV25VLVw7g4YeMShruylFPAq
 qvVV9vOe/OeiIwywvelBl0pLJYPa7Vc4UbdzTnpq3aMe9tPmbccW0mvuEu/tHC1mEjM8qXTDv
 F9/zzzwy36ncwIqcopQZQ2OnSiWVq2PLBnaJNkJ+LU2EH6jwjL7/ldUpYuK8Hkj4JjUdYeIzL
 ZyCa7XpmPweBWUTJzukFafxdfNq8F+WHhMmkKM0V9d43D6rb4MtbYwOAlVoyGU/0s6Z7/S3Qx
 inYiKc1736nExFzY1b1XcxhJGXuiiKril8ostuYXzM3amuyvU5UHhJq61xm6NBfaitt1K+u8u
 pqP1dWc1jwEYXzH4msXtVuzUdXCsgm/fMrts4y4O4qhA9thMY3065M73pwhtxejFAKZbeF0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2130059316-1509384045=:6482
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

From: =3D?UTF-8?q?Jakub=3D20Bere=3DC5=3DBCa=3DC5=3D84ski?=3D <kuba@berezans=
cy.pl>

Empty (length 0) usernames and/or passwords, when saved in the Windows
Credential Manager, come back as null when reading the credential.

One use case for such empty credentials is with NTLM authentication, where
empty username and password instruct libcurl to authenticate using the
credentials of the currently logged-on user (single sign-on).

When locating the relevant credentials, make empty username match null.
When outputting the credentials, handle nulls correctly.

Signed-off-by: Jakub Bere=C5=BCa=C5=84ski <kuba@berezanscy.pl>
---
 contrib/credential/wincred/git-credential-wincred.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/=
credential/wincred/git-credential-wincred.c
index 006134043a4..86518cd93d9 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -94,6 +94,12 @@ static WCHAR *wusername, *password, *protocol, *host, *p=
ath, target[1024];
 static void write_item(const char *what, LPCWSTR wbuf, int wlen)
 {
 =09char *buf;
+
+=09if (!wbuf || !wlen) {
+=09=09printf("%s=3D\n", what);
+=09=09return;
+=09}
+
 =09int len =3D WideCharToMultiByte(CP_UTF8, 0, wbuf, wlen, NULL, 0, NULL,
 =09    FALSE);
 =09buf =3D xmalloc(len);
@@ -160,7 +166,7 @@ static int match_part_last(LPCWSTR *ptarget, LPCWSTR wa=
nt, LPCWSTR delim)
 static int match_cred(const CREDENTIALW *cred)
 {
 =09LPCWSTR target =3D cred->TargetName;
-=09if (wusername && wcscmp(wusername, cred->UserName))
+=09if (wusername && wcscmp(wusername, cred->UserName ? cred->UserName : L"=
"))
 =09=09return 0;
=20
 =09return match_part(&target, L"git", L":") &&
@@ -183,7 +189,7 @@ static void get_credential(void)
 =09for (i =3D 0; i < num_creds; ++i)
 =09=09if (match_cred(creds[i])) {
 =09=09=09write_item("username", creds[i]->UserName,
-=09=09=09=09wcslen(creds[i]->UserName));
+=09=09=09=09creds[i]->UserName ? wcslen(creds[i]->UserName) : 0);
 =09=09=09write_item("password",
 =09=09=09=09(LPCWSTR)creds[i]->CredentialBlob,
 =09=09=09=09creds[i]->CredentialBlobSize / sizeof(WCHAR));
--=20
2.15.0.windows.1
--8323329-2130059316-1509384045=:6482--
