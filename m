From: Antonin Hildebrand <antonin@hildebrand.cz>
Subject: contrib/workdir/git-new-workdir broken in 1.7.10 after introducing gitfiles
Date: Fri, 20 Apr 2012 13:16:31 -0700
Message-ID: <CAHsq6J6JOTYfEtK0Z=_qfMFf9N1DWQ4zx46YhBbNu-1gEMyfog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 20 22:16:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLKFx-0004De-Bp
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 22:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645Ab2DTUQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 16:16:33 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:39082 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab2DTUQc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 16:16:32 -0400
Received: by obbta14 with SMTP id ta14so9989892obb.19
        for <git@vger.kernel.org>; Fri, 20 Apr 2012 13:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=qK98OETXc4FNOwhVljWgK6rK9fh+WJ+lxJ3x3mP3o1w=;
        b=RFcB8PGwZg4fFj+el9Quo59NK9tjv4NiBJpKgveyN1u5oM30PKtdb5e+7hsmSdJvqf
         ygGMmI/6m673cZevo3wsULWg+IuTv2/a9FEceQaXGD8Il73b/WMx0ZvCwJd7jnoE3guE
         EOpt+qvXu6G1xrfevoBzP3nRE4ear9GW2eBQK8T2M7WpQre7IBJTbFE9wTfOinvnNlPY
         bw1c4L+Uoa3zF3t2DfUSES7on2CSqD58mCwoLBhF5aQxnRDnPWXEOV6bCtcKtrf0sfhy
         FINfjIodEhYPL9UdAKmHCJ4v6MAMzSt2LDR78MjY6b9zvcjIMUbakaroreiFWY/03tlh
         DWWg==
Received: by 10.182.202.104 with SMTP id kh8mr11018990obc.1.1334952991750;
 Fri, 20 Apr 2012 13:16:31 -0700 (PDT)
Received: by 10.182.48.98 with HTTP; Fri, 20 Apr 2012 13:16:31 -0700 (PDT)
X-Google-Sender-Auth: RMxK8TSM58PHFiXJFi7B5sKxI9c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196019>

Hi there,

I'm just solving same problem as described here in the question:
http://stackoverflow.com/questions/4115817/duplicate-submodules-with-git

I wanted to try proposed solution, but git-new-workdir does not work
in latest release 1.7.10.

The problem are plaintext .git files pointing to the root
"superproject" .git directory. The script has not been updated to deal
with this new situation.

thanks,
Antonin
