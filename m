From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH Cogito] Make use of external editor work like CVS
Date: Sun, 8 May 2005 17:46:48 -0400 (EDT)
Message-ID: <2293.10.10.10.24.1115588808.squirrel@linux1>
References: <20050508152529.GU9495@pasky.ji.cz> 
    <1115566990.9031.108.camel@pegasus> <20050508155656.GV9495@pasky.ji.cz>
     <1115568937.9031.129.camel@pegasus>
    <20050508171209.GX9495@pasky.ji.cz> 
    <1115572667.9031.139.camel@pegasus> <20050508173003.GY9495@pasky.ji.cz>
     <1115574035.9031.145.camel@pegasus>
    <20050508175156.GA9495@pasky.ji.cz>  <1115578658.8949.9.camel@pegasus> 
    <20050508200334.GG9495@pasky.ji.cz>
    <1115584015.8949.43.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Petr Baudis" <pasky@ucw.cz>,
	"GIT Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 23:40:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUtV1-0000ib-C9
	for gcvg-git@gmane.org; Sun, 08 May 2005 23:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262989AbVEHVqu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 17:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262995AbVEHVqu
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 17:46:50 -0400
Received: from simmts12.bellnexxia.net ([206.47.199.141]:40624 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262989AbVEHVqt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 17:46:49 -0400
Received: from linux1 ([69.156.111.46]) by simmts12-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050508214648.NXEX1542.simmts12-srv.bellnexxia.net@linux1>;
          Sun, 8 May 2005 17:46:48 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j48LkjLg029668;
	Sun, 8 May 2005 17:46:45 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sun, 8 May 2005 17:46:48 -0400 (EDT)
In-Reply-To: <1115584015.8949.43.camel@pegasus>
To: "Marcel Holtmann" <marcel@holtmann.org>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, May 8, 2005 4:26 pm, Marcel Holtmann said:

> /*
>  * Remove empty lines from the beginning and end.
>  *
>  * Turn multiple consecutive empty lines into just one
>  * empty line.
>  */

sed ' 1{:a;s/^[ \t]*$//;T;N;s/\n//;ta}
      /^[ \t]*$/{:b;$d;N;s/\n[ \t]*$//;tb}'  filename

There's probably shorter... but it's mothers day.. time to go!

Cheers,
Sean


