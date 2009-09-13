From: mr.gaffo@gmail.com
Subject: [PATCH JGit] Adding update-server-info functionality
Date: Sun, 13 Sep 2009 13:44:16 -0500
Message-ID: <1252867475-858-1-git-send-email-mr.gaffo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 20:44:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmu48-00034l-PW
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 20:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbZIMSok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 14:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbZIMSok
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 14:44:40 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:20766 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbZIMSoj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 14:44:39 -0400
Received: by an-out-0708.google.com with SMTP id d40so7549088and.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 11:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=IK5jIlvRGJ8av3yjMI54G+/QNhBNanXL/K53YIeUUqo=;
        b=A2Xnqu8q49ucvKqC81dOk7mNtwUHRq63V5gKLQ28TiOLCJghyaaELECfaWplpYGh6D
         79ftUH526+YbpiSlIQT57QSWKCYqYJdqLJLnlAv089Wr+sJ/GpfLJD22xEkFpB7FVrfB
         h3L8MiKJBb01pa4edz/+d2pRd7vGXrO9pExOU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=kpOvq+lJ5VBZSE1JWMBUDy+vDL7d3UvqnIANsWp3UEa0HmvXnPG2WF/Lkja+PMfpeK
         ReFec9vEsjkZ9g0Zt8eWc4sZSA0rpnfzkCL+ZRHYqBPJWCiUyyi9SGqr+gkyasw4IlrM
         RtVJJfoNKeRwE7D67DRkghKj0gGRa82U8oJZA=
Received: by 10.100.55.18 with SMTP id d18mr5535073ana.80.1252867482719;
        Sun, 13 Sep 2009 11:44:42 -0700 (PDT)
Received: from localhost.localdomain ([70.230.157.86])
        by mx.google.com with ESMTPS id 23sm1238736yxe.0.2009.09.13.11.44.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 11:44:42 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128383>

This patch series implements update-server-info functionality
in JGit and integrates it with ReceivePack so that repositories
hosted by git-http can also be hosted by JGit.
