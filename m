From: Elazar Leibovich <elazarl@gmail.com>
Subject: Supporting "-v" option for git-log
Date: Wed, 25 May 2011 12:40:48 +0300
Message-ID: <BANLkTik70gu0NUzUEnGNWHQr8CfbdPVe5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 11:40:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPAaE-0004nK-V4
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 11:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275Ab1EYJkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 05:40:49 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39674 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848Ab1EYJkt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 05:40:49 -0400
Received: by gyd10 with SMTP id 10so2942036gyd.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 02:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=NtyiUx0J2yD1uEsnpFaJX78J5nRHtYpViKUKR7gfels=;
        b=HfbRyFtyQubJx8C//G65eqpZrz2ehjiQBDfRPXzVQ0tLaJe6+VfZMKd+3VOh1qE2i6
         cPOUJZfATpMAhWfEoWUI5FS1wfQUr9gWfvTljDkRuV/Tmcdu8tGwZNScR9+wQdEnKKMV
         yx+8uQxAIPhPyh2aKZ9Pj58zBOOKzUQdaJM74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=n/OPWKdDM/nbfXKSEzf/Kqp1EPSnKwu3Yq+lj7AZle822PrOOzZ/e0oa7HCGC9k6cs
         E4rJJWZPCJhQxLkSqP0LPnI8JH7T4stO062l4Y77/gtMbXeSOAG8jOS8ydHJWP1ZYKKy
         ZUVZ2jr8VMwBx2oyzGsEAtdN00MFp2PEAYcr4=
Received: by 10.236.157.129 with SMTP id o1mr1313592yhk.93.1306316448475; Wed,
 25 May 2011 02:40:48 -0700 (PDT)
Received: by 10.236.208.134 with HTTP; Wed, 25 May 2011 02:40:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174377>

I want to use git log to show all commits that do not match a given
pattern. I know I can use the following to show all commits that do
match a pattern, similar to the "grep -v" command line option:

    git log -v --grep=<pattern> # results all commits that do NOT match pattern

Is there a way invert the sense of matching?

If not, is it OK to submit a patch? Anything to consider for this patch?


[*] x-post from here
http://stackoverflow.com/questions/5602204/how-to-invert-git-log-grep-pattern-or-how-to-show-git-logs-that-dont-match
