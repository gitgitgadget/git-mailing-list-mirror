From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add --dry-run option to git-send-email
Date: Tue, 10 Oct 2006 10:44:59 -0700
Message-ID: <7vslhw12w4.fsf@assigned-by-dhcp.cox.net>
References: <20061010145823.GB8993@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 19:45:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXLfA-0003pG-BA
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 19:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWJJRpE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 13:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWJJRpD
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 13:45:03 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:3470 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751074AbWJJRpA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 13:45:00 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061010174500.UHDX26416.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Oct 2006 13:45:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Yhl21V00n1kojtg0000000
	Tue, 10 Oct 2006 13:45:03 -0400
To: Matthew Wilcox <matthew@wil.cx>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28644>

Matthew Wilcox <matthew@wil.cx> writes:

> Add a --dry-run option to git-send-email due to having made too many
> mistakes with it in the past week.  I like having a safety catch on my
> machine gun.
>
> Signed-off-by: Matthew @ilcox <matthew@wil.cx>

Good.

When I have to look into other people's issues with send-email,
I used to say "--smtp-server=/var/tmp/send" which is this
script:

        #!/bin/sh
        for i
        do
                echo "arg $i"
        done
        sed -e 's/^/Msg: /'

I hope your patch makes the above hack unneeded (I want to see
what is fed to sendmail, what goes on the header and body).
