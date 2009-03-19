From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 0/2] gitk window icons
Date: Thu, 19 Mar 2009 01:54:16 -0700
Message-ID: <cover.1237451887.git.bebarino@gmail.com>
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 09:55:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkE2c-0003sJ-UX
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 09:55:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246AbZCSIyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 04:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753854AbZCSIyY
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 04:54:24 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:1391 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbZCSIyX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 04:54:23 -0400
Received: by rv-out-0506.google.com with SMTP id f9so465786rvb.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 01:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=fQ2kACfgNuELxCkU/mWY46/8MOY3f3Qp6/Ek50UtKIY=;
        b=e2u/V3T28ldvrUuxg6vdKqT2rSg7a7Z7wouEWBXMTKWvtwfAabGAL4tvcQhlmSsfwJ
         ax2X8uNRmjahv3WDBiIXAXEC5Rm/k67JcvO/+UdhGMO0ksNVtmoOni4Y2z7vCXa9Gn0I
         Xzrp8SOORn07OjcztGQ4r8PoRML2uUIkyJ7/M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=pa16EWQgT810QHLyQQ/6g0xRu+x0tnK+P2ioVt6h0JjDJhE5aqOwjbATTY+6H+nMkf
         DMlF7hCjcdk+pbUDO3kTKaXepuIWla0im+JmxTGCpGrrkMu3ejbei4CbnzDCAZ1cCMar
         7sb4M76LqKNyb+FKqHRY5i/TLE2BNl/Zd8dNI=
Received: by 10.115.23.19 with SMTP id a19mr1487728waj.63.1237452861364;
        Thu, 19 Mar 2009 01:54:21 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id k21sm941371waf.22.2009.03.19.01.54.19
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Mar 2009 01:54:20 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 19 Mar 2009 01:54:18 -0700
X-Mailer: git-send-email 1.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113735>

These two patches set the git logo, three red minus signs and three green plus
signs below on a white background, as the window icon for gitk.

I found this first patch by Giuseppe posted to the mailing list a couple months
ago. I've simply added a 32x32 icon in the second patch so that window managers
can provide a slightly better looking icon when they need a bigger icon
(ALT-TAB for example).

This logo is different than the logo used by git-gui. Do we want to use that
logo instead?

Giuseppe Bilotta (1):
  gitk: try to provide a window icon

Stephen Boyd (1):
  gitk: provide a 32x32 window icon based on the git logo

 gitk |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)
