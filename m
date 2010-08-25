From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v6 0/3] rr/fmt-merge-msg replacement
Date: Wed, 25 Aug 2010 16:18:47 +0530
Message-ID: <1282733330-32334-1-git-send-email-artagnon@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 12:51:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoDZO-0000rq-H8
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 12:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724Ab0HYKu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 06:50:58 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:43217 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab0HYKu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 06:50:56 -0400
Received: by pvg2 with SMTP id 2so152024pvg.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 03:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=cj3o70kcawEjGi1EL8ZVOvAkabI6pPszKAxMl4XZJyk=;
        b=egMUkyvMUZE4M9uCVpXp3xSgGos1Dzs+7v5XugNcMd6qjawJ+a8fv8WBxKN7uUWjqi
         C16HSvHwvaLvXPkGzngI2WIbQMzXCiUWADdMgoJHmPHAjDTQmpOGd2ttKIWJOv+M+X1V
         Rbuu9yjBThvLjs+5sAhsDcJlmpWTICvIFGFGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=IyWXo7AoYRrp9vn24a/QoM1d3KBCodu7+ld67sAfkuVgradEejMqb5n9DkiNv1lpGI
         6APju7cC/BS7mLPg3cdBDFpqv897HWoPDVcwLFMAqDCVk+hCHcX8KWLr4J0SswoPS0aa
         yxdJRITOo6VVgEYhXUb2+NpJBBi1C9vn8vm1Y=
Received: by 10.114.208.20 with SMTP id f20mr9265181wag.69.1282733455937;
        Wed, 25 Aug 2010 03:50:55 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d38sm2037882wam.20.2010.08.25.03.50.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 03:50:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154439>

Hi Junio,

This is a replacement for rr/fmt-merge-msg. It corrects the problems
pointed out by Jonathan and adds one extra patch. Additionally, I've
rebased it so there's no merge conflict when you merge it into `pu`
(see: jn/merge-renormalize). 4/5 from v5 has been dropped.

Thanks.

Ramkumar Ramachandra (3):
  fmt_merge_msg: Change fmt_merge_msg API to accept shortlog_len
  merge: Make '--log' an integer option for number of shortlog entries
  merge: Make 'merge.log' an integer or boolean option

 Documentation/git-fmt-merge-msg.txt |   10 ++++--
 Documentation/merge-config.txt      |    6 ++-
 Documentation/merge-options.txt     |    6 ++--
 builtin.h                           |    7 ++--
 builtin/fmt-merge-msg.c             |   56 +++++++++++++++++-----------------
 builtin/merge.c                     |   29 ++++++++++--------
 6 files changed, 61 insertions(+), 53 deletions(-)

-- 
1.7.2.2.409.gdbb11.dirty
