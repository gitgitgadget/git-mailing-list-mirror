From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: Commit template
Date: Sun, 8 May 2005 15:57:24 -0400 (EDT)
Message-ID: <2095.10.10.10.24.1115582244.squirrel@linux1>
References: <1965.10.10.10.24.1115579256.squirrel@linux1> 
    <1115579764.8949.15.camel@pegasus> 
    <2003.10.10.10.24.1115580031.squirrel@linux1>
    <1115580630.8949.27.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Petr Baudis" <pasky@ucw.cz>,
	"GIT Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 22:09:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUs57-0000YW-VA
	for gcvg-git@gmane.org; Sun, 08 May 2005 22:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262938AbVEHUA2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 16:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbVEHT7j
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 15:59:39 -0400
Received: from simmts5.bellnexxia.net ([206.47.199.163]:50933 "EHLO
	simmts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262944AbVEHT5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 15:57:25 -0400
Received: from linux1 ([69.156.111.46]) by simmts5-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050508195724.HIME1614.simmts5-srv.bellnexxia.net@linux1>;
          Sun, 8 May 2005 15:57:24 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j48JvOZH028347;
	Sun, 8 May 2005 15:57:24 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sun, 8 May 2005 15:57:24 -0400 (EDT)
In-Reply-To: <1115580630.8949.27.camel@pegasus>
To: "Marcel Holtmann" <marcel@holtmann.org>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, May 8, 2005 3:30 pm, Marcel Holtmann said:

Hey Marcel,

> if you don't put any CG: lines in the commit template you screw up the
> look of the modified files list. So I propose to leave all the CG: lines
> additions as they are in cg-commit and only add the template in front of
> it.

Yes, but you're free to make it look however you like.  Here's a sample:

CG: -[DO NOT COMMIT!]-------------------------------------------
CG:
CG: Hey! You don't want to commit here, use a cloned repository!
CG:


and another:

CG: -[USB CHANGES REPO!]----------------------------------------
CG:
CG: Commit only USB changes here!
CG:

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>
CG:
CG:

The trailing CG: lines ensure that those added by cg-commit look okay.
It's not perfect, but it's a nice feature.

Sean


