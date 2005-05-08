From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH Cogito] Make use of external editor work like CVS
Date: Sun, 8 May 2005 11:24:52 -0400 (EDT)
Message-ID: <1590.10.10.10.24.1115565892.squirrel@linux1>
References: <1115564550.9031.96.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Petr Baudis" <pasky@ucw.cz>,
	"GIT Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 17:18:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUnXV-0003kN-4u
	for gcvg-git@gmane.org; Sun, 08 May 2005 17:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbVEHPYz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 11:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbVEHPYz
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 11:24:55 -0400
Received: from simmts12.bellnexxia.net ([206.47.199.141]:64423 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262883AbVEHPYy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 11:24:54 -0400
Received: from linux1 ([69.156.111.46]) by simmts12-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050508152453.MKIK1542.simmts12-srv.bellnexxia.net@linux1>;
          Sun, 8 May 2005 11:24:53 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j48FOnp2025854;
	Sun, 8 May 2005 11:24:50 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sun, 8 May 2005 11:24:52 -0400 (EDT)
In-Reply-To: <1115564550.9031.96.camel@pegasus>
To: "Marcel Holtmann" <marcel@holtmann.org>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, May 8, 2005 11:02 am, Marcel Holtmann said:
> Hi Petr,
>
> this is a modified version of my patch that integrates the your latest
> modifications to cg-commit and also fixes the cleanup of the temporary
> files when we abort the operation.
>

Hi Marcel,

What do you think about providing a per-repository commit template?  So,
if say ".git/commit.form" exists, use it instead of the default?

At a minimum, it would be nice to include a reminder about adding a
"Signed-off-by:" line.

Sean


