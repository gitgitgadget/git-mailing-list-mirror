From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Switching heads and head vs branch after CVS import
Date: Mon, 15 Aug 2005 12:24:30 +1200
Message-ID: <46a038f905081417241f9598cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Aug 15 02:24:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4SmK-0003Df-6z
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 02:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbVHOAYd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Aug 2005 20:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbVHOAYd
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Aug 2005 20:24:33 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:43371 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932594AbVHOAYd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2005 20:24:33 -0400
Received: by rproxy.gmail.com with SMTP id i8so706276rne
        for <git@vger.kernel.org>; Sun, 14 Aug 2005 17:24:30 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fTgs3tQlEcnazjjjNdSemLslSZJvflAuUT6PuIRIVvMPpzFo0IgFeuDtFTF7TYxUP6ClVtHvsdRDFe9vsxBqyvNnXrhCgDnBsPKSwFr5GyPHXhFIqQYlMDdTB0dzTnLiszSSpQlhXyEYtM0jpVjrFzDrQw1nfSx24EGnRcXAQn8=
Received: by 10.38.101.2 with SMTP id y2mr1776669rnb;
        Sun, 14 Aug 2005 17:24:30 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Sun, 14 Aug 2005 17:24:30 -0700 (PDT)
To: GIT <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

After having done a cvs import of Moodle using git-cvsimport-script
all the cvs branches show up as heads. How do I switch heads within a
checkout? cogito doesn't seem to be able to, and I'm unsure on how to
do it with git.

And I am confused about the difference between heads and branches. Git
and cogito seem  prepared to merge across the heads (using cg-update
for instance, when pointed to a different head merged it in, rather
than switched to it), that would match a workflow where a group of
people maintain very closely related heads and merge constantly
across.

Branches don't seem to have the same expectation or support in the
toolset. Why? What makes a branch different from a head, apart from
the fact that they would be expected to drift further apart?

In any case, should the cvsimport turn cvs branches into git branches
instead of heads? Is there are way to turn a head into a proper
branch?

cheers,

martin
