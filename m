From: Guanglin Xu <mzguanglin@gmail.com>
Subject: [GSoC 2014] Replacing object loading/writing layer by libgit2
Date: Thu, 20 Mar 2014 23:37:02 +0800
Message-ID: <CAATe9uhR3P=C8f10VoiEksXiQCnUXqRdXO5vQr_NUe2YP33xJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: vicent@github.com, tr@thomasrast.ch
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 16:37:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQf1y-0000Do-Rx
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 16:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759159AbaCTPhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 11:37:09 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:60689 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759144AbaCTPhD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 11:37:03 -0400
Received: by mail-ie0-f179.google.com with SMTP id lx4so1059027iec.10
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 08:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=ItJuLaWpQCZiAqAeB8uG3pdRTv7BZGwXmUdZeiPjwG8=;
        b=r0XcXanK5/qJRdpBKkHZ3CMZk3l7wuy3YtDnBRGv9c/9W19FSGmkp8Ld8GoGXZxh0m
         gnXSUsW7R+ir8OsI4U6JyKd8DsqKj5eEJVqQgMKXZkAWWnFdy8qXRYKUC/rbcuS1Js0r
         Z9POZermItneCDirVyrZXlXxipgHRr5yeJcFctYQdGxwNKaCugejZ39HrF/6/78kJyKt
         Tz1eNGwjjWpBzzxfV0Jb6MAEfh/VkABMOJaHhetfuBJrqtyHlEWJ+SJ9thN37YH7m0y2
         QG36GFv+9uq4JKT5vi/JxRwCO7P3KjL/VR7Yj1toukWbtCZGKXMs38pSP9TpJ8unfn4l
         /Ddw==
X-Received: by 10.42.204.197 with SMTP id fn5mr279115icb.95.1395329822870;
 Thu, 20 Mar 2014 08:37:02 -0700 (PDT)
Received: by 10.64.14.135 with HTTP; Thu, 20 Mar 2014 08:37:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244552>

Hello,

My name is Guanglin Xu. I am a second-year master student at Sun
Yat-sen University in China, majoring in Software Engineering. I am
also a perspective PhD student matriculated in the US. I'm planning on
doing summer projects which I can work remotely. The GSoC 2014 program
of Git project is a great choice.

I am kind of a "skillful" Git user with 4 years' experience in 3
projects. For example, I am a Top 5 contributor in LibVMI project
(https://github.com/bdpayne/libvmi); I host a team-made mobile app in
Github (https://itunes.apple.com/us/app/ying-yue/id689566688?ls=1&mt=8).
For more of my projects see here
(http://www.andrew.cmu.edu/user/guanglin)

To get familiar with the flow of Git development, I worked on
microproject [2] and had corresponding conversations with Eric
Sunshine, Jacopo Notarstefano and Sun He in threads. Thank you for
their comments on my work.

Now I've submitted my proposal to google-melange. In brief, I propose
to replace object loading/writing layer by libgit2, which comes from
the GSoC 2014 ideas page of Git project. Particularly, since I didn't
realize where the hardest part is when I looked into the initial aim
of this idea, I added a performance requirement that the new
implementation should at least not run slower than previous one. Maybe
I underestimated specific challenge in working with Git, suggestions
or warnings for this topic are all welcomed.

Thanks for your consideration for GSoC 2014.

Guanglin
