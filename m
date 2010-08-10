From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: workflow for working on feature branches and incrementally 
	incorporating "master" changes
Date: Tue, 10 Aug 2010 16:20:16 -0400
Message-ID: <AANLkTi=h2MbSKmQk9p6w44WORAa8XzkpF0nBXKOgJ4T1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 22:20:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OivJA-0004Qf-Mp
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 22:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757716Ab0HJUUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 16:20:20 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44942 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754860Ab0HJUUS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 16:20:18 -0400
Received: by fxm13 with SMTP id 13so964246fxm.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 13:20:17 -0700 (PDT)
Received: by 10.239.146.210 with SMTP id x18mr961598hba.112.1281471616993; 
	Tue, 10 Aug 2010 13:20:16 -0700 (PDT)
Received: by 10.239.179.5 with HTTP; Tue, 10 Aug 2010 13:20:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153153>

If you're working on a feature branch by yourself, what is a good
workflow for keeping the branch in up-to-date with "master" as you're
developing on the feature branch or is this unnecessary? Should you
just wait until you want to officially integrate the feature branch
into the "master"?

We were doing:

commit to local feature branch
push to remote feature branch
... repeat....
rebase from master (occasionally)
push to remote

but at this point the branches have diverged.

We're coming at this from SVN, so we might just be thinking about this
the wrong way.

Thanks!
