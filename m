From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 0/3] gitweb: patch view
Date: Tue, 16 Dec 2008 11:11:27 +0100
Message-ID: <1229422290-6213-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 16 11:13:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCWv8-0001s9-Mc
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 11:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbYLPKLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 05:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbYLPKLg
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 05:11:36 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:46170 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbYLPKLf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 05:11:35 -0500
Received: by bwz14 with SMTP id 14so3470952bwz.13
        for <git@vger.kernel.org>; Tue, 16 Dec 2008 02:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=hOEvcXyO0EaXF72iiBfxKFbLmVHk1HJ7ATIpvQ8WgQw=;
        b=DQAPk+Ur/6UbsgdLE8EOUASn/LGc32hJdxoF3ZXMLAAy4iszaaGD52ueNKTiNQZRfN
         ke2X4l3WGqFcyHa9jp72DHM+vOX0Cla4J1+l7CjHRjYN0u8jCa3m7vxYRHXqNXDszvzn
         F8qqntSVBuBJ2XsU/tbmzjr1YOrPVOAkQ2ehE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=V0xa0JCPceWwBvMLtCT8bYSxUvmNtlmZysYd9PyAYPZj/5goNSDUZOfiBkVl69GW6o
         lubmix0zEoz6ImgDrNZXAli56C6I6p4kMEWjR92s7c3KlwalXPcdqrYzb68IvmIhYUYO
         ubrhZg07Xj6xhB/8GbUyDI4E8acIUOt4PSnmg=
Received: by 10.223.103.207 with SMTP id l15mr7722179fao.2.1229422293276;
        Tue, 16 Dec 2008 02:11:33 -0800 (PST)
Received: from localhost ([78.13.57.58])
        by mx.google.com with ESMTPS id g28sm211482fkg.21.2008.12.16.02.11.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Dec 2008 02:11:32 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103265>

Fifth iteration of the patch view in gitweb, that exposes the
git-format-patch output directly, allowing patchset exchange via gitweb.

No new functionality, just cleanups suggested by Jakub.

Giuseppe Bilotta (3):
  gitweb: add patch view
  gitweb: add patches view
  gitweb: link to patch(es) view in commit(diff) and (short)log view

 gitweb/gitweb.perl |  109 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 108 insertions(+), 1 deletions(-)
