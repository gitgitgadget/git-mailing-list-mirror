From: Remi Rampin <remirampin@gmail.com>
Subject: [PATCH 0/2] gitfile support git git-gui
Date: Thu,  5 Feb 2015 11:20:13 -0500
Message-ID: <1423153215-9706-1-git-send-email-remirampin@gmail.com>
References: <CAMto89CHf4OT_S05SaRrVRZvF-PH2_6DrcEpdGiUfaRGutJQHw@mail.gmail.com>
Cc: patthoyts@users.sourceforge.net, Remi Rampin <remirampin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 17:20:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJPAM-0006nu-1i
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 17:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934AbbBEQUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 11:20:25 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:50497 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbbBEQUY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 11:20:24 -0500
Received: by mail-qg0-f43.google.com with SMTP id e89so6871837qgf.2
        for <git@vger.kernel.org>; Thu, 05 Feb 2015 08:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oiX5FT+XDP+OlRSkab6am8iS1QOxucxLQTBqvJLoD0c=;
        b=Zx/JXbDcmDgToRQAxrao6N2K3fdNlBo4TsjgM/SbMO8MioSbIMh8rtxMzdSK0L9MaD
         7U9M3/oWFwWaKsL85YZvDKxWU7t4To6HxgzaBYjoENEI5TTGnw2Jy1Lrm315Qg9Z11Iq
         nmnsqK46v9ZZjwyR+JMUCGaymiS2YInN1Q7SC/WaLCytyAAjWHrcBqWryjQfF8yCGJbR
         dp0jedtmq12d+juntPgt2JH2TZ49LM8/BIa6/0MBUL6cTLnus5MwcxeLMwD02w4LmrtP
         UFs3S8tEPNtaJ0UnjuF8Ej/vRhJYjgJLH7XLemDqEKfF36Kcld6RGGiaXw8BGEmjXSmV
         9bHw==
X-Received: by 10.224.120.10 with SMTP id b10mr9852065qar.19.1423153223939;
        Thu, 05 Feb 2015 08:20:23 -0800 (PST)
Received: from debian-78-amd64.poly.edu ([128.238.102.81])
        by mx.google.com with ESMTPSA id c16sm5333798qge.24.2015.02.05.08.20.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Feb 2015 08:20:23 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <CAMto89CHf4OT_S05SaRrVRZvF-PH2_6DrcEpdGiUfaRGutJQHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263376>

New patch series. I hadn't realized Git doesn't recurse on "gitdir: ..."
links itself, it only follows one.

Also normalizes the path to the Git repository as requested.

Remi Rampin (2):
  Fixes chooser not accepting gitfiles
  Makes chooser set 'gitdir' to the resolved path

 lib/choose_repository.tcl | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

-- 
1.9.5.msysgit.0
