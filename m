From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/3] commit --cleanup=<scissors marker>
Date: Mon, 17 Feb 2014 19:15:29 +0700
Message-ID: <1392639332-7703-1-git-send-email-pclouds@gmail.com>
References: <1392521840-21628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 17 13:16:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFN7E-0000tM-Bb
	for gcvg-git-2@plane.gmane.org; Mon, 17 Feb 2014 13:16:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbaBQMPx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Feb 2014 07:15:53 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:47997 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbaBQMPv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Feb 2014 07:15:51 -0500
Received: by mail-pd0-f180.google.com with SMTP id x10so14835843pdj.39
        for <git@vger.kernel.org>; Mon, 17 Feb 2014 04:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0B4MM37+VXtQ6YVsQOhFkxCnA2Rj7oQ9Bk4AVUszCXk=;
        b=fE4u6UTwQ+nsDiMMkX+wdDwxX7thIRl+zERYr5h75bcR3BvUkvpYbqcTMLyep3+uNa
         YcO+iMdqu4y/3k8n0+xIamBq9sDAePqOAEdW4nceQ5IEEKmtuEZdPJ37VZ6hkfTG5AoI
         rhZlkdq0wmd38YOM84X/fO7VmzTGaMkLOhBCxK3H6qwQXMDFkiZg8CLdF9DEkpLk/g1k
         reoeGqe4V1jVcTM2NQCzV4lagdBdhHFyOsUvoM2YvsF6Ht28rgA8UDQnCaZHbf9xEGtY
         HsVY9v1PTg1aoqOBAiJdW5RUA+FMFZKfV54cq0VulTj7g7xeSYRUqth9CSPU034wVmdb
         R+9w==
X-Received: by 10.66.139.196 with SMTP id ra4mr26266137pab.103.1392639351457;
        Mon, 17 Feb 2014 04:15:51 -0800 (PST)
Received: from lanh ([115.73.228.211])
        by mx.google.com with ESMTPSA id id1sm45244413pbc.11.2014.02.17.04.15.48
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 17 Feb 2014 04:15:50 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 17 Feb 2014 19:16:02 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392521840-21628-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242255>

Slight changes in git-commit.txt and some commit messages after Brian
and Eric's comments.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  wt-status.c: make cut_line[] const to shrink .data section a bit
  wt-status.c: move cut-line print code out to wt_status_add_cut_line
  commit: add --cleanup=3Dscissors

 Documentation/git-commit.txt |  8 +++++++-
 builtin/commit.c             |  9 +++++++--
 t/t7502-commit.sh            | 16 ++++++++++++++++
 wt-status.c                  | 21 +++++++++++++--------
 wt-status.h                  |  1 +
 5 files changed, 44 insertions(+), 11 deletions(-)

--=20
1.8.5.2.240.g8478abd
