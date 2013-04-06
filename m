From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: Advice and repo setup
Date: Sat, 06 Apr 2013 14:09:34 -0400
Message-ID: <201304061809.r36I9YZp031127@no.baka.org>
References: <CAKtB=OAot3y8fMjAf+Vh-=wOeX5b=F_N6_BLjK0fhGxGCg3Txg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Michael Campbell <michael.campbell@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 20:25:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOXYk-0002MJ-UI
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 20:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821Ab3DFSJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 14:09:37 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:38420 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754978Ab3DFSJh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 14:09:37 -0400
Received: from no.baka.org (ohayo.baka.org [IPv6:2001:470:88bb::1])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id r36I9Yj1009309
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 6 Apr 2013 14:09:34 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id r36I9YZp031127;
	Sat, 6 Apr 2013 14:09:34 -0400
In-reply-to: <CAKtB=OAot3y8fMjAf+Vh-=wOeX5b=F_N6_BLjK0fhGxGCg3Txg@mail.gmail.com>
Comments: In reply to a message from "Michael Campbell <michael.campbell@gmail.com>" dated "Sat, 06 Apr 2013 13:51:20 -0400."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220263>


In message <CAKtB=OAot3y8fMjAf+Vh-=wOeX5b=F_N6_BLjK0fhGxGCg3Txg@mail.gmail.com>, Michael Campbell writes:

    As a business decision we have decided to pull in some "staff
    augmentation".  We don't want the remote developers to have direct
    access.  Our plan is to have some sort of external repo on which they
    can push things, and locally we can pull those changes to our
    "official" repo and check it as we go.  So far so good.

You might want to consider using something like gitolite where you can
have control over which branches users can write to.  Assuming you are
not trying to restrict some branches of some repos from the external
users, this would be a better solution than setting up another repo
with some kind of automatic mirroring scheme, though that of course
will also work.

    Our product has several logically separate projects, which right now
    we have in the one big mega repo (in CVS, and migrating per checkin to
    Gitorious).

Certainly I'd recommend using one repo per conceptual unit.  There are
several techniques to group repos together if you need to.

    Is there documentation I can refer to for this, or is there an obvious
    way to do these things?  Any help or pointers appreciated.

http://sethrobertson.github.com/GitBestPractices/

					-Seth Robertson
