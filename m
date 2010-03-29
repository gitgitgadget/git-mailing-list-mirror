From: Chris Packham <judge.packham@gmail.com>
Subject: git alternate command
Date: Mon, 29 Mar 2010 14:39:39 -0700
Message-ID: <1269898781-18564-1-git-send-email-judge.packham@gmail.com>
Cc: jrnieder@gmail.com, gitster@pobox.com, j.sixt@viscovery.net,
	bebarino@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 29 23:42:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwMj6-0006WZ-EJ
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 23:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250Ab0C2VmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 17:42:09 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49392 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab0C2VmH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 17:42:07 -0400
Received: by pwi5 with SMTP id 5so7068685pwi.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 14:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=1wOSIIAMv839AHtWIwAtIO0gDJETqVypisPWR7LuywA=;
        b=vmo/ywySIFlwNgchSs1k0QQnolpastsL4kJqTR/Uku59DpSq9i2QMnU0tgnd7yqk15
         kOmVdkWjX74KN3V14vxvF0Z4Y0+mZKxzMOTt/UKak7+rFr9Uuv/WcqWMWdOcIhmXRhVi
         GBZCbeYY5DcrZl/moBNBbPRCrJm9zozJ/5TsU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=SOPmZdJwns/2w1XFH1Hcdp9pwGohJO7EByt9jDHJY508GSNZ0QzsQNBz9jBHKvIf+S
         rBz41gJtzfz8codTWHpQDagIjKff6++yJvAfgehwjJ/9j6arUaHwtX34V9ZejXnAnGqJ
         cxZSCqVP/zf+S1KhWR1RzoJImyL2qVw0YXRHA=
Received: by 10.141.106.11 with SMTP id i11mr2907279rvm.213.1269898925476;
        Mon, 29 Mar 2010 14:42:05 -0700 (PDT)
Received: from localhost.localdomain (222-153-44-49.jetstream.xtra.co.nz [222.153.44.49])
        by mx.google.com with ESMTPS id o38sm877571rvp.15.2010.03.29.14.42.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Mar 2010 14:42:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143519>

Here is the latest version of my git alternate command. The major difference to
the last update is additional tests for deleting alternates and some updates to
the test based on Hannes' feedback.

I still am intending to add documentation and to look into Stephens suggestions
for changing the UI to use add|delete|show instead of -a|-d.

I'm also interested in any feedback regarding the actual output from the command.

Cheers,
Chris

---

 Makefile                 |    1 +
 git-alternate.sh         |  156 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t1430-alternate-cmd.sh |  154 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 311 insertions(+), 0 deletions(-)
