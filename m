From: Francis Moreau <francis.moro@gmail.com>
Subject: Save notes state when releasing
Date: Fri, 20 Sep 2013 07:38:17 +0200
Message-ID: <CAC9WiBh3ha61M789DL==Nch30P_mvGwDLODqNzwaAbmHtyhPkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 20 07:38:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMtQ6-00026A-NF
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 07:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753810Ab3ITFiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Sep 2013 01:38:19 -0400
Received: from mail-ve0-f181.google.com ([209.85.128.181]:50512 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808Ab3ITFiS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 01:38:18 -0400
Received: by mail-ve0-f181.google.com with SMTP id oy12so7423567veb.26
        for <git@vger.kernel.org>; Thu, 19 Sep 2013 22:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=BlO5VwMSpa7Elbi7K0Q5TI3TCq06Xk/Xb2Bh6DvopJI=;
        b=Gko9SxrHREmRcpxw//gCHEePbvmhxTOkrVpXymxvuIYHDPHxs4UsxBKUyd/YYy9R2j
         fcHq7lMrItwuvPTZe6ZyNsORYgtO1MfnVQrixK+ykF5jjw9rcniw5Qy1jY09YUgQD4S/
         RuWBDez7YtUohIifXq29ZoYnMvQTg7gk2DaCjb6p+lnnOdrTyxOr8qJHN718Qv/5cwdb
         /63guKacFdSf117QUuR21gEdbXKHmuJOz+ZuA7mCpAp8ncqJN1pfbqtwu7f6J/5oqDWJ
         Gh7BQ48wij/mwEdM/iUM7WDCRx7Gkk3aoY40mqe+HEWh9r/OzeL3Alcqbajov/uwAOS1
         PHFA==
X-Received: by 10.221.64.17 with SMTP id xg17mr4663879vcb.5.1379655497728;
 Thu, 19 Sep 2013 22:38:17 -0700 (PDT)
Received: by 10.58.8.169 with HTTP; Thu, 19 Sep 2013 22:38:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235059>

Hello,

I'm using notes in my project. I'm wondering if it's possible to save
the state of the notes when I'm releasing/tagging a new version of my
project so I can restore the saved notes state if I checkout back the
old release.

Therefore I would be able to inspect notes (which may have been
removed or modified after the release) as they were when the release
happened.

Thanks
-- 
Francis
