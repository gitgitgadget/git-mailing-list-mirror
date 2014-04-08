From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: git log for only certain branches
Date: Tue, 8 Apr 2014 08:43:45 -0500
Message-ID: <CAHd499BSgxZ8EC1qKYRsF0hac6rQAegw9qTOoDjaiuh_UUVEng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 08 15:43:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXWJb-0007mN-FU
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 15:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756890AbaDHNnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 09:43:47 -0400
Received: from mail-vc0-f169.google.com ([209.85.220.169]:33972 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756683AbaDHNnq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 09:43:46 -0400
Received: by mail-vc0-f169.google.com with SMTP id ik5so794203vcb.0
        for <git@vger.kernel.org>; Tue, 08 Apr 2014 06:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=V8pOT4qq1evFKImMYBcn5oqQ66ERm5qj976Vi7fkCo4=;
        b=zr4xCYCo4wkZXLrd7d1igYAYnEPF2pHPUPmrQBciHnH2DBk7FVBdZTsuotmQZ75SG0
         YQk2YZTtMI1eisBbahYcCxBRkAphGmqhhHgps/Xk1oL1KeOS6VqHuyg/da2u1rXBLmUy
         wrTnJIQXqoEfua2egkPihb3X1ygCwI5x+/kyRprJTzSO+tYrfS8kktHjKt84vJElJ+5i
         z94dwWCyRe6DUEyKDrG/2h3HuXWNVsWl++7xWgT8zwxiWY50caNL3lTDrmTQatvVYo5u
         fiBqdlPchtTXde+JqpDYqr3P2bqlYZzc5xbHMbsueclN4sMA+ZIKwuNSL595X4MVM5vG
         sknw==
X-Received: by 10.221.63.1 with SMTP id xc1mr150955vcb.35.1396964625074; Tue,
 08 Apr 2014 06:43:45 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.2.79 with HTTP; Tue, 8 Apr 2014 06:43:45 -0700 (PDT)
X-Google-Sender-Auth: KGwU4iYJt-r0K2VELvmSpAXiXSY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245925>

I have more details about my inquiry on StackOverflow:
http://stackoverflow.com/questions/22823768/view-git-log-with-merges-for-only-certain-branches

Basically I'd like to know if it is possible to show the graph for
ONLY branches that I list. The key here is that the graph should also
show relationships between only those branches that I list. In other
words, any ancestors that I do not explicitly specify should not be
rendered in the graph.

I have an insanely huge number of branches in my git repo (we
transitioned from SVN so we haven't had a chance to clean them up
yet). As a result, the git log graph I see has literally 10-20
vertical lines and I have to scroll 20+ pages to follow a line to a
particular parent branch.
