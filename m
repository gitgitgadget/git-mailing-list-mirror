From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/4] non-blob notes fixes
Date: Fri, 11 May 2012 08:25:02 +0700
Message-ID: <1336699506-28388-1-git-send-email-pclouds@gmail.com>
References: <1336658701-9004-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 03:26:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSeca-0001pt-Cp
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 03:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757301Ab2EKB0L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 21:26:11 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:65022 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755777Ab2EKB0J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 21:26:09 -0400
Received: by dady13 with SMTP id y13so2400997dad.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 18:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=OIAEl9tDgFPT9XDRlzJMMPqGLANbIAv4V1ZCSZGSLs0=;
        b=vh11vng5+8EZmsyZFDZ6474oIomqLWw9Qwq2gPdAYSVUeZhGiS1C55CikcOJ5GwKyi
         /ZM2WFk5/XotZV3oX95YUCpsQ/PZAqC5sxGsGDm7wXRBCEFQRibtCcSH4amUzAMYtXyV
         clSKncKZHX40N52wMdZerkeID5jMivFhz71u5WALFe8Fd6yqS988iHteHNYvbXvGLKC2
         E5s0jEz/muoAdKtLpEY7+IRjCZ+ANJTC34+lBuZ+UDcpGkCKJSrIwq0yq+d2qfVNlORL
         +R58kXFDvY3LpgWuV63rgHyq1mxqsOLwXGjlLgozh4xCWalLRJM9NQ4ajOh7o0Cqqxfa
         4u9g==
Received: by 10.68.136.65 with SMTP id py1mr25760421pbb.81.1336699568638;
        Thu, 10 May 2012 18:26:08 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id rs3sm9460927pbc.47.2012.05.10.18.26.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 May 2012 18:26:07 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 11 May 2012 08:25:07 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1336658701-9004-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197649>

 - stop one-time env setting on a shell function call
 - reword error messages when appending non-blobs

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  notes: preserve object type given by "add -C"
  notes: "add -c" refuses to open an editor with non-blobs
  notes: refuse to edit non-blobs
  notes: only allow to append a blob to a blob

 builtin/notes.c  |   23 +++++++++++++++++------
 t/t3301-notes.sh |   24 ++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 6 deletions(-)

--=20
1.7.3.1.256.g2539c.dirty
