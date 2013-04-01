From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/3] remote-helpers: trivial test fixes
Date: Mon,  1 Apr 2013 15:14:29 -0600
Message-ID: <1364850872-21135-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 01 23:23:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMmCb-0008F6-F2
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 23:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758704Ab3DAVXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 17:23:10 -0400
Received: from mail-ye0-f170.google.com ([209.85.213.170]:56409 "EHLO
	mail-ye0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755972Ab3DAVXH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 17:23:07 -0400
Received: by mail-ye0-f170.google.com with SMTP id q9so463650yen.1
        for <git@vger.kernel.org>; Mon, 01 Apr 2013 14:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=ovza9kYQrgCFX5DzaIm8nFPEl8HUTol+jrjvlByTKiI=;
        b=Xpe8KqQok8GN2RJCp8oZMBJgOAIUne1WlLavM2ejN3RcIjOinQvgFuBn904O55nfqV
         GI/dIP2b0T0+y8sYzrVdwsMmzm87540xVjju04ZOg0vde7CcZvQhRj5uL3VdCrDqrmxl
         g8D1ze31spS8Lh8NJ6v88gIVPWpXhHekZEsRvpRoEhzruQ4E0Li/0tiH0ohOyZZka1q4
         y+o/GVcLxXv2g9wEyCRfw7LFKeOofuDCEIc1IT50VcIr3IBU6VcoKYbDAgRALGSfFzRF
         CD2b3Hj0Rt2b6VVzdlw58hoj83l0ofrciKL3yjN5UrkXmfRqepnVnLsF1TN5tbvs2tTc
         dF7w==
X-Received: by 10.236.18.229 with SMTP id l65mr11944245yhl.47.1364850924820;
        Mon, 01 Apr 2013 14:15:24 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id s16sm29865788yhj.13.2013.04.01.14.15.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Apr 2013 14:15:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219710>

Hi,

Here are a few fixes for the test framework on the remote-helpers.

Felipe Contreras (3):
  remote-helpers: fix the run of all tests
  remote-bzr: remove stale check code for tests
  remote-hg: fix hg-git test-case

 contrib/remote-helpers/Makefile          |  1 +
 contrib/remote-helpers/test-bzr.sh       | 14 --------------
 contrib/remote-helpers/test-hg-hg-git.sh |  1 -
 3 files changed, 1 insertion(+), 15 deletions(-)

-- 
1.8.2
