From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsimport - streamline temp index file creation and avoid creating empty tmpfiles
Date: Sat, 24 Jun 2006 04:28:57 -0700
Message-ID: <7vr71ex05i.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0606231811200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<11511257501323-git-send-email-martin@catalyst.net.nz>
	<Pine.LNX.4.63.0606241145280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vslluyika.fsf@assigned-by-dhcp.cox.net>
	<46a038f90606240416n563288f5q99a5ac81723776c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 13:29:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu6K3-0003DZ-KY
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 13:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbWFXL3A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 07:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbWFXL3A
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 07:29:00 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:12452 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1752219AbWFXL27 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 07:28:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624112858.VTHA12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 07:28:58 -0400
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606240416n563288f5q99a5ac81723776c3@mail.gmail.com>
	(Martin Langhoff's message of "Sat, 24 Jun 2006 23:16:04 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22505>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> Johannes, Junio,
>
> I've managed to repro the problem -- which was totally reproduceable,
> I was just testing the wrong version of the script. The problem was
> quite obvious: when running an incremental, the first head would not
> get the index created properly. Even worse, when forking a new branch,
> the index would be empty too.
>
> Fixed both cases and posted separately.

Thanks.  Will be in "next".
