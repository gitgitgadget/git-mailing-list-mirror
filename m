From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/8] remote-bzr: patches for next
Date: Fri, 24 May 2013 21:24:18 -0500
Message-ID: <1369448666-17515-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:26:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4BQ-0006M3-Vz
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518Ab3EYC0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:26:06 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:39826 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab3EYC0F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:26:05 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so6287065obc.12
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=dGqOCaMQfCQqzUxurt8ZK8Z55zvwZJbihAmkVa5Rrt4=;
        b=hhMQmGXYB61t1xmrrw98OwInQb+nnSAXS8sPigLre/scN5iV/EZ3C6V/0XwqzuqhHZ
         jrvPEMyeK+QZgX0qC2Cm9IycUZXD9ihLLx/IoTfXP/b3oTib61q8NLfYlg2aBc8bpkzU
         qtyw7duCbK67IXsV/C/eobY2+eTwiGDAFHNuMfrPcEZNClaYFrZbh86PPTdrPyzvprHO
         DzLlsciRZdUPY5lbLr0WsZQ7yNHWtgT7s+IyzqYuqklpWtsUzmRLuH4PB3Yzf/SNnsvT
         ad7NDc2k2UOZqu+8zoAYKliwRTVGg+wnibt06yrmXnoEpnxpyTYgrpO2AWxw3tURV1L9
         IL/A==
X-Received: by 10.182.225.199 with SMTP id rm7mr13713347obc.20.1369448763958;
        Fri, 24 May 2013 19:26:03 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id pm16sm20553344oeb.3.2013.05.24.19.26.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:26:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225405>

Hi,

Minor fixes since last time.

These patches have been cooking in my github repository, and improve the
situation when bzr servers don't support repositories properly.

Felipe Contreras (8):
  remote-bzr: recover from failed clones
  remote-bzr: fix for files with spaces
  remote-bzr: simplify get_remote_branch()
  remote-bzr: delay cloning/pulling
  remote-bzr: change global repo
  remote-bzr: trivial cleanups
  remote-bzr: reorganize the way 'wanted' works
  remote-bzr: add fallback check for a partial clone

 contrib/remote-helpers/git-remote-bzr | 112 +++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 57 deletions(-)

-- 
1.8.3.rc3.312.g47657de
