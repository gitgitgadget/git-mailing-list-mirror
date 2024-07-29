Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236B1187343
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722279402; cv=none; b=FIElUfQlEjMeTFF38ss41s6RbfaH5p+oZplkrTMXP8wUTv0WGwK5WG4ho9MEqwHSnd+CKYa0fFHWkPQMwQMA2ag8efL/+UDmja+FBuatO78aAYaYig0KQtVI5iKHewTc4zlSVIkmROnKbMUMtBU0PK0exXkNFPm8slZUq/tXt3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722279402; c=relaxed/simple;
	bh=iaxOIlcqNCQ21Aas9XC56Q70EtRp4N4ba5JyPzZ3hOU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Rpt6JNi+hRHVVk7YNYrbyRcErlGfv9lIxNFq5z3+tZNqSV6naBr3l9HaMuXxsT9JUGbLM7NCXb4Bdtw4aeGP+6Aixxo0OceGZAgUi9PCAcdhbEg+KKLsTF1uQytmfV+5qjmEIX9QQiDWFRdCeRjSdhKuyzn1GCPsXEUxhYRotqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=MGGL0ztg; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="MGGL0ztg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1722279397; x=1722884197;
	i=johannes.schindelin@gmx.de;
	bh=ru51iNDjQW5GhruR/7YohsPzy82vZORH912szb9X6DU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 Content-Type:MIME-Version:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MGGL0ztgkN1bnqWjAdRzJwxjA0COPm6fKGKA6DaPB5T9Gx0IO7bwLUgxnEpscdMJ
	 4ewCw6TiMG46csZpa7VQMx4cMrx9IKHcEDqsjISWuSloNxRlcnnQL8ZkzkDHRVHot
	 zlPnLlfVkFKbTpqZH6PBTCg+4PQlM60ZNUy3agm+kFmR0H/IT1gbBIWg8qzPcg5qM
	 Sdi94pKJzbIO3OFataG4jH9KcxR/jrhW6ckyLLKMvrWlx6+9+SufMhyDFnHqYCa9j
	 6HNzotFKuvMdvhVzBNCZHNrEaXT8qmPKCx6ctF/p9sI5jjKeExcFvY0kyIawSn7mw
	 2pPQ36GKiRDYKKmSsQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az2036-168.iv4ntxrv1cnexhy5pcnegwfxga.cx.internal.cloudapp.net
 ([20.161.78.10]) by mail.gmx.net (mrgmx005 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MuUnA-1sG9cF1XHe-00yvCb; Mon, 29 Jul 2024 20:56:37 +0200
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git-for-windows@googlegroups.com,
	git@vger.kernel.org,
	git-packagers@googlegroups.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.46.0
Date: Mon, 29 Jul 2024 18:56:35 +0000
Message-ID: <20240729185635.3414-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Fcc: Sent
X-Provags-ID: V03:K1:NguyLu58xM1FfrkG3sZmwAby9Oy9rc4CnUzQlEZlFKyzlIO2eMh
 Rv03U4uUR26zFTXfrw+9IR5yaHp4v1drdiSxKzqmrlcOJr8pFnw1H/pabYt1wWH557E+B6a
 CqWIgu2f02URHMGGt5ztGWGVLDrvEhT7j3IocqWYNYYR0d4m8mmVIc2CSYcPKZ8+Q5jcA5d
 BlN/GYsxQaWKxXzkMMTHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ow4zFfRdeuM=;Edsb9W3YOm38FqByk4nVheYWJrJ
 DAcD7SUIdLe/PsKtBNawP5bY79j5g/W40Cx9iVSpdkl1WhXWsNmLYh3KtkNLNTCk0xC3cDea5
 m93CsnfEvyu2N7BqB5xYLDLBcQKgb21EApt79Exj+rojtVs8b9K+4Zdcp+IGZZP1ciHucGyW5
 AMVUUJ4ezFRwD1aRAUbx9PaIDjFww/TIL7/xikDh5Dv8F2IRfCiZDoV4/QRrsOppWHuqMHXbA
 Ca48jZ8fhX4meC1rNGqKUqakQX3IFWYYpypRq03/SY1kRK3MEXLguwqvq+Iba6hYT6xwyRLjm
 PVbsyIihUSKUgjJy0hw+YVLSPdh+9kw+4/2IfMoSc+UnCGWFgdwB0hUaEWZtOikUlNDUEqjE2
 F/7NuvQf7Qg5LQaUC48wPwxeAYDgQCDAp89YiBW32QHoGV4gVwr0S4Flxst7g0EkcnuNFvqYC
 OCtuS+Shy02PX8qoV3IwVxxU8g/PoR5QId1h/l7vXK1d26kgpQKSAje+khuZkQtWIFw0HMlDl
 tkI0deSH5ZI58fdmAwjMIWslWWS/5VcXDLfya3fyeAPcepl8VOS4jXAdrN6kRpha4K3sONOIj
 xXppXkpX2oZld17WHSiVSJ0WihcEiD/LokIwA0K/xxR0L7ws8RU2YUjzeynC+5d+jbZbElAPe
 OMim9s8fMN9YpKhkoXm7ojTrsvQH9gko2ba7iQAMUtjBlq0ib7cdBtxuGJSaGgsKC7+NhqdjE
 MgPls7o4swGdoTAIYY31U/g6pD1p2mDyviYF0AN7KBSdNlzcRA9X7db3jXfgw1YdXyEqY3Yqv
 VbY3IQJ+LPYXJKC4xvt+isAw==

Dear Git users,

I hereby announce that Git for Windows 2.46.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.45.2 (June 3rd 2024)

Git for Windows for Windows v2.46 is the last version to support for
Windows 7 and for Windows 8, see MSYS2's corresponding deprecation
announcement (Git for Windows relies on MSYS2 for components such as
Bash and Perl).

Please also note that the 32-bit variant of Git for Windows is
deprecated; Its last official release is planned for 2025.

New Features

  * Comes with Git v2.46.0.
  * Comes with OpenSSL v3.2.2.
  * Comes with PCRE2 v10.44.
  * Comes with OpenSSH v9.8.P1.
  * Comes with Git Credential Manager v2.5.1.
  * Comes with MinTTY v3.7.4.
  * git config respects two user-wide configs: .gitconfig in the home
    directory, and .config/git/config. Since the latter isn't a
    Windows-native directory, Git for Windows now looks for Git/config
    in the AppData directory, unless .config/git/config exists.
  * The FSMonitor feature is no longer experimental, and therefore no
    longer offered as installer option. Users are encouraged to enable
    this on a per-repository basis, via the config setting
    core.fsmonitor=true (scalar clone does this automatically).
  * The server-side component of OpenSSH, which had been shipped with
    Git for Windows for historical reasons only, is now no longer
    distributed with it.
  * Comes with cURL v8.9.0.

Bug Fixes

  * Git Bash's ls command can now be used in OneDrive-managed folders
    without having to hydrate all the files.
  * Git LFS v3.5.x and newer no longer support Windows 7. Instead of a
    helpful error message, it now simply crashes on that Windows
    version, leaving the user with the error message "panic before
    malloc heap initialized". This has been addressed: In addition to
    the unhelpful error message, Git is now saying what is going on and
    how to get out of the situation.
  * As of v2.45.0, the manual pages of git clone and git init were
    broken, which has been fixed.

Git-2.46.0-64-bit.exe | e6337d172590cea1f673acfeef218733e9352adeb863a3a9e8fa20ee0719a40f
Git-2.46.0-32-bit.exe | 8f330c0f33499ee6438d337351c1cc2354fbc067a63713ec4fb83ec1bd001ca3
PortableGit-2.46.0-64-bit.7z.exe | dedae83f4d0851bcbf473c516701e2da6a5d7c574d694d5eceec46d1307132ea
PortableGit-2.46.0-32-bit.7z.exe | 5a5b07eabc2737f1fa2e00cdf19559f385859d42b717afbf5d19bad371182d86
MinGit-2.46.0-64-bit.zip | 9f3c58e50e265043b1dd7bdaea9db4e2f23b939c189aa0fc820eb8dcfee523be
MinGit-2.46.0-32-bit.zip | 479f2de8a230a884f68ae7009b07e5581b07cecf593cc749d6961215af63b6d6
MinGit-2.46.0-busybox-64-bit.zip | 7c9296c007398188cd9a831840d6f8952ecd16aea775152fa237ca164ea07392
MinGit-2.46.0-busybox-32-bit.zip | b8a211098a72d5b86e30a86321ac2d037a64d4677dd1ac786338d12273b0dffb
Git-2.46.0-64-bit.tar.bz2 | 6eb8f52f61e50b3009fc93c57c50d430799423ab8f027ad837b713df2d3efb16
Git-2.46.0-32-bit.tar.bz2 | a420c89679838b6167c1d91396a067fe346b456e01c8464647b3f5c783c5c711

Ciao,
Johannes
