From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] transport-helper: fixes
Date: Fri, 10 May 2013 07:08:28 -0500
Message-ID: <1368187710-4434-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 10 14:10:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uam9C-0000av-Va
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 14:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957Ab3EJMJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 08:09:58 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:54890 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718Ab3EJMJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 08:09:57 -0400
Received: by mail-ob0-f172.google.com with SMTP id fb19so2906364obc.3
        for <git@vger.kernel.org>; Fri, 10 May 2013 05:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=oCZXW2NegCJeS8AatOBcmqF+RrzxAN0vE6+zOdHhItQ=;
        b=p6DVxOdZKFTiBxmya5Jy5HnkvULJm3SfY3Yy0U47tBk0I2zU2CxtX/kiJtIry18mz1
         jiYVyiiuyuZN50R6739gek3K8odkmwk3reSIM+/0OLLL3DikBVpgp7HsBNFiimRC8Cds
         cG+4Ttz5fUv4VqX2ncD4HkfQLVbMHUWZ/PzkexlcKya3VzgT8BpBKXhO8yKp1oeJOBRL
         mqMYX9pD898Rm+KNiqlSmHywVd//zwy9shfNosLTI3L3WbbE9GCDLHrK/4M1SAAkoNRA
         rfCygXPv+gUZ4Jvfizc1AvBbWPZZiV/D+5yJkhSIjlzYcRclMsF9Rw8BF5whFt7lL+LM
         tsjw==
X-Received: by 10.60.55.97 with SMTP id r1mr6662226oep.85.1368187797115;
        Fri, 10 May 2013 05:09:57 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id n5sm2424413obi.8.2013.05.10.05.09.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 May 2013 05:09:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223833>

Hi,

I found potentially serious issue with one of my patches to transport-helper.

Felipe Contreras (2):
  test: remote-helper: add missing and
  transport-helper: fix remote helper namespace regression

 git-remote-testgit.sh     |  7 ++++++-
 t/t5801-remote-helpers.sh | 15 ++++++++++++++-
 transport-helper.c        |  2 +-
 3 files changed, 21 insertions(+), 3 deletions(-)

-- 
1.8.3.rc1.579.g184e698
