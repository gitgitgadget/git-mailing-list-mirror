From: David Barr <davidbarr@google.com>
Subject: [PATCH v2 0/6] vcs-svn: housekeeping
Date: Fri,  1 Jun 2012 00:41:24 +1000
Message-ID: <1338475290-22644-1-git-send-email-davidbarr@google.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 31 16:42:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa6Zy-0003Yf-Il
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 16:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005Ab2EaOmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 10:42:18 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40687 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581Ab2EaOmR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 10:42:17 -0400
Received: by dady13 with SMTP id y13so1378013dad.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 07:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=kgOj5gNdbh0cqle8eUOH3e0/noyzOhauxpRm3nxrPlI=;
        b=U9XbfminAtdgk97b2DFBHb0+Vp8v4QPPBb0b56gjvw2rqcj1vaT+dEP49U6vNPlrIX
         05JEMCWxvqZys6+s/4oib+PqPflf6qQoawAl4qnj19tAw18Uq8xicmEkJMkFiR0nqw27
         s0in1qb1cGYE6K8+1mGCQPPli/83gUE6apzkgof2XV9SeijXZYpippV85z1XWDAohMWF
         o8zBjfcCJwQq6nZziTspOqm52DG6ZAeIVNmZU6r9m3VywbRIs9EWPHwirxDWYb9cr05Q
         09DI1lBhn3rEDU506cWAKmPymLHN7WWYPiIZ5KmZLvnUj4OYJgmA9xkbGAJvxcxaH6ST
         td9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=kgOj5gNdbh0cqle8eUOH3e0/noyzOhauxpRm3nxrPlI=;
        b=e1MbKs/DW5tmw07m3j4hFUSBYiH0heme9owIcTs7rPiMo9alDdv8zwutwyvhNIAOdb
         sUZS1GMX0fDP4MO+iA3tIMyfzRlRHLu/fpLtKHiZkVbvtitrP1RWZFJRvzHqFlvMCn5Y
         tECPMl9tV2eapzUCNm2MHSjY4F11rmG0g8QDiB4twMQW5UnoGSCZ8tCGS7730R2qcHi9
         9ciVncZJgCyISDFZReLusybF5PRmQpVq+JQWbRx8k/1+e3LJpvm4zOV0/oXB4G4vblKV
         WNRKFBEt4m/i2w5D85SEN+ysZ9aq6DwmVnqpJ21xX0LR+zYes4E/iHhQptINk4VvOpDE
         FUxQ==
Received: by 10.68.201.136 with SMTP id ka8mr375523pbc.124.1338475337363;
        Thu, 31 May 2012 07:42:17 -0700 (PDT)
Received: by 10.68.201.136 with SMTP id ka8mr375498pbc.124.1338475337115;
        Thu, 31 May 2012 07:42:17 -0700 (PDT)
Received: from localhost.localdomain (c122-107-58-35.blktn5.nsw.optusnet.com.au. [122.107.58.35])
        by mx.google.com with ESMTPS id og6sm4376720pbb.42.2012.05.31.07.42.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 May 2012 07:42:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2
X-Gm-Message-State: ALoCoQk7ubXuOqURmTujfrS561ZD294SxpIKQTuaP8oi/2a9wgWrG34tjdx+Ucy/vV2IQCCVvnc5tMrY2P1XgfrghOnRGZIeyrWdmTP0LLwpSaaxIC3Ftaid/5YE+1IqsIF9yXgouF/RDh05/DzF+VnwbalQmh3462lNB6H1VzGCPIag1HrHffs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198909>

I've begun to upstream the changes made in the git fork
of svn-dump-fast-export in vcs-svn back to the original
project. This series contains the fixups I needed to
compile without errors or warnings and pass static
analysis.

This second attempt addresses Jonathan's comments.
I've tidied the upstream history in preparation to
merge this series back if it is accepted.

--
David Barr
