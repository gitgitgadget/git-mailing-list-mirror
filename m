From: Jorge Orpinel <jorge@orpinel.com>
Subject: What are git subtree push assertions?
Date: Fri, 26 Sep 2014 17:24:51 -0400
Message-ID: <CABf84+WFtO5rWHACk3cJagpKOnx2_USqWQ-vqtx+85fqEFbmzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 26 23:25:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXd0x-0007bY-Vt
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 23:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbaIZVZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 17:25:13 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:54818 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755763AbaIZVZM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2014 17:25:12 -0400
Received: by mail-qg0-f41.google.com with SMTP id i50so1519533qgf.28
        for <git@vger.kernel.org>; Fri, 26 Sep 2014 14:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=MT/RdBy6/CsFjVFJ63B25H4JCe6UfD4DobLQ7wrtJcs=;
        b=lkcwQi2PugHnIeH5niW0Tm1aUmC3DkNMfbj1JPuis/KlfW0+JE/u5o6SPUjpOB3qE2
         yZis0h35SyEFKPudI9ClvKsZVevfS+yNT42Po3LfF5wpJsPQKx7afe1xvEni1tHPcG/W
         fXiPAhE98LUKU3XDbYf/vGntm/0x0iGKbww4fj7unM6fzDn6O60iLSqFt/7CxjIylCRP
         iWfZO3JbybBqOIpwfa9NmuFYnOkPn+rXlQBV2bLm/ynJQI4yUNj1BYNW5kCoUdJ+pj5K
         Y+Z4CgH7C4YCybhm6WYmHUUNvkOgk3IDgmRH/0QaDKq9b2HDG3rKeVTXQAFhdTSccwUb
         orfA==
X-Gm-Message-State: ALoCoQk4i3Nw4RGTjMSAxxLPspzvYF0w0LFLlUPqRSnh9GDJNcM61wreGf9vKyyxt/m1I0dyiFYc
X-Received: by 10.224.120.138 with SMTP id d10mr35036427qar.8.1411766711613;
 Fri, 26 Sep 2014 14:25:11 -0700 (PDT)
Received: by 10.96.30.34 with HTTP; Fri, 26 Sep 2014 14:24:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257551>

I asked this Q on
http://stackoverflow.com/questions/26068474/what-are-git-subtree-push-assertions

but from previous experiences with git-subtree, people on
stackoverflow (general public) don't really have complete answers so I
resort to you!


* What exactly are these assertions doing, and why does it have to
start from the beginning of the assertion count every time I subtree
push?
* Is there a way to limit the number of assertions? Something like git
subtree pull --squash perhaps. I don't want to wait this much or that
it'll break at some point when there's just too many.


Please refer to link above for full question details. Thanks in
advance for any info you can give.


Jorge O.
