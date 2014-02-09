From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/2] Ignore trailing spaces in .gitignore
Date: Sun,  9 Feb 2014 07:26:36 +0700
Message-ID: <1391905598-19198-1-git-send-email-pclouds@gmail.com>
References: <1391847004-22810-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 09 01:26:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCIEZ-0001xP-BT
	for gcvg-git-2@plane.gmane.org; Sun, 09 Feb 2014 01:26:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbaBIA0i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Feb 2014 19:26:38 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:47574 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbaBIA0i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 19:26:38 -0500
Received: by mail-pb0-f44.google.com with SMTP id rq2so4754347pbb.31
        for <git@vger.kernel.org>; Sat, 08 Feb 2014 16:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=N5xm52A+nAJa0cF8djI7ga6WRBKWvOvOsOEl6JxiT+c=;
        b=qKoZpoUdKLoh3/u4l66tLlJEXMQ6y7n8ZBNvfoddUWwMZJWbViUFW90KUUlb7cWvwf
         CClei685knBTc01tf36oz5YQQEtvO1rhgu5tAYAyaePgJjaHU5SOSiuhwW+Vv0mp4gI5
         uhmOOYa0bGjasEJqRDiNq0ni90WGatgyvryOJY0Uwp0FZtCS6ti5hHZzqZhqo2K7a8kC
         z/4KFnaACUGCuHdRFsCgeGuoL1HziVNXrsVFN0T18lk4FC3B6KVQythTAQ6ELEx/45Rc
         Y/J5UeLkCX5q7fbRb1g7VfuJDlmvd9WyyY8Nu9r894fXWL5hbxcP/Wjd+BnmYoZVde5A
         3iDw==
X-Received: by 10.66.154.169 with SMTP id vp9mr16716871pab.39.1391905596897;
        Sat, 08 Feb 2014 16:26:36 -0800 (PST)
Received: from lanh ([115.73.239.36])
        by mx.google.com with ESMTPSA id vn10sm27471215pbc.21.2014.02.08.16.26.34
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Feb 2014 16:26:36 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Feb 2014 07:26:39 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391847004-22810-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241867>

This reroll now respects backslash quoting. Thanks Jeff and Torsten
for the comments.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  dir: warn about trailing spaces in exclude patterns
  dir: ignore trailing spaces in exclude patterns

 Documentation/gitignore.txt |  3 +++
 dir.c                       | 20 ++++++++++++++++++++
 t/t0008-ignores.sh          | 31 +++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

--=20
1.8.5.2.240.g8478abd
