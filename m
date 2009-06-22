From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4 0/2] gitweb: gravatar support
Date: Tue, 23 Jun 2009 00:49:57 +0200
Message-ID: <1245710999-17763-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 23 00:49:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIsK3-0006Y5-Cn
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 00:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbZFVWs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 18:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbZFVWs4
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 18:48:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:38633 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbZFVWsz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 18:48:55 -0400
Received: by fg-out-1718.google.com with SMTP id 16so1174459fgg.17
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 15:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=kOqiZrTDikd6jxGLdrIzuTLXYc0bzsdUu95uvEAfRgo=;
        b=YUfxm2ngig3NeBemEZbAzSCvrGuedtLmd467kZGfqc042NVT4VQQ4uzyM90ls+hNW0
         dhsAVQuBbd6vOrFVJxPijmAH1MJQ9mSg64oeaOiHGUcDjRCRnnW7iZlM3vLLZZhHJhtG
         8Kul2zOpLfK3y9EESoPRsJy/jOuG+/5YGa2s0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=XKsPYiuXh7i8r3FUtUVoq+e4SaLrmx3YQ505/u7AexHDTC9UorKIhZ149/AvM/PAXa
         O9jbB+wwODuD4uUsjRa3kScYvohKI0UxXxK6lGvkCqJmifUT2bEcTveMAj9UqNB2/q1B
         B9bAhWSTOeQ1sT5HiyTdAKpdiAbibJbUsYosE=
Received: by 10.86.36.11 with SMTP id j11mr7415525fgj.56.1245710937427;
        Mon, 22 Jun 2009 15:48:57 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-34-214.clienti.tiscali.it [94.37.34.214])
        by mx.google.com with ESMTPS id 4sm8830409fgg.2.2009.06.22.15.48.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Jun 2009 15:48:55 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122066>

As suggested by Junio, the author display refactoring now comes before
the actual gravatar feature implementation. The refactoring also goes a
little bit deeper, changing the 'commitdiff' view to match 'commit' for
the author and committer layout.

Giuseppe Bilotta (2):
  gitweb: refactor author name insertion
  gitweb: gravatar support

 gitweb/gitweb.css  |    9 +++-
 gitweb/gitweb.perl |  123 ++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 99 insertions(+), 33 deletions(-)
