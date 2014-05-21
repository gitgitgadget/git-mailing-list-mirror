From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v7 0/2] format-patch --signature-file <file>
Date: Wed, 21 May 2014 14:07:50 -0700
Message-ID: <1400706472-13471-1-git-send-email-jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 21 23:08:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnDk6-0002Ua-CN
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 23:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263AbaEUVIC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 17:08:02 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:53328 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072AbaEUVIB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 17:08:01 -0400
Received: by mail-pb0-f41.google.com with SMTP id uo5so1774020pbc.14
        for <git@vger.kernel.org>; Wed, 21 May 2014 14:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=9G6a6I4t9tkQe+YPcbkKDzQbqCWYnTWeLP9YluCryFY=;
        b=wRh55pcVqsuihAKKsQTeYRXkvpwyEILlxYl4lL5FxIHptFtdKtd7aGWNzH0p9gATZH
         z0ehRvWUfx2w+5hLVNtUUk4ypjAhnXJWjc9Q9WzJoHZKHK8n+MvJtc11W1zb8NowrU1I
         qN6uJuB0j63WhMsvtWtyiiYNz3dT+ibJztiqM4pxSgEnzjSpV8oXcpfEh4CF1U/pd/Q9
         7G6vZ1F2Lch6x4WpvpL6JLYcMe+WBAOYKkVwervKp/QrSr8qJRUY0Kcwz3VXzj6q+Rtw
         TbrOSV/+OMSt4ErdbgVFpbFNGi5t8OU0R1Ud3kQn3Hd+kPB1pa5D9cmUjAuxBzmshyJ4
         fWOQ==
X-Received: by 10.66.164.104 with SMTP id yp8mr40796393pab.89.1400706480571;
        Wed, 21 May 2014 14:08:00 -0700 (PDT)
Received: from hudson (o247-linksys-rtr.CSUChico.EDU. [132.241.18.53])
        by mx.google.com with ESMTPSA id fk4sm109826924pab.23.2014.05.21.14.07.57
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 14:07:59 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Wed, 21 May 2014 14:07:56 -0700
X-Mailer: git-send-email 2.0.0.rc3.19.gd74db96.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249829>

v7 of patch to add format-patch --signature-file <file> option.

This revision includes a patch from Jeff King to fix the odd number
spaces produced by print_signature().

Jeff King (1):
  format-patch: make newline after signature conditional

Jeremiah Mahler (1):
  format-patch --signature-file <file>

 Documentation/config.txt           |  4 ++++
 Documentation/git-format-patch.txt |  4 ++++
 builtin/log.c                      | 25 +++++++++++++++++++++++--
 t/t4014-format-patch.sh            | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+), 2 deletions(-)

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
