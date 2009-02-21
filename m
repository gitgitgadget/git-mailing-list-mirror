From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH A v4 0/5] git config: cleanups
Date: Sat, 21 Feb 2009 02:48:52 +0200
Message-ID: <1235177337-2532-1-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 01:57:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LagBO-0000O7-JY
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 01:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513AbZBUA4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 19:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754528AbZBUA4E
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 19:56:04 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:44761 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414AbZBUA4D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 19:56:03 -0500
Received: by bwz5 with SMTP id 5so3163722bwz.13
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 16:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=yzC/DdoYS9nepTLLrUifS0k7wV3YwnbDcx7Rpkr0Q7U=;
        b=G3RRGdyVjOCBZvPC3puhzSyf3jxXW+5HnMrK2FTlOBxw5RRiGGLUwOEe6uRdpOnPms
         T3ik5OLjywwJjwEfVjAocnEB2myGVnPhY9CmnIOEyfHFQP9mXHImHxq9Ulka4wbVsAFN
         Jt/37zCVtvTsSwGYMbAgpMgJmkNUR6Fidqo0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=iu3s4yqyLCA3o8rcnbrDGnSzgmdHp8mgxVMT9wTbCk1dyxmrguZ9/uajDEpGObzS/T
         4GKuxF3qxXTsP9l9dQXPcJqomKNQUE3u0QMBnk+qISCoO4AS+hKoChpJrw9QvluhMGQZ
         PBCT0j72hhA1ggO/1xUT0/h0S9F/bbXe48bh0=
Received: by 10.181.154.16 with SMTP id g16mr470538bko.179.1235177340545;
        Fri, 20 Feb 2009 16:49:00 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id e17sm5768714fke.28.2009.02.20.16.48.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Feb 2009 16:49:00 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110919>

This patch series is the first of a two parts reorganization for more
maintainability and user friendliness. Nonetheless stands on its own can be
applied without the second part.

There are essentially no functional changes.

Felipe Contreras (4):
  git config: codestyle cleanups
  git_config(): not having a per-repo config file is not an error
  git config: trivial rename in preparation for parseopt
  git config: reorganize get_color*

Johannes Schindelin (1):
  git config: trivial cleanup for editor action

 builtin-config.c |  108 ++++++++++++++++++++---------------------------------
 config.c         |   17 ++++++--
 2 files changed, 54 insertions(+), 71 deletions(-)
