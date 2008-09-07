From: "Andrew Chilton" <andychilton@gmail.com>
Subject: Follow on from "Git Aware Distributed Issue Trackers"
Date: Sun, 7 Sep 2008 23:40:24 +1200
Message-ID: <a364f6fa0809070440w4877ca09oceeeef711ccdf599@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: cil-dev@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 07 13:46:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcIjA-0004Tm-GU
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 13:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbYIGLk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 07:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753246AbYIGLk1
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 07:40:27 -0400
Received: from ti-out-0910.google.com ([209.85.142.186]:45469 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185AbYIGLk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 07:40:26 -0400
Received: by ti-out-0910.google.com with SMTP id b6so621981tic.23
        for <git@vger.kernel.org>; Sun, 07 Sep 2008 04:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=6VDAAiUe/nMY3jJip6khOzQNR4CyHn1HsmARX6fiBjY=;
        b=lk+gSvWnvKLDPk43ynE8jVKLuim2dUSiz68kZyP7zQw+7eKdUvmTm9/FY5bARqHX6y
         +CtLqo9vdZ6XlRfTYKyde5izu9iKwGM27e5XQ+UlYO16UkujKa63TkYWjuKEf8VGH6FI
         btV9OPNNNVKgxtcfhvvlWkpasbx85TeEhSAXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Wm8o6LM26qZqiRP3vOl5+xhipEgLsNaVAVOpV9pOtskbmsQLF/NYe9sPvP3U/R3y83
         HSf7NfwPBRJg1Pq0uMfH9rdxPrK4kJIfB0Amv4X9s83pYv//BY9CBHEVB/tOraczzhAg
         bvmJdK7r5hfR/BjiWwqG9qiRoGuaUjAsaRZg8=
Received: by 10.110.49.2 with SMTP id w2mr15341534tiw.28.1220787624206;
        Sun, 07 Sep 2008 04:40:24 -0700 (PDT)
Received: by 10.110.15.16 with HTTP; Sun, 7 Sep 2008 04:40:24 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95134>

Hi everyone@Git (and copied to cil-dev list too),

Martin Langhoff who is on the Git mailing list pointed me to a thread
you guys were having on 24th August
(http://marc.info/?l=git&m=121924582628111) regarding Distributed
Issue Trackers. Cil was mentioned and some questions asked so thought
I should say hello and try to respond to a couple here. Sorry for not
replying earlier but I've been on holiday and mainly disconnected.

Shaun O Pearce (http://marc.info/?l=git&m=121925072006524&w=2) asked:
> If I mark the status of an issue in a branch that isn't ready
> for mainline how do I share that status update with everyone else?

That's a good question and one I'm still not sure of myself. I've had
discussions with friends and colleagues of mine regarding some of
these issues and certainly have some ideas (like a separate Git Repo
as you suggested later) but I think you're right when you mention that
"Nobody has solved the hard technical problem of making it easy to
distribute the state changes...[snip]".

Which is why there is a small group of us over on the Cil Development
mailing list (http://groups.google.com/group/cil-dev)  discussing what
should happen in various situations. It's certainly a new field to
play in and lots of points are up for grabs :-)

I don't want to go on too much here (unless you want me too) since
this mailing list is for Git rather than Cil but I invite any of you
over to the Cil Dev mailing list where we can thrash around some
ideas. I think some of these problems _can_ be solved but I rather
think it's a case that no-one has really tried it yet AND tried to
solve them. Cil has been tracking it's own issues since about day 2 so
we have solved a couple of problems encountered along the way though
there are definitely lots more nuts to crack.

Finally, I'm eager to try lots of ideas out so any patches to Cil are
very welcome. In all honesty, I'm still relatively new to Git and
whilst I generally know what I'm talking about I certainly don't have
the experience of you guys, something which would be very much
welcomed if you're interested in Cil, either for Git itself or your
own projects.

BTW: I must sign off with a huge thank you, Git has been wonderful
since I started using it :-D

Cheers,
Andy

-- 
contact: Andrew Chilton
website: http://kapiti.geek.nz/
