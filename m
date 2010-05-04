From: Robert Buck <buck.robert.j@gmail.com>
Subject: newbie: need concrete examples for how the linux-kernel project uses 
	git
Date: Tue, 4 May 2010 17:31:21 -0400
Message-ID: <m2i408104421005041431l6c8b5845ld57720c2127fbb00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 04 23:31:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9PiF-0007fk-5o
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 23:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757379Ab0EDVbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 17:31:23 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:35591 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880Ab0EDVbW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 17:31:22 -0400
Received: by ey-out-2122.google.com with SMTP id d26so244266eyd.19
        for <git@vger.kernel.org>; Tue, 04 May 2010 14:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=y0LhHfZpj3qbNPtt8zoR2ZQgdMwYeq1Lg7NQiC8Oal4=;
        b=V2I4S4wZP/h+jUKZGji4PgFpQfsps0+5F7yJ5q6Q92hpXcaz2YXuqUGrAuibHj/fzl
         h5L1rjxDSt1JD/WATx/nmPHRXjZuF5avN7oxHcIM/y144Q33pr7CQ8+fFoLzseETM1ah
         zDn+UIj9nRZ9/SD+aMkbRgl7J5z3BzKeUxLZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=vSZqhKOEfjrnBR1N577AkTQu0d0y6s9v5tln5I7xMuQF8ufamDnJeplb82G/B2dHXJ
         c/OJcKjqQnVduIswBUotRCHqsJE5AabC7vimXdqM+FZ/K+in5OJDxXJw3tXyqDbIaygB
         2Zr2QkD08VHrQI4281JSvtX6WDp2cAH4HC5iU=
Received: by 10.216.168.135 with SMTP id k7mr1026114wel.129.1273008681432; 
	Tue, 04 May 2010 14:31:21 -0700 (PDT)
Received: by 10.216.25.18 with HTTP; Tue, 4 May 2010 14:31:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146348>

Hello,

We're looking at Git at our company, and in the first phase of testing
Git passed the technical criteria with flying colors, and did much
better than Hg. We've entered the second phase of testing where I need
to basically try out the typical work flows in Git.

We have multiple teams, lots of developers, and would like to use a
variant of the dictator-lieutenant scheme discussed in published
subject matter.

However, I find it rather challenging finding any subject matter that
provides reasonable detail. What I'd like to find are concrete
examples, step-by-step, of specifically how to:

* set up each public repository: mainline, integration, maintainers, feature
 - with enough detail showing how to set up remotes, branches for
each, shared or not, ...

* perform the daily function for role, dictator, lieutenant, maintainer
 - with specific detail about the typical commands used each day

Surely someone must have documented this somewhere, or perhaps
scripted it up in some shell scripts which would be even better?

I have spent multiple days on this already, and given that I am a
novice at Git, though not with source control systems, if I could
obtain some concrete examples, this would accelerate the evaluation
quite a bit, and it would help me decipher the mounds of documentation
with the few more concrete examples.

I'd like to present the details and results to our development
organization next week, and be able to speak about some flows I
actually tried out myself.

By the way, Git, love it! Way cool guys.

A puzzled newbie,

Bob
