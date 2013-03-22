From: Josh Sharpe <josh.m.sharpe@gmail.com>
Subject: feature request - have git honor nested .gitconfig files
Date: Fri, 22 Mar 2013 12:50:07 -0400
Message-ID: <CAM2RUGOOWnxRd2=04-NmKTC+tvnCD=ebgmmiexHas5bwyYrm4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 22 17:50:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ5BA-0003Gr-Lw
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 17:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019Ab3CVQu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 12:50:29 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:55198 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1160998Ab3CVQu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 12:50:28 -0400
Received: by mail-ie0-f170.google.com with SMTP id c11so5140845ieb.15
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 09:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=zSn4fXN4BAy9Lb//lv1Ox+SYp0a8OshM6RknzrgZtzs=;
        b=zm2RWbbJF3SJE/XL+5/pYt73g0unAXruoz1Nd7VD6SEkN96kf0MV2CikxxYfQuWDDP
         eisZM4GPtJ4ImyApycDDp0ZqWXeM6WMXRPn2rl/5bG9C2/9DXUlRYLLWvG5L18k2R3Dn
         m/aKyuEjmEg11+LhTy91uyzh1/m2kHyh2xpFPxZNL/BYQwS5lN85WMn//VpdZrELE/7U
         njNK0DskCaYYGRhH7EguaMSPrp7xnKIza75Rk5diTQRvnLQ9bHop9ndxVSunkTlU2vKd
         VyZcwEWcqejp8Wy2uqiTqf9QGKS1I6MaOyBfhbMrKrcyoTJKG5jgokBvpv5lC3j0ndyi
         8Ugg==
X-Received: by 10.50.217.230 with SMTP id pb6mr5320634igc.43.1363971028017;
 Fri, 22 Mar 2013 09:50:28 -0700 (PDT)
Received: by 10.231.169.136 with HTTP; Fri, 22 Mar 2013 09:50:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218820>

It'd be cool if I were able to override config settings at every
nested directory.

For example, I have my ~/.gitconfig that has one email address in it,
but I also have multiple repos inside ~/dev which I want to use a
different email address for.  The only way to do that now is to edit
all of these: ~/dev/*/.git/conf -- and there are lots of them, and new
repos get added all the time - and I forget.

If I could add ~/dev/.gitconfig and have the settings in that override
~/.gitconfig then this would be way more manageable.  Obviously,
individual repo's .git/config should take ultimate precedence.

Thanks for the consideration!
