From: Junio C Hamano <junkio@cox.net>
Subject: Re: (patch) calloc->xaclloc in read-cache.c
Date: Tue, 09 May 2006 06:26:59 -0700
Message-ID: <7vpsin5nx8.fsf@assigned-by-dhcp.cox.net>
References: <0IZ000KI11YCKL10@mxout4.netvision.net.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 15:27:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdSF8-0000uv-AY
	for gcvg-git@gmane.org; Tue, 09 May 2006 15:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWEIN1E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 09:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbWEIN1E
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 09:27:04 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:59549 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932513AbWEIN1C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 May 2006 09:27:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060509132701.ENLU27327.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 9 May 2006 09:27:01 -0400
To: iler.ml@gmail.com
In-Reply-To: <0IZ000KI11YCKL10@mxout4.netvision.net.il> (iler ml's message of
	"Tue, 09 May 2006 16:14 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19839>

iler.ml@gmail.com writes:

> How about this.

Looks good, thanks.  If you needed some MUA trick that other
people might benefit from please feel free to send a patch to
Documentation/SubmittingPatches "MUA specific hints" section.

Except "Subject: [PATCH] blah", commit log message (in this case
what you would have on the Subject line is to the point and you
would not need any extra log message), "Signed-off-by: whom",
and perhaps "---\n".  Material that you do not want to have in
the final commit message, like "How about this" and diffstat if
you have one, would come after the "---\n" line.

Your message formatted in the preferred way becomes like this:

	Subject: [PATCH] read-cache.c: use xcalloc() not calloc()

	Elsewhere we use xcalloc(); we should consistently do so.

        Signed-off-by: Yakov Lerner <iler.ml@gmail.com>
	---

        * How about this?

         read-cache.c |    2 +-
         1 files changed, 1 insertions(+), 1 deletions(-)

        --- read-cache.c.000	2006-05-09 15:27:56.000000000 +0000
        +++ read-cache.c	2006-05-09 15:28:10.000000000 +0000
        @@ -552,7 +552,7 @@

                active_nr = ntohl(hdr->hdr_entries);
	...
