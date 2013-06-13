From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/3] Fix a couple of edge cases in autostash
Date: Thu, 13 Jun 2013 21:36:10 +0530
Message-ID: <1371139573-28047-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 13 18:08:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnA4N-0005aw-GE
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 18:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613Ab3FMQIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 12:08:10 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:38804 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454Ab3FMQIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 12:08:09 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so8112879pad.23
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 09:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=9BPrHpJ5ZpDeKB4oV+ZdnASJDIR9Z/GosLqeOhm6boE=;
        b=QV6zC0fNMMZ6OZ2HTfsQunYsz3CXaZxHNQ+ILWUMmu9XXq82/HJUDg7mffCIPKMZhb
         ZLdvGkg9RizLDR3bnZiNmkjZI3Jx8kA95362ufxr9snX5esi1M1SdOnz5nq6x8EHirAs
         UgiaOBk+iYb+PuES+9H1vdKr66UutL6Kr49QH1JYwCO9ve3ESLArsRzvnn/4/6bMzg7N
         tU5YTzCXY51sPDFxFyp+16sRquUf0RzKhIJUP5Y+NcOrK3NAiGzsBX/pC7R4rVDgZ0Pd
         iRz2hBx0doQkaicpfVm34hdPUKy+ALkB7+LtvCNAPLWHxZnpbDfGNa6OY5Q4NH+poPEQ
         HW9A==
X-Received: by 10.68.191.167 with SMTP id gz7mr1625456pbc.16.1371139688960;
        Thu, 13 Jun 2013 09:08:08 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id rn7sm23911564pbc.12.2013.06.13.09.08.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 09:08:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.381.gf08dd97.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227743>

Hi,

I apologize for having missed these two trivial cases in the original
series.

Ramkumar Ramachandra (3):
  rebase: guard against missing files in read_basic_state()
  rebase: finish_rebase() in fast-forward rebase
  rebase: finish_rebase() in noop rebase

 git-rebase.sh               |  4 ++++
 t/t3420-rebase-autostash.sh | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

-- 
1.8.3.1.381.gf08dd97.dirty
