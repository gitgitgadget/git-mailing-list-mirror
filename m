From: Subho Banerjee <subs.zero@gmail.com>
Subject: Git.pm
Date: Thu, 26 Apr 2012 09:45:09 +0530
Message-ID: <CAB3zAY3-Bn86bCr7Rxqi4vxbYFxUesLwm8gddxyMSexov2tOhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 26 06:16:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNG7j-00044R-Sx
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 06:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208Ab2DZEPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 00:15:31 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:64811 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754Ab2DZEPb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 00:15:31 -0400
Received: by vcqp1 with SMTP id p1so613119vcq.19
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 21:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=v9jDTdvJbcOFfhIQ9joUhX/eiutmi3PEA31eUvgh0Dg=;
        b=Yoj4IWWZLjs2Kb1AheLoMLi8P3fh2pYWGPphV+BaHan3BRgr6UpLlLNJDvN96Uf8EY
         EjN/1hB85jDYGOEcOSFvoyeAi4OeGqK//WvunmshuB1gnt01sXF+cSqgzoDSu1wb+LHN
         4Y8SqKezMTzbRHG34faXCyMTUf5V403+F4Pd11VloxX/NOS+WYgRZwvAqmBA/g4o7YiC
         mT4qd6d3SGqloywuHrgRwQHFnqgSECYlbXPg6/aHQzFf4sWULunFcu0SlPS8VipwdQs3
         dvyF+chRnd1toMjx06Q+wC97Biyw/tNvS5fPWhZIdlUbKC4ze8vDPk6ptgcnql9qUTy0
         RsmA==
Received: by 10.220.226.68 with SMTP id iv4mr5375957vcb.21.1335413730209; Wed,
 25 Apr 2012 21:15:30 -0700 (PDT)
Received: by 10.220.189.137 with HTTP; Wed, 25 Apr 2012 21:15:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196349>

Hello,
I had made a proposal for the Git.pm project in GSoC. The proposal did
not get accepted, however, I see that no one in the GSoC accepted list
is actually working on the Git.pm project. If some of you could give
me some of your time in terms of advice on what exactly is needed for
the module, I am willing to work over the summer to get this module
production-ready. I can probably put in 15-20 hours a week on this
project from May to August. I believe that will be enough time to
roughly complete all that I had enumerated in my GSoC proposal. This
of course will be strictly outside the GSoC framework.

I plan to start coding on the project by 7th May and use the time from
then to now to investigate what code is there/ what is to be done etc.
I had made an approximate timeline for the GSoC proposal and I would
like to follow it -
---> [By 15th May] Get the current perl code, to use another mechanism
of throwing errors(Try:Tiny)
---> [By August] Get in place a more robust perl wrapper ie. expand
the code have a couple of more objects, Git::Repo, Git::Config etc.
---> If all goes well, then by the beginning of August, get the perl
module ready for CPANfication

I also had a couple of questions -
---> Do I base my code revisions on the master branch of the Git
codebase[https://github.com/git/git]? Or is there some other
repository which might be more recent.
---> I saw gitweb-caching code from a previous GSoC project, the perl
module there seems to have been developed beyond what is there in the
master brach? However, these changes are atleast a couple of years old
and havent been incorporated in the main codebase... Is there any
particular reason for that?
---> I see in the code that it says that the API is experimental. Is
there any absolute need for backward compatibility, or can I try to
redesign the API somewhat extensively?

Also, any suggestions and tips you can give me about the project will
be very helpful.

Cheers,
Subho.
