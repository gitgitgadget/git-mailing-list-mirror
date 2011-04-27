From: Eric Frederich <eric.frederich@gmail.com>
Subject: remove all traces of some files
Date: Wed, 27 Apr 2011 15:58:39 -0400
Message-ID: <BANLkTim_PriowuBH71M2DxxkJ=Y5oAA2uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 21:58:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFAso-0002Xo-AU
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 21:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954Ab1D0T6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 15:58:41 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35358 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab1D0T6k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 15:58:40 -0400
Received: by wwa36 with SMTP id 36so2295369wwa.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 12:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=9Ys0/3N5D02kU78JC98jpAaLRCWxrCuwe3TJ227Y930=;
        b=nXZN5TgaNQqEzAg0NYPVT062g6Ddi8pjqUX8GATz0MZZeDCDBvsvjRJ84sffJTW9jw
         1brBu3TAtbH0EIvMa5ALeP69IwZ6DGXzrW9V+M8x+0vGV6Wlxxiq1hlGZoXkFePFEy22
         OVQjU+vC5mWZ4+fK30oLFYKr00gPDAPBfWlzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=pXhJRz4HdTGLvTDujX5oCUdSoWGDd0pPoCkbWJzKo/rfuovXl+xF22aGyO4zvMV8jg
         EdGCYLnYKidp9JxZIK8RrnI6duSn+MZ1ZCyHog5pRZRNiNMnpESBgfj6+RovRtq+F1nP
         CAoPW5Jlw17zE2L8Y1/7EgOMZfXbePAOzlDPI=
Received: by 10.227.200.210 with SMTP id ex18mr2620301wbb.139.1303934319172;
 Wed, 27 Apr 2011 12:58:39 -0700 (PDT)
Received: by 10.227.138.81 with HTTP; Wed, 27 Apr 2011 12:58:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172266>

I have been adding build files (.dll and .so files) to my git
repository periodically when I have been doing builds of my project.
I know I shouldn't be doing this and want to set up some other kind of
separate archive or something for built files.

Although there are other devs on the project, I am the only one using
Git.  Everyone else uses AccuRev.
Personally, I maintain my own Git repo (with an AccuRev git branch).

I would like to remove all traces of those .dll and .so files if I
could in my git repository.
I realize this would mess with hashes and would ultimately result in a
completely new tree.
I am fine with that since, as I said, I am the only user of this Git repo.

So, can this be done?  Can I rebuild the tree preserving commit
messages, timestamps, etc but ignoring certain files?

Thanks,
~Eric
