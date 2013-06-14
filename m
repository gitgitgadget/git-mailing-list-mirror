From: Eric Fleischman <efleischman@gmail.com>
Subject: Teams of people using signed commits...
Date: Fri, 14 Jun 2013 12:02:01 -0700
Message-ID: <CABQymNKuwiOz-MQuM12fWSgBvBsBrykNYBqPBxCuSuxAC5cZZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 14 21:02:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnZGD-0000Yc-JT
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 21:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658Ab3FNTCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 15:02:05 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:40120 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985Ab3FNTCE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 15:02:04 -0400
Received: by mail-lb0-f173.google.com with SMTP id v1so904631lbd.32
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 12:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=RhchGL0fmGJAJzDxePZ15Ncr8M+rZNRKyw9O1IQga0c=;
        b=YsXZGsXQboInlrIhd75tcAhDJn7YN6vfcTLUEsNAKEN93ZJDQtLZT95oeKnakNh1tI
         HntZfy2dy6BtwvJphnNQuoZJBXFoqDWVS/8HaUuBcLQM3buKScf6yTRFAqNTKYZy7rU2
         R1zdXhvv7bs4O2rt4cPK+hXIPE1LWxb9qW8qW5ItYvT5ElPRqRLFGiyHTXVxxoyjwdN1
         7nGyExs6RwoIv64o6kqO4/cs41FkOmhvhY2Ty6S/EBxRcvLF9D/hKpGstbD2wPlhjXdd
         DMQKxv/jxOinkZNPnhjbdBg8UOO5pl2waUKNJjf99c1RoXsgazH5GraE88PItp6IyXg1
         t3Rw==
X-Received: by 10.112.72.67 with SMTP id b3mr1719776lbv.35.1371236521866; Fri,
 14 Jun 2013 12:02:01 -0700 (PDT)
Received: by 10.114.18.202 with HTTP; Fri, 14 Jun 2013 12:02:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227912>

We're very interested in using signed commits but are struggling to
figure out how to use it in the real world. Would love some advice
from those who know more.

We think we know how to deal with signed commits & auto-reject such
commits at build time, as well as clean up. But we're worried that
folks won't sign on the way in accidentally. We don't know of a good
way to force the team to always sign commits yet, especially as they
get new machines and what hav eyou.

Is there a way to add something to the repo config to force, or at
least default, this?
We considered forking git and forcing this on the team, forcing them
to sign for our repos. But we'd love to avoid this sort of
heavy-handed approach.

Thx!
Eric
