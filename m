From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: Commit template
Date: Sun, 8 May 2005 15:20:31 -0400 (EDT)
Message-ID: <2003.10.10.10.24.1115580031.squirrel@linux1>
References: <1965.10.10.10.24.1115579256.squirrel@linux1>
    <1115579764.8949.15.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Petr Baudis" <pasky@ucw.cz>,
	"GIT Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 21:22:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUrLJ-00022j-P9
	for gcvg-git@gmane.org; Sun, 08 May 2005 21:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262970AbVEHTWt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 15:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbVEHTVu
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 15:21:50 -0400
Received: from simmts6.bellnexxia.net ([206.47.199.164]:41466 "EHLO
	simmts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262966AbVEHTUc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 15:20:32 -0400
Received: from linux1 ([69.156.111.46]) by simmts6-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050508192031.JDCN1834.simmts6-srv.bellnexxia.net@linux1>;
          Sun, 8 May 2005 15:20:31 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j48JKVY9027761;
	Sun, 8 May 2005 15:20:31 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sun, 8 May 2005 15:20:31 -0400 (EDT)
In-Reply-To: <1115579764.8949.15.camel@pegasus>
To: "Marcel Holtmann" <marcel@holtmann.org>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, May 8, 2005 3:16 pm, Marcel Holtmann said:
> Hi Sean,
>
>> This adds the ability to have a per repository commit template.  Create
>> a
>> .git/commit.form file containg  "CG: " and other lines and it will be
>> used
>> in place of the regular top 3 lines.  This is kind of handy so that you
>> can include your signed-off-by: with your email etc.
>
> I think it is a bad idea to take the CG: into it. Let them be created by
> the cg-commit script, because it knows what to do.
>
> The question now is when we should provide that form. For me it only
> makes sense if it is not a merge and if no commit message is provided
> via command line.


Marcel,

Yeah, it was just a quick hack.  You're not forced to put any CG: lines in
the commit template of course, but it will handle it if you do.   Even
with the patch, cg-commit will add addtional CG: lines containing a list
of modified files etc..

Sean


