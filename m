From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 0/2] gitk spacing/sizing tuning for HiDPI
Date: Sun,  6 Dec 2015 13:25:21 +0100
Message-ID: <1449404723-27177-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 06 13:26:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5YOK-0007Cl-NF
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 13:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbbLFMZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 07:25:32 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35630 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbbLFMZb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2015 07:25:31 -0500
Received: by wmuu63 with SMTP id u63so110411934wmu.0
        for <git@vger.kernel.org>; Sun, 06 Dec 2015 04:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=9vqDAm59/G0jVqNA8D57BdnVOSciNadMqv5r8C1vEBU=;
        b=TUYE04QAR5/+iYFBovO3KO6DAPGfE3Oq0BtzOlBlyK1RSfV08WyCwCUj7pSg9hK9rU
         Q7aH2dCaKTG1yaf5tfr3icVeC1nsA3xjh9zD1HeOOK1bdqEy2/mf2ISojSn7NqKudYkT
         QtXQGdwGFH3kMLj9RXR9ayFpeQK9l/8ObK8gKVuCe+tBpNMBzjizdWbuCBhyqjQoTbca
         GM1a06YZ+5ZemxidX6p9aOf5PHuPtso7mzTE9jq1r8WQeXGadt6BL5Fsjiva+fOA3YCM
         xCpJwU37LKQ3zBra7RdX9RJgrvOC0nQ3mh1R2iHPG1ahIXndQSymvCRM0ZFUbzFuPd5Q
         JwQQ==
X-Received: by 10.194.75.202 with SMTP id e10mr31144569wjw.160.1449404730311;
        Sun, 06 Dec 2015 04:25:30 -0800 (PST)
Received: from localhost ([151.54.54.213])
        by smtp.gmail.com with ESMTPSA id t194sm11707256wmt.11.2015.12.06.04.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2015 04:25:29 -0800 (PST)
X-Mailer: git-send-email 2.6.3.659.gfdd8f28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282050>

On my HiDPI monitor, most elements in gitk are correctly rendered, with two
exceptions:

* when using ttk, some elements do not use the same fonts as gitk would use
  without, and since ttk picks _unscaled_ sizes this is very noticeable (and
borderline illegible); the first patch fixes this;
* the spacing between the checkboxes on top of the diff window are a little too
  tightly-spaced; the second patch adds a little bit of breathing space.

Giuseppe Bilotta (2):
  gitk: match ttk fonts to gitk fonts
  gitk: let .bleft.mid widgets 'breathe'

 gitk | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

-- 
2.6.3.659.gfdd8f28
