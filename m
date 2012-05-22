From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] completion: split into git-prompt.sh
Date: Tue, 22 May 2012 22:46:38 +0200
Message-ID: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Ted Pavlic <ted@tedpavlic.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 22 22:46:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWvyk-000811-FC
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 22:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760251Ab2EVUqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 16:46:45 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:40690 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534Ab2EVUqp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 16:46:45 -0400
Received: by eeit10 with SMTP id t10so1847774eei.19
        for <git@vger.kernel.org>; Tue, 22 May 2012 13:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=sBYkssQLoCueh5SddjOSNgXRYXi3sL8SJ3dRqm6a4Vw=;
        b=A3t8/fPXPI0neYdTcSZpomXEv1V6SbdVuEacBk4NNU1hf01mhYfHTndxIrLWy9PQvx
         YKI/2artMwfHcY1ZVwOdpWlvqWDwoeVUobTGePCh3jzyUKalh3WncUjOACA29fdb2slS
         0d2wkv3sx6yIJvbHnZKbeunO9qyj906jIqE5GesKwqXGbwBGEtgj9ZgtvaR0LzpMjsqK
         i0h+C25fR39lrEpyKTLDtIatInu1SkFdn74VuQRLl3zkscf3sSlTviDh4OwJgXzVk/Yg
         9nzBULBUQUcbGiYbA0ZaqRAdeuoTZRofAz4vxagiHcR1z8Q2nWn/n4LV5Y/Gynzc1zSb
         6t4A==
Received: by 10.14.119.193 with SMTP id n41mr4613341eeh.96.1337719603619;
        Tue, 22 May 2012 13:46:43 -0700 (PDT)
Received: from localhost ([46.115.34.169])
        by mx.google.com with ESMTPS id v46sm112236108eef.11.2012.05.22.13.46.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 May 2012 13:46:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198249>

Hi,

This has been discussed before, but nobody has actually done it. Details in the
relevant patch.

Felipe Contreras (2):
  completion: remove executable mode
  completion: split __git_ps1 into a separate script

 contrib/completion/git-completion.bash |  257 +---------------------------
 contrib/completion/git-prompt.sh       |  287 ++++++++++++++++++++++++++++++++
 t/t9903-bash-prompt.sh                 |    2 +-
 3 files changed, 290 insertions(+), 256 deletions(-)
 mode change 100755 => 100644 contrib/completion/git-completion.bash
 create mode 100644 contrib/completion/git-prompt.sh

-- 
1.7.10.2
