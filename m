From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/8] builtin/mv.c cleanup
Date: Fri,  8 Aug 2014 20:10:54 +0700
Message-ID: <1407503462-32632-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 15:11:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFjww-0000Ns-71
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 15:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756549AbaHHNLK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2014 09:11:10 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:47265 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080AbaHHNLI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 09:11:08 -0400
Received: by mail-pd0-f180.google.com with SMTP id v10so5236967pde.25
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 06:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=VOjhjiOgkrxSs21m1cIv6LSz2ja3qk20YC086TJ4UKg=;
        b=HDFGGRfED3XIo1Ewm6bb8U2t2bEe7qLzwp1wErv+ZyMpjCsjP1UlS5CnpFlXUyDs4T
         T4AvJMCveZQpOfEfdzVIy6m1GujhStV3wHEBw+W8hGI1GKjGBOYg6le7ZQFke8z6nyfS
         WHEwsPRHRvhfhmvlllA32DDcfqOHS4UoBM4+qPMdCQk/1zXDbK90um8UzlvvQMdv/OGT
         MRPHMcYtC35fuH6zNG//pdsb8ohKALDxnHJwRqhRItKZWOWfIBl29cH2OgmwXREvXD3f
         3Ox0hx8VycuN2DSRxVr1xQPGVeIh3IZpC3HU1Ao73ihATtdklZ9G7q8hJW6/L1f1p7s9
         4RNA==
X-Received: by 10.68.181.67 with SMTP id du3mr23965407pbc.96.1407503468107;
        Fri, 08 Aug 2014 06:11:08 -0700 (PDT)
Received: from lanh ([115.73.206.39])
        by mx.google.com with ESMTPSA id t5sm3010994pbs.4.2014.08.08.06.11.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Aug 2014 06:11:07 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 08 Aug 2014 20:11:10 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255006>

I was looking at builtin/mv.c for pathspec support and ended up
cleaning it up a bit. The first patch is definitely good. The rest
could be questionable. Although the output in the end looks better in
my opinion.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (8):
  mv: mark strings for translations
  mv: no "Huh?" to the user
  mv: flatten error handling code block
  mv: split submodule move preparation code out
  mv: remove an "if" that's always true
  mv: move index search code out
  mv: unindent one level for directory move code
  mv: combine two if(s)

 builtin/mv.c | 168 +++++++++++++++++++++++++++++----------------------=
--------
 1 file changed, 84 insertions(+), 84 deletions(-)

--=20
2.1.0.rc0.78.gc0d8480
