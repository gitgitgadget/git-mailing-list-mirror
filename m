From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Bugreport on Ubuntu LTS: not ok - 2 Objects creation does not break
 ACLs with restrictive umask
Date: Mon, 4 Jun 2012 17:40:35 +0200
Message-ID: <CALbm-Ea5ZkAGFyB2OETqe7vK7LE+yO0zSaa_+kFMXOhO-nMwMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 17:40:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbZOb-00064o-CC
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 17:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608Ab2FDPkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 11:40:37 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51834 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414Ab2FDPkg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 11:40:36 -0400
Received: by yhmm54 with SMTP id m54so3001754yhm.19
        for <git@vger.kernel.org>; Mon, 04 Jun 2012 08:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=vX0fIuHW9rYlP0+otonsemmQn5CW0k1DGaZhEOmyZNs=;
        b=lOxUq7ODrL7cPSGGimgavZOfmlxd894Qbz0S6WN0+uK2Zh/aGwV5To20dsEivxC3Bq
         ZOTbgPnpLrCulYIbtpxrPdECO27fcnp6WNgwnkCnt3E+bZBHmDZR5VO5m+PPe456LgVM
         WqhAigIPhMqke5H0ZPY6FC5LJFHOqywqL39EVkQ/Xv5XCAb0z3+zzTlZNCvgbVszamba
         3vwCZbYwYRnEuWRbzxqBm+1leyl5VM7StTEX5LJF7gcpEiGGyH19XGbtJLFoy0BHsaMy
         LcsMDLHLAatQuPRs1URyVSMmm1vdjHJ8oTKLxs42AY4EMgMHLRxqF1HIj+9eeDbncUDv
         7iNA==
Received: by 10.236.186.103 with SMTP id v67mr2521587yhm.6.1338824435632; Mon,
 04 Jun 2012 08:40:35 -0700 (PDT)
Received: by 10.236.175.226 with HTTP; Mon, 4 Jun 2012 08:40:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199143>

Hello,

so I just pulled the new git v1.7.10.4 and tried to test it with
> make test
This yields this output:
stderr http://pastebin.com/V8yuZFfi
stdout http://dl.dropbox.com/u/6520164/git/maketest.txt

In Test 1304 there is
not ok - 2 Objects creation does not break ACLs with restrictive umask

I am running Ubuntu 12.04 with Linux sb 3.2.0-25-generic #40-Ubuntu
SMP Wed May 23 20:30:51 UTC 2012 x86_64 x86_64 x86_64 GNU/Linux

Best Regards,
Stefan Beller
