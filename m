From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v2 0/2] Smoke testing for Git
Date: Fri, 30 Jul 2010 22:43:25 +0000
Message-ID: <1280529807-23677-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 31 00:43:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeyIt-000545-36
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 00:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756780Ab0G3Wnl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jul 2010 18:43:41 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50558 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755197Ab0G3Wnk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 18:43:40 -0400
Received: by wyb39 with SMTP id 39so1657591wyb.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 15:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=9duMB/yMQdnX/lXQDjyBN2D6ldP9Qr8Lpw5LY1hYoPA=;
        b=IbbrB78IztTYAy50SBuOz587scfeO1CsGM5j5Jq5mj3gIDwnbFdgrcQrBk0nocUa+9
         nqUF7r4R798tVBgHg0Mep50xTKymHJMcg1cEKpK15+4sm2aV39n/DUcDDQBmO7xvmRz1
         JCk+2SZsJ4SNqnLQvrQUSaQ/ZRUW+Hmj6ObKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=eitL3gpLlVVK9LujJOuMPrwPYt+0TTj5lEfsKzrk/5yvbxicLH6D3XLUBVOnKqstx8
         f0YC/GEAWVrjFQDsyyVENbDPGqE3G9xUojb0GobnKkLdxGJ3tI3o3mHnYi+kVSftFNmM
         XKPpr5MHoUoV+ke1sNvjqT8fNpW8wd/HUOTJs=
Received: by 10.227.129.136 with SMTP id o8mr2056336wbs.174.1280529818628;
        Fri, 30 Jul 2010 15:43:38 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id i25sm2309162wbi.22.2010.07.30.15.43.37
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 15:43:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152269>

This is v2 of the smoke testing RFC. It solves the TODO issues noted
in v1 of the RFC. There's now a smoke testing infrastructure for Git
at http://smoke.git.nix.is/, and this patch adds bits to git to
interoperate with it.

There's a lot more info in the first patch, and t/README documentation
in the second one.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
  tests: Infrastructure for Git smoke testing
  t/README: Document the Smoke testing

 t/Makefile |   35 ++++++++++++++++++++++++++++++-
 t/README   |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 t/harness  |   21 +++++++++++++++++++
 3 files changed, 121 insertions(+), 1 deletions(-)
 create mode 100755 t/harness
