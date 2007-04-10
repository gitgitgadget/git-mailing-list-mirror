From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: git-branch and git-remotes confusion
Date: Wed, 11 Apr 2007 00:05:17 +1200
Message-ID: <46a038f90704100505i7bdd88a8q52186f7ce7ff0cdf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 17:58:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbF6X-00009y-AG
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 14:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbXDJMFW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 08:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965153AbXDJMFW
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 08:05:22 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:50885 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965104AbXDJMFT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 08:05:19 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1855757wxd
        for <git@vger.kernel.org>; Tue, 10 Apr 2007 05:05:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kSVaDwQwTZ8yV8AnSr0/14XUYtmSnSzVTFmorzEPVhF9/uPskKm0EcdAXvqb2r6EnZssq/j2hTMICVPSzAmuOsylqpsZ+/lWIFfaKG2q6ZHbpRd34MVLmphMdBoz4aW9a6X1F1gnxjTyK9W0L1tM2KAXy9v7m1eAHLN/YCash7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LiTwNozYAdME6P+GzkAfup17DDKA9YmBdhSyoOS9ckAn20/9kiWwOr8e5c4wB4kTkGkbzZpjIG1lzljc0W6QTs/eNypdHFzpaMSoDLPV7kFTgQeqDW4FEpoXGBLb3WnxF0DcljT405+fZlN8HU1sUxJY+Il/zTc3PlJr23TIPoc=
Received: by 10.90.105.20 with SMTP id d20mr5042734agc.1176206717305;
        Tue, 10 Apr 2007 05:05:17 -0700 (PDT)
Received: by 10.90.120.11 with HTTP; Tue, 10 Apr 2007 05:05:17 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44128>

Hi,

maybe I'm daft, or cogito has eaten my brain. The task at hand is
really simple: clone from repo X, tracking branch Y (where branch Y !=
HEAD). The repo is http://git.catalyst.net.nz/git/moodle-r2.git , the
branch is mdl18-olpc .

With cg, this is trivial:

  cg-clone http://git.catalyst.net.nz/git/moodle-r2.git#mdl18-olpc

which automagically gives me a "master" and "origin" pair of heads
that do the right thing. Specifically, cg-update does the right thing.

With git 1.5.x, I managed to figure out that this is wrong. :

  git-clone --origin mdl18-olpc \
      http://git.catalyst.net.nz/git/moodle-r2.git

and now I am trying to see if some incantation around this works

   git-clone http://git.catalyst.net.nz/git/moodle-r2.git
   git-branch --track origin/mdl18-olpc my18-olpc

But it isn't working, and I'm reading git/Documentation for git-branch
and git-remote but I can't find it. I don't care about any other
branch (though if they are there, fine!). Is there a trivially simple
answer.

(Cogito has eaten my brain probably. For a long time I've always
cloned with cogito just for the sake of this convenience, even if I
was going to use git mostly when working with the code. Now I'm
working on a server that only has git, so I thought 1.5.x would make
this trivial...)

cheers,



martin
