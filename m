From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v3 4/4] api-builtin.txt: explain common command groups
Date: Sun, 03 May 2015 02:24:51 +0200
Message-ID: <55456AD3.7090908@gmail.com>
References: <554405D5.9080702@gmail.com> <55456990.6000509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 03 02:25:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YohiO-0001cu-7I
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 02:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbbECAY5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 May 2015 20:24:57 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34246 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbbECAYz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 20:24:55 -0400
Received: by wicmx19 with SMTP id mx19so53394402wic.1
        for <git@vger.kernel.org>; Sat, 02 May 2015 17:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=06UkvYeSU9ZiTlPp00uqNQO0eOdI6KhroFLV9NCSuCg=;
        b=RimTt5hPDu9dgrOc4/Z2w77rJdD/kMJyVs3a5hBUqHWNNFcD5lBw1EoDV0P3VqhtzY
         1xVCuRyn4Uo9zysRQyQzqlA/bB3yN383LyyPJ+THF2T1HNi4SjnJ5IFFAfD+/YqmIioX
         5uk87aeVfqp9eil/Ae2z16MvIj8TSboA8TCvFtXCK6Mp9cG0B+PGIsGNiqGFgPkULRw0
         levIdD6XyNvnkwCdimndT3D+RPrPx1Zpr8VkgKKwsFFRtygNV4wePudLN1o/0QvbJZ86
         gjfxm2aSXQXmv+xrxyQFowWA1x/CaRWEvHFzaVIdGRdHfbUHVHEmtX5wxxCpPfdY7nsa
         vwKQ==
X-Received: by 10.180.81.3 with SMTP id v3mr7926853wix.36.1430612694317;
        Sat, 02 May 2015 17:24:54 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id gs7sm4399260wib.10.2015.05.02.17.24.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 May 2015 17:24:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <55456990.6000509@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268245>

Update api-builtin.txt to explain how to add the group information
for common commands.

Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
---
  Documentation/technical/api-builtin.txt | 6 +++++-
  1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-builtin.txt b/Documentation/te=
chnical/api-builtin.txt
index 22a39b9..76baba8 100644
--- a/Documentation/technical/api-builtin.txt
+++ b/Documentation/technical/api-builtin.txt
@@ -50,7 +50,11 @@ Additionally, if `foo` is a new command, there are 3=
 more things to do:
 =20
  . Write documentation in `Documentation/git-foo.txt`.
 =20
-. Add an entry for `git-foo` to `command-list.txt`.
+. Add an entry for `git-foo` to `command-list.txt`. If foo is consider=
ed
+  a 'common' command, add 'common-x_group' as the third value,
+  where x_group is one of the existing themes:
+
+	git-foo        mainporcelain common-3_worktree
 =20
  . Add an entry for `/git-foo` to `.gitignore`.
 =20
--=20
2.4.0
