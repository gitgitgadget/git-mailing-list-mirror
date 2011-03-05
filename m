From: Adam Monsen <haircut@gmail.com>
Subject: [PATCH 0/2] improve combined diff documentation
Date: Sat,  5 Mar 2011 11:56:42 -0800
Message-ID: <1299355004-3532-1-git-send-email-haircut@gmail.com>
References: <4D724A0F.7050904@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio Hamano <gitster@pobox.com>,
	Adam Monsen <haircut@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 05 20:57:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pvxbq-0007ar-SZ
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 20:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343Ab1CET5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2011 14:57:37 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33008 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616Ab1CET5h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2011 14:57:37 -0500
Received: by pwi15 with SMTP id 15so547608pwi.19
        for <git@vger.kernel.org>; Sat, 05 Mar 2011 11:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=E1KwmjxYU+jKHJujJLrpCRPpKncBgNNEjl+MXqjsAjQ=;
        b=p+bMlMsCoL19EKD3gZqZ+0jmyp7SyJ+uyHlJNZBMGr81rsiDhd6bi1oNZ/Ee+Xiz89
         0d9bpFI8EQbVdH53hxSAxlDeK/nW9HfFlgS/zUYn5i8x327NL/RHjevO1e5aifYaCClx
         ZN3Mv99ZntckVDe+PnpZ0LKl6yJjqQmOz/zh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=enbI0Am6uF8CsttChq8cbRUTOnaABYKC3uVPtZ2s+gColZ1egzOg9QGR9k5LBoQWF1
         yTcT7PoXjYuRm9z+rYMiCRKcYNzuFMS10Di/jSNk36HiKV9DkUZEYO+jJLZ7Txl+0xvY
         GmX/l50qINrEc9hJI4Tns3jiXOh1B3PPwy/+U=
Received: by 10.142.199.2 with SMTP id w2mr1667629wff.293.1299355054976;
        Sat, 05 Mar 2011 11:57:34 -0800 (PST)
Received: from localhost.localdomain (c-67-183-136-182.hsd1.wa.comcast.net [67.183.136.182])
        by mx.google.com with ESMTPS id w19sm1339031wfd.8.2011.03.05.11.57.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Mar 2011 11:57:34 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <4D724A0F.7050904@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168509>

The "combined diff format" documentation in diff-generate-patch.txt
incorrectly implied that "log -p" shows conflict resolutions as
combined diffs.

With these small documentation fixes I'm hoping to save someone the
time it took me to figure out how a merge conflict was resolved.

Related thread:

http://thread.gmane.org/gmane.comp.version-control.git/168481

The patches apply cleanly to maint.

Hope this helps,
-Adam ("meonkeys" on IRC)

Adam Monsen (2):
  documentation fix: git log -p does not imply -c.
  English grammar fixes for combined diff doc.

 Documentation/diff-generate-patch.txt |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

-- 
1.7.2.3
