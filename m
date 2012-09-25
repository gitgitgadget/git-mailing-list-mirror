From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: =?UTF-8?q?=5BRFC=20PATCH=200/2=5D=20gitweb=3A=20tags=20feed?=
Date: Tue, 25 Sep 2012 22:10:43 +0200
Message-ID: <1348603845-9084-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 25 22:11:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGbT4-0002B6-RB
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 22:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025Ab2IYUKo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Sep 2012 16:10:44 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:49162 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767Ab2IYUKn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 16:10:43 -0400
Received: by wibhq12 with SMTP id hq12so3967311wib.1
        for <git@vger.kernel.org>; Tue, 25 Sep 2012 13:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=QuQxn1abCFsz6ZYZirv0DqNdB4kVrxRc9QgxqexUHZg=;
        b=vOUWbp5H1gcrK0qBqdopMa7iHDkcWrkmASzoZ9T5umeZPIQH+nMdfmqkroma5Or16R
         8+IUXbnzHF+YoXqLppxrMMFRM8T/4TBDBNtGaDtUSVsz7av6V0DuZmuqFLk3ngmtBt03
         qgGEZvBiAXe6FUtte7Xo8qR0NjkmX+Xz5bm5bogdBqQAANIujBLsVm79JhOYxycZR4kK
         XAydsIxTW3kezkpT07eNYKH23DCvDi9YWxcwm8dlhww2CV+NY4L67luqNqZRpvrdyztI
         8kzCevK/SyNuW6p9a9fZ+XiVzep604obkKEmi9FPvQEK4Ri/osxdEexSUYXOAZJZpO6P
         FoSA==
Received: by 10.180.102.136 with SMTP id fo8mr24047029wib.19.1348603840993;
        Tue, 25 Sep 2012 13:10:40 -0700 (PDT)
Received: from localhost ([151.74.130.142])
        by mx.google.com with ESMTPS id ga2sm2455777wib.2.2012.09.25.13.10.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 25 Sep 2012 13:10:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.577.gff9625d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206373>

The idea of this small patchset is to generate feeds listing only tags.
This is useful to allow users to follow only the =E2=80=98stable=E2=80=99=
 (i.e. tagged, not
in-progress) releases of the project from its gitweb (e.g. because the
project doesn't have an actual website, or whatever).

It's a draft implementation, comments welcome.

Giuseppe Bilotta (2):
  gitweb: infrastructure for tags feed
  gitweb: expose tags feed in appropriate places

 gitweb/gitweb.perl | 126 ++++++++++++++++++++++++++++++++++++++-------=
--------
 1 file changed, 91 insertions(+), 35 deletions(-)

--=20
1.7.12.1.577.gff9625d
