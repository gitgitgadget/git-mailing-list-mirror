From: Cong Wang <xiyou.wangcong@gmail.com>
Subject: Editing git changelog automatically
Date: Sun, 26 Oct 2014 22:27:17 -0700
Message-ID: <CAM_iQpWNQbv_GTT+H5KNCqqRS3qWfBuBge4+ZTAS_WiaREku4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 06:27:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xicpy-0004TO-TV
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 06:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000AbaJ0F1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2014 01:27:21 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:41808 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428AbaJ0F1S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 01:27:18 -0400
Received: by mail-oi0-f43.google.com with SMTP id e131so147895oig.16
        for <git@vger.kernel.org>; Sun, 26 Oct 2014 22:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=geY5AmYTAW5t0YZPNIZH3y0XE96PpJ+ipqEDET/4KWg=;
        b=SEZe6uAd4ApLQve3nw5w8cvkFBWDx5s+IJso+WIqlHshM4hdt0F8x4OxCcGZXKW03v
         eHUXqMMFiA7fuGWRd52cfb4Ql93cq8kjDFe7kS211Iv3cebH7TvMfkTU+ERHkYuDHpPH
         u4Pc5toZPMFTpbDAMvfEgY3ty+ZwomZiRzqxLn2jTjyTtt96xc9diTjjaZYVnXJQ6AIG
         Ex895o5uk4Jysho/uvYfR2UyCID3pv39NNksJc6hjp3BwKfBigKeYd7v2vA3kJzQ12wT
         koCpe9vYXvRIUb+nwVTGIPEmNyJwVyRLKHsYRJv6RybI1YOR+fBdol5amYYhOdgr7hFN
         +NLg==
X-Received: by 10.60.179.13 with SMTP id dc13mr18595847oec.16.1414387637959;
 Sun, 26 Oct 2014 22:27:17 -0700 (PDT)
Received: by 10.182.27.72 with HTTP; Sun, 26 Oct 2014 22:27:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, git experts


Sorry if this is a question already answered, but google search didn't
give me anything useful.

My question is how to edit dozens of git commit changelogs automatically?

Let's say I want to fix a stupid typo in all of these commits, as
simply as s/foo/bar/. Usually I use`git rebase -i` and `git commit
--amend`, but both of them are interactive, apparently I don't want to
edit them one by one. :)

I know I can change $EDITOR to something like `sed -e 's/foo/bar/'`,
but this seems pretty ugly. Is there a clean way to do that?

Thanks!
