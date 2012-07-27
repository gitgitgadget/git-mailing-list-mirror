From: "Michael G. Schwern" <schwern@pobox.com>
Subject: Extract remaining classes from git-svn
Date: Thu, 26 Jul 2012 17:25:59 -0700
Message-ID: <1343348767-86446-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 27 02:26:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuYO6-0004B2-FY
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 02:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699Ab2G0A0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 20:26:33 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41590 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390Ab2G0A0c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 20:26:32 -0400
Received: by pbbrp8 with SMTP id rp8so4044857pbb.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 17:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=q8jQx/XTUqg93wCLce7Nun9wGvwVIw8JLxhTwj88EvM=;
        b=MQK3xmJCFB4nIhnJq4JKETqGAfj4YuCyt2qS36Gtj6Z4moLCX8FdfvWqGrodOn50BY
         ETVPnqCNsWKtSTh9b3x+Qd7+fYFBurSYQvVRQiAyGwKY2ppO87/DOTO8SBwX7XmS8tRi
         lvA9vUe3c58eV/OwS4Hj0FR9mZm+UQWzT0UoTsiJDfwyk6HwwytSoVTUTMIPVPrtYVXn
         IVkAkIdPQLtbTA4Se0IkKpQrLuF1ThwjvjfRWLoaMFMqzWZsE2RRdBj9Okq6JHNStPW7
         G7gVQoN2+97rC7wfAqVSt91f3aA+ykG/wtoCYFppejdK37051KEN4wvZjPT9yzqTKmSA
         4ZPg==
Received: by 10.68.228.2 with SMTP id se2mr9017166pbc.109.1343348792063;
        Thu, 26 Jul 2012 17:26:32 -0700 (PDT)
Received: from localhost.localdomain (c-76-105-239-160.hsd1.or.comcast.net. [76.105.239.160])
        by mx.google.com with ESMTPS id jz4sm692556pbc.17.2012.07.26.17.26.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 17:26:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202321>

This series of patches extracts the remaining classes from git-svn.  They're
all simple extractions and functionally have no change.
