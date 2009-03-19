From: skillzero@gmail.com
Subject: Push tag from shallow clone?
Date: Thu, 19 Mar 2009 10:56:51 -0700
Message-ID: <2729632a0903191056w4efdbec6hd1656d7b47d0d8a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 18:58:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkMVY-0000RO-U3
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 18:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757467AbZCSR4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 13:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753523AbZCSR4y
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 13:56:54 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:49153 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbZCSR4y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 13:56:54 -0400
Received: by yw-out-2324.google.com with SMTP id 5so623023ywb.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 10:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=zxEgjXCbsDTmuE1DdH25cs2B6/fo6SJ0p6eHvrsejxw=;
        b=D1aAJW3WDa+9dFOI7nJXGQafHJsAEvXSSYh0Uh2ogde3SoJ8t0KYOZ3GQxzuC5/OjI
         KEyqdn0kmrNzlPWBz6ZJnYUIRxDa2MU7BSJK1CK3kKl27qSn8zvJnMlvvWW68qnaMtLt
         P62BxvqeOx+fFZtBHIqaBprajWbntrlf6tHVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=uoRd11M9VvaVYnKUFPxXWuASZpRbYm9rF8RiDMv+ZwIcuVfIR80qT8nG5rET3AHNJC
         /ZFvHKr8Q35KhJema8KSswDHppJQixzaHvBq9gRfoM2uLuzr30aqKt3eMEetSJk/9rhu
         tQs1ew/q2OFK8ZrvnVk/11ejZGJMek5vpkSBA=
Received: by 10.100.11.3 with SMTP id 3mr3109971ank.7.1237485411979; Thu, 19 
	Mar 2009 10:56:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113803>

The documentation for git clone says that if you use --depth=1 to make
a shallow clone that you can't push it. But I made a shallow clone,
created a tag, then tried to push that tag and it worked. Am I just
getting lucky or is it safe to push a tag with a shallow clone?

The reason I ask is that we have an automatic builder/tester/archiver
where I'd like to make a shallow clone (to save space since it only
needs the tip of the branch to do the build), do the normal build and
test and if it all passes, tag it, and push the tag so people can pull
tags that have been verified by the automated builder.
