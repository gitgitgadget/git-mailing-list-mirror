From: "Michael G. Schwern" <schwern@pobox.com>
Subject: Extract Git::SVN from git-svn, take 2.
Date: Thu, 26 Jul 2012 16:22:21 -0700
Message-ID: <1343344945-3717-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 27 01:22:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuXOO-00054H-St
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 01:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194Ab2GZXWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 19:22:48 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41890 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148Ab2GZXWr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 19:22:47 -0400
Received: by pbbrp8 with SMTP id rp8so3965600pbb.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 16:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=+/OFj+X5rA/6gIELtonWfgSf4Q1LLLQStZ5TDadogoo=;
        b=i4PA8vBRpdIgQssKxRV2KOi/EToMYtWlyst66VCuHn+kCmAkUzZX6ONg6dNcnR/gWe
         X+3NDZROJi1tDurGFKHxLh21dezFmgXKslkeNZZzl2dOfW7snYhIg/Jv2knqSnMsMWzy
         VAXlPyIg4CSLt+YkuR8Fh5nHqTk3URQvIR7qD53Jk6XoYCfvSR3CAtG+xUCSRYkkUFC4
         9ktpX+22IRxjkGnaowwqtGdvZCfAxTUU70TYPIoVABpLAmmplBnacSdGZTjUT9u0Y92m
         Bzo4k+rGcuyPh3+DHuMnezBIoDCkGSd8kUFlsBQrxJXNbWZ7smwFHpf4UwBMsIQxeIXT
         gKvg==
Received: by 10.68.236.102 with SMTP id ut6mr8641958pbc.113.1343344967385;
        Thu, 26 Jul 2012 16:22:47 -0700 (PDT)
Received: from localhost.localdomain (c-76-105-239-160.hsd1.or.comcast.net. [76.105.239.160])
        by mx.google.com with ESMTPS id oo6sm596728pbc.22.2012.07.26.16.22.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 16:22:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202316>

Same as before, now with tab indentation in the new Perl tests.

As before, patch #3 is 132k and will be rejected by some of the lists.
