From: "Dan McGee" <dpmcgee@gmail.com>
Subject: Update local tracking refs when pushing- no way to disable
Date: Thu, 5 Jul 2007 20:22:04 -0400
Message-ID: <449c10960707051722q6650ec7dq6012695acdfba4af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 02:22:16 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6baO-000376-9O
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 02:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757612AbXGFAWJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 20:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbXGFAWH
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 20:22:07 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:6496 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757576AbXGFAWG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 20:22:06 -0400
Received: by nf-out-0910.google.com with SMTP id g13so3945nfb
        for <git@vger.kernel.org>; Thu, 05 Jul 2007 17:22:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=POWtGkqPXrE1qbu/EmCnzUncBkUisLJFsrL0AAYndYs4S6c6dLbcxXsUwxJQ8wZ4IttGAKqfPTvHspPXmFIb0LIgt86o3VX6JgZ32PjXzWSOTP7LELk5M93gYZyX7IIUXFycM/QcSrz7T4GrMcue6nyjCR/ngHGRbUP27OzVXl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=S+ujRTtKSPvFgfv8LM7+q1x/pyuqWkyR88ytV6+urn0zRKNtT4xMebhWzZA1Jt5lZ2+NLaOyteSJLeDf484WTyWUEdMyjHTCpOb7BbpDpLLWaJEd+KJLvHjyZEl+qoRqhPHZCuTXXITZxGpdWyqRQ7QFrUGOZtaPIdDfO+H3Pr4=
Received: by 10.82.160.2 with SMTP id i2mr404752bue.1183681324525;
        Thu, 05 Jul 2007 17:22:04 -0700 (PDT)
Received: by 10.82.135.2 with HTTP; Thu, 5 Jul 2007 17:22:04 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51706>

In this commit:
b516968ff62ec153e008d033c153affd7ba9ddc6

I don't know if anyone else has the same way of working as I do, but I
tend to set the "remote.<name>.skipDefaultUpdate" property to true for
my publicly visible repository, just so I don't have duplicate branch
heads lying around in my local repository. Call this peculiar, but I
like it that way. However, git-push does not respect this property,
meaning I know have these branches whether I want them or not. In a
tool such as qgit or even 'git branch -a' output, it starts to get
awful cluttered.

I'm not terribly familiar with GIT internals, so I don't know that I
am the best to make a patch for this, but I'll take no response as a
answer that I should start coding something up. Please CC me on
emails, I'm not on the GIT mailing list.

-Dan
