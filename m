From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: git push tags
Date: Fri, 26 Oct 2012 17:23:01 +0200
Message-ID: <CAB9Jk9DV=V5rSg2Wz4+GhM28fG8xwpFdP+LvXDXMUxKvR=GG4Q@mail.gmail.com>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
	<CAM9Z-nkxCOyrtJ8vCF=00vrA_1eFr2-Fk7PXjYEx0HbVt0GPkQ@mail.gmail.com>
	<CAB9Jk9A95YrrtH8ue-CJ6Mqe9Z+3nfo=tjurLZjmecfiMFijvg@mail.gmail.com>
	<CAM9Z-nkosbe1NXYnu7x6v4seLqCnMBWg-jrdH2eJ9RetaZBTyQ@mail.gmail.com>
	<CAB9Jk9ApdbN+4Yk-6+u4Nje9+tbESSGGVj95iof1jnfG4Ga7GA@mail.gmail.com>
	<CAM9Z-n=+YeF3BaF-5UB5f2GBHYw7WDZEFDVT72RGSsDBaH4PJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 17:23:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRlkk-0004Y7-9E
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 17:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933806Ab2JZPXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 11:23:03 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:34554 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933738Ab2JZPXC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 11:23:02 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1350173dak.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 08:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Saolsy3GtjyE+BetPXnZtXPSS7MFCdUAlNqqbPRc6+s=;
        b=XK0i+8VNewjix3nxAfR4WUDu7sGI/KokqfvTkK0fbxidPXjfEopG9fWMNUDbd4e40P
         C9IgZA2zxojMLQUOI5pqreHqrh0PAJbYvdf5ZBgwnmVM/Pp8xdrgAVIyfC+cI3E8QQf8
         TzJuBparrj7wyY4U9Jop0rQjbx5XjAtnZDR27LyngNbZk2egyvIw799Ucd9w2/YHWDqA
         jwFAXdTs41m94d3UlnZW83A+59gBqhhITS13E7fON3A0YyojRaNsmj6R5+zG5XD2/n9S
         TX8JvplRvc+ZpiwYZPNCK3ZwjfDWJ3PkoqyAhCJUPvgX+Ah3O4ytplF9CnU6SsdLgz3E
         flpQ==
Received: by 10.66.86.228 with SMTP id s4mr52275724paz.15.1351264982163; Fri,
 26 Oct 2012 08:23:02 -0700 (PDT)
Received: by 10.67.3.101 with HTTP; Fri, 26 Oct 2012 08:23:01 -0700 (PDT)
In-Reply-To: <CAM9Z-n=+YeF3BaF-5UB5f2GBHYw7WDZEFDVT72RGSsDBaH4PJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208453>

Hi Drew,

git is an open source, community project, which means that it benefits
from all the contributions of many people, and they are not restricted
to patches.
If the only one suggestions that were taken into account were patches
sent by people that had the time to study the sources and propose
changes, then we would miss the opportunity of taking many good things
that the community generates, like new ideas for example.

By the way, I already browsed the code, but have seen that there is
not only push.c to understand, but a dozen or more of other sources.
This is why I am not yet able to propose patches.
But I am using git all day, and often come to unexpected or
undocumented behaviors, and want to share my findings in case they
could serve to improve git. This means to me to spend time in
formulating them the best I can to make others understand what I have
found, and that is a contribution too.

Here is a proposed change to the git-push manpage:

- section: "DESCRIPTION", first paragraph ("Updates remote .."), add at the end:

   "Remote references (branches and tags) that do not exist are
created. The ones that exist are updated except when + is not
specified and they are not fast-forward updates."

-Angelo
