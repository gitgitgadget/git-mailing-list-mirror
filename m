From: Doug Bell <madcityzen@gmail.com>
Subject: [PATCH v2] show-ref: make --head always show the HEAD ref
Date: Fri, 12 Jul 2013 21:03:07 -0500
Message-ID: <1373680988-72804-1-git-send-email-madcityzen@gmail.com>
References: <7v38rlt88j.fsf@alter.siamese.dyndns.org>
Cc: Doug Bell <madcityzen@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 13 04:03:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxpBO-0005aM-F6
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 04:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758030Ab3GMCDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 22:03:30 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:48791 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757946Ab3GMCD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 22:03:29 -0400
Received: by mail-ie0-f170.google.com with SMTP id e11so22286112iej.1
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 19:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ePDGZOYR+QaKLfids7Qgi5AWG0d9Ote1Swwpy+3tuaM=;
        b=qR5RfBa2W9AWycCQe34J0Hn0JhHoc6vsTYIBMb2WlrJiPEE7cVqJ8isjkYgArTnvhu
         5+iaLp3Pz4jEcQGuIXp100d0XwgwPLNrZ50vHOKIeVYFZJMr1Tc7l8sZE8keMknnMGQf
         am2fP+aOq6NmG4pwDF3mY7GWyffL/z69W2zL3ou51G3Cry+gea+kA95rbIZBzIGU2s8N
         1BqGP6RuBgsjDh0+LEPT4pS+yVPAAv7JlZV9O6lGbFleByNIziwNkQ+pItEKE/DaDDUM
         p9aPFoxhAnGunXNa5XxNXorZlqEy/tqT6pi9qJDOPoo87+v0+HczKgLlDdV9lZT0e/+s
         qSBA==
X-Received: by 10.50.112.105 with SMTP id ip9mr1767295igb.59.1373681009385;
        Fri, 12 Jul 2013 19:03:29 -0700 (PDT)
Received: from localhost.localdomain (c-67-162-112-255.hsd1.il.comcast.net. [67.162.112.255])
        by mx.google.com with ESMTPSA id y9sm2925504iga.9.2013.07.12.19.03.27
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 19:03:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <7v38rlt88j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230273>

Updated the documentation to describe the new behavior.

Doug Bell (1):
  show-ref: make --head always show the HEAD ref

 Documentation/git-show-ref.txt | 10 ++++++----
 builtin/show-ref.c             |  8 ++++++--
 2 files changed, 12 insertions(+), 6 deletions(-)

-- 
1.7.12.4
