From: Duy Nguyen <pclouds@gmail.com>
Subject: Another use of "@"?
Date: Fri, 3 May 2013 12:51:18 +1000
Message-ID: <CACsJy8AcWV8hmbhG27dw+GdnZf8NnQEctYmowqd3sSzOOHf+xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 03 04:51:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY66E-0007yX-9v
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 04:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761527Ab3ECCvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 22:51:50 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:39186 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760710Ab3ECCvt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 22:51:49 -0400
Received: by mail-ob0-f175.google.com with SMTP id oi10so1061317obb.20
        for <git@vger.kernel.org>; Thu, 02 May 2013 19:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=e8RMcklXNolvDyRGFMViYKtVSbA9jbqQ7pZr0MxEssc=;
        b=WW1LLBvrh0uMKX7ltkij9qXHUAyyMVYcEPB+hN7rMBD41HwIO9hL808R/8Vc/eqq7e
         KAxuO0UqCDvQqFLRxBnt00Kb+uiDs8jZmnt1jCLr+ODUoAtNwFvBfQqxGSJyU2n76xQb
         8BJH7zllXUi4RJdXt5mXO8FTUeWV9bZwaDV9Rt86lsFeqEDSClLu1xYCgtT99Rq1n6Cm
         L8DdK9AerEMyN4Pbrfgm2dxNHg5M8Ag9vxmkUAPj1FCOZKV8VyW7PiIDOKYxSnxLZ3jx
         2Ifvj0VNg9RzToC/sZfMphp1YXJn6fcvhVy7idhy064pCjMwC+ad6j5g2b8R8vj8LTOw
         Xcsw==
X-Received: by 10.60.83.103 with SMTP id p7mr979179oey.130.1367549508827; Thu,
 02 May 2013 19:51:48 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Thu, 2 May 2013 19:51:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223269>

Hi,

My setup is a bit peculiar where I do git development on three
different machines. Say I updated branch long-branch-name on machine
A. Then I continue my work on machine B. I would want to hard reset
that long-branch-name on machine B before resuming my work. What I
usually do is

git co long-branch-name
git diff A/long-branch-name
git reset --hard A/long-branch-name

but typing long-branch-name (even with TAB completion) is not fun.
Could I do this (or something similar) instead?

git co long-branch-name
git diff A/@
git reset --hard A/@
--
Duy
