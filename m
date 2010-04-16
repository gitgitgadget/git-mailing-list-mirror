From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Git import of the recent full enwiki dump
Date: Sat, 17 Apr 2010 01:47:21 +0200
Message-ID: <w2x2d460de71004161647z41492baav3685249fa05145d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: wikitech-l@lists.wikimedia.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 17 01:47:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2vG7-0003zt-TI
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 01:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932787Ab0DPXrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 19:47:24 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:44484 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932783Ab0DPXrX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 19:47:23 -0400
Received: by bwz25 with SMTP id 25so3728448bwz.28
        for <git@vger.kernel.org>; Fri, 16 Apr 2010 16:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=+grSNzURFivBdzF9TXjj7m8TlMlM7n915MFqTKH+OP8=;
        b=c2vOJYfFJfJHW2tGIit+kRmKM/2a6QOtNB26beTZys3wJY8o5lEVvQWasQVYdWj8Jc
         l67O0wnwur7dY0Np+M7XBm8Vvzk30lAuBi1APyYU/gg/6xaq8PHWPcODbXHkEhSnfvfT
         ChFte22Tco5GVoaafHCK4w4p1L4uB19s+9q+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=JAGjUlPrnGPAJtFsuVYJFLznGNLyVrJ0VQhf6rpg25LorZ5UleugRyuusuvsiCuoUt
         Lcv3syx1OwaCjMMS6S/g9+ecVZP52KJKco1D67jxRO6dNVjqgEu7KHHtX6e/dvjWYDYx
         aNZauBTvuJrX3GkvowlyAS5Za0ITrIXjUntdo=
Received: by 10.204.73.77 with HTTP; Fri, 16 Apr 2010 16:47:21 -0700 (PDT)
Received: by 10.204.153.205 with SMTP id l13mr2185778bkw.95.1271461641638; 
	Fri, 16 Apr 2010 16:47:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145099>

-- This email has been sent to two lists --

Hi all,

I would be interested to import the whole enwiki dump [1] into git[2].

This data set is probably the largest set of changes on earth, so
it's highly interesting to see what git will make of it.

As of right now, I am trying to import on my local machine, but
my first, rough, projections tell me my machine will melt down at
some point ;)

Assuming my local import fails, I would appreciate it if this could
be added to wikitech's longer-term todo list.
If anyone has access to a system with several TiB of free disk
space which they can spare for a week or three, it would be
awesome. If given shell access, I can take care of this task,
but I would be happy to assist anyone attempting it, as well.

If need be, I can get various people from various communities
to vouch for me, my character & that I Do Not Break Stuff.


Richard Hartmann

PS: If anyone attempts to do this, please poke me. Either
via email or RichiH on freenode, OFTC and IRCnet.

[1] http://download.wikimedia.org/enwiki/20100130/
[2] http://git-scm.com/
