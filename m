From: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
Subject: [PATCH 0/4] clean-up store_updated_refs
Date: Sun, 13 Feb 2011 00:38:27 +0200
Message-ID: <1297550311-17723-1-git-send-email-vvavrychuk@gmail.com>
Cc: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 12 23:39:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoO7J-00033k-7y
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 23:39:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514Ab1BLWin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 17:38:43 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34759 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab1BLWim (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 17:38:42 -0500
Received: by fxm20 with SMTP id 20so3929984fxm.19
        for <git@vger.kernel.org>; Sat, 12 Feb 2011 14:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=Kfp13RHNt+U5YNL5bPwZvKinCQy9ojbND4Lvz1GuefA=;
        b=VcBRzKNtSzoeo9J+b4mhWlknvfv3gW4PCtGWyajt43vY4/TufwT0d3UwTzCV/byY76
         C0rvAJ8D8K+x8RGQSMvfQ9Y2YTeCE9u9bmy9Rtu7n+VeLbDV+cYfbrQ500KLqBd5mrOD
         kcInDd0nhzGfiS7GAeMu04tcqdgvTPmcp6PyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ukZrJElXnGFS3MEnEI/F3rZ/Ifh4De5sjvst4/wiz9NhPdHuCmWBieOCMRhXStCgRn
         TMD1hfl5deNbhOo4SyQFEC3VjOcEG9hu04Y+My6vjf3ggCHSg1tJLgGwWL6clUtVAvZK
         y3zqKQcm7koozEbGUoavGmL8Dr0VBVQ/WpKSM=
Received: by 10.223.97.8 with SMTP id j8mr1360374fan.141.1297550320578;
        Sat, 12 Feb 2011 14:38:40 -0800 (PST)
Received: from localhost.localdomain ([91.200.115.239])
        by mx.google.com with ESMTPS id n7sm369494fam.35.2011.02.12.14.38.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 12 Feb 2011 14:38:40 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1.30.ga83dc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166628>

Vasyl' Vavrychuk (4):
  Reduce url_len variable scope
  Extract function trim_url and optimize calls of it.
  Dont use the same variable for different things
  Replace pointer arithmetic with strbuf

 builtin/fetch.c |   63 ++++++++++++++++++++++++++++++++----------------------
 1 files changed, 37 insertions(+), 26 deletions(-)
