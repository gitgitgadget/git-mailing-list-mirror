From: bradford <fingermark@gmail.com>
Subject: Workflow Recommendation - Probably your 1000th
Date: Thu, 1 Dec 2011 13:26:10 -0500
Message-ID: <CAEbKVFSXn3we7Btb3fN5DUW7BMub_ZrBeUwLUZrRFTmESoW97A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 19:26:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWBKq-0003pu-Ok
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 19:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756113Ab1LAS0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 13:26:12 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62641 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756016Ab1LAS0L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 13:26:11 -0500
Received: by eaak14 with SMTP id k14so2466963eaa.19
        for <git@vger.kernel.org>; Thu, 01 Dec 2011 10:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=+HXLUlEQVsYRxTdITD3Sfgd5DTtSc2qq828/35t3+g8=;
        b=DB3eXkHCiAfNPlKhKw1STurEtL8bxks4jsMCxXD/KHhRzeEjHaP1F7iq5OUlnZD3mY
         pDft4RqSc1w2v5aFNirM5EMBFummvilzOvwNSpD8pYKhMvRa47FTtH9UYfKYzz5azUSm
         HWvainGXksrnf5HDuVQkWDUZFiH83mCIUt4gg=
Received: by 10.227.207.67 with SMTP id fx3mr3243187wbb.0.1322763970176; Thu,
 01 Dec 2011 10:26:10 -0800 (PST)
Received: by 10.227.130.150 with HTTP; Thu, 1 Dec 2011 10:26:10 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186182>

You guys probably receive a ton of workflow related questions.  I'm
trying to convert from svn to git.  In order to complete, I would like
to be able to provide a workflow to our team.  We typically go from
dev -> qa -> production (Java and Rails projects).  The problem is
that sometimes QA can get backed up and we'll need to release
something to production while QA is doing their thing.  What is a good
workflow?  I would like to not use git-flow, because it's another
tool.  I've read suggestions to use environment branches (master,
staging, production).  I've also read not to do this and just use
master, tagging your production releases.  How well would our setup,
where things can get backed up, work with the latter?  Are there any
alternative suggestions?

Thanks,
Bradford
