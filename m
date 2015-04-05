From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: How to send a warning message from git hosting server?
Date: Mon, 6 Apr 2015 00:04:43 +0900
Message-ID: <CAFT+Tg-Gwr9EemFv88+=Ao21dGYe73D-CDiT4mXU4kuP-niOSw@mail.gmail.com>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 17:04:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yem6T-0000ff-Lj
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 17:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbbDEPEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2015 11:04:44 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33765 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbbDEPEn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2015 11:04:43 -0400
Received: by qkx62 with SMTP id 62so7976961qkx.0
        for <git@vger.kernel.org>; Sun, 05 Apr 2015 08:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        bh=8VGQSvmCfH+NCeJA3rj1zrpE98jiZr5XDHljn6LL9oE=;
        b=QCIW8LZ6m+n8oIgMS/G35mHA5q7RDO5kYZ1iU9SIsWmxXrYWpvbFv/pujgn8c4djEv
         SvA7TSe5bpkovpUYsMnG1lVa64SJZMDtPQoOAzOTzINFRfNwAIJbNXD7WHmFG1/yJoHk
         ySs2eXuBBBI8vMAfITRPH8Ljh2KS4nR2Rrv6h48+vw0OLDMWhNSNBPTOTg/+AayrtoXf
         SmeCUQVyTs86klb3OXmHV+4BdZGDVl3dR8TyQMvee/99xu7Pp1undnNeK0zsBSYQ/SM/
         ALjvV5f3n4anJauxWKPQvb91rHCd0DVLavdHseSjb91Cx2u95ZFgTYaCFKXh5P7/GGe8
         l/iw==
X-Received: by 10.55.33.94 with SMTP id h91mr8448519qkh.69.1428246283107; Sun,
 05 Apr 2015 08:04:43 -0700 (PDT)
Received: by 10.140.105.161 with HTTP; Sun, 5 Apr 2015 08:04:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266809>

Hello. I am serving a git hosting service for my company.

Sometimes I want to send a warning message to users who use my
service; e.g. the service will be shutdown tomorrow for a while
temporary.

I know it is possible to a remote message by hooks or HTTP body if an
error occured. But it seems that there is no hooks for git-fetch and
git does not print HTTP body if there is no error.

I want a way to response a remote message when a client send any kind
of request. Is it possible?

-EungJun
