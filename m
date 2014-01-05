From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 0/4] Re-spin rr/completion-branch-config
Date: Sun,  5 Jan 2014 15:48:01 +0530
Message-ID: <1388917085-18701-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 05 11:18:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzkmX-0002VE-DP
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jan 2014 11:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbaAEKSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 05:18:05 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:48634 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbaAEKSE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jan 2014 05:18:04 -0500
Received: by mail-pb0-f52.google.com with SMTP id uo5so17429205pbc.11
        for <git@vger.kernel.org>; Sun, 05 Jan 2014 02:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=44IQy/MzraggRpHhqXIOxZYJijiy18BZc6hIe6OSv8w=;
        b=UaxvvzeucG5Kpy6Du0vzrN/VdGgJ2plrgDOIbGZDarZL98LSRhQqutCNnZwqaQvpSK
         ZgnrqfU3bEPVUdran0ezBpRFVYDrqu18Jx1CHdmNdA/8FhLIdaeb9/36JHoJxamLbHxZ
         vggzRImhTvnkN/GYVMVckKkDMxQZy6ZyLtZpTOOxjVRt3Xs4yAFBSAeFth+tTU/iHKFX
         cz0XFT7msBUG1jzwlxt09MOVDQJJFmMm0G+Q6sktmV6m1Q0GmAh1Tm7GmLE5aFQrZKaT
         HebZAypN/jltDlo3VfqiUQozntBETtRr/2PzoxUa+fEuohohp2Cev8P8hXN6tGdx8RJZ
         4CTA==
X-Received: by 10.69.31.139 with SMTP id km11mr3273099pbd.163.1388917084010;
        Sun, 05 Jan 2014 02:18:04 -0800 (PST)
Received: from localhost.localdomain ([122.164.141.93])
        by mx.google.com with ESMTPSA id fk4sm25113615pab.23.2014.01.05.02.18.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Jan 2014 02:18:03 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.227.g53f3478
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239961>

Hi Junio et al,

Most significantly, [2/4] no longer duplicates __gitcompadd () in
__gitcomp_nl_append (). Other than that, the commit messages for the
other patches are improved.

Thanks.

Ramkumar Ramachandra (4):
  zsh completion: find matching custom bash completion
  completion: introduce __gitcomp_nl_append ()
  completion: fix branch.autosetup(merge|rebase)
  completion: fix remote.pushdefault

 contrib/completion/git-completion.bash | 24 ++++++++++++++++++++----
 contrib/completion/git-completion.zsh  | 10 +++++++++-
 2 files changed, 29 insertions(+), 5 deletions(-)

-- 
1.8.5.2.227.g53f3478
