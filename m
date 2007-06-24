From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][RESEND] Escape some tilde characters causing spurious subscripts in documentation
Date: Sat, 23 Jun 2007 18:01:36 -0700
Message-ID: <7vhcoy2mj3.fsf@assigned-by-dhcp.cox.net>
References: <11826426733115-git-send-email-jasonsewall@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Jason Sewall <jasonsewall@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 03:01:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2GTz-000346-6P
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 03:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbXFXBBi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 21:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753225AbXFXBBi
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 21:01:38 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:59402 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940AbXFXBBh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 21:01:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070624010137.RFPM6565.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sat, 23 Jun 2007 21:01:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id FD1c1X00C1kojtg0000000; Sat, 23 Jun 2007 21:01:37 -0400
In-Reply-To: <11826426733115-git-send-email-jasonsewall@gmail.com> (Jason
	Sewall's message of "Sat, 23 Jun 2007 16:51:13 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50765>

Jason Sewall <jasonsewall@gmail.com> writes:

> diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
> index 5051e2b..d89f350 100644
> --- a/Documentation/git-bundle.txt
> +++ b/Documentation/git-bundle.txt
> @@ -61,7 +61,7 @@ unbundle <file>::
>  [git-rev-list-args...]::
>         A list of arguments, acceptable to git-rev-parse and
>         git-rev-list, that specify the specific objects and references
> -       to transport.  For example, "master~10..master" causes the
> +       to transport.  For example, "master\~10..master" causes the
>         current master reference to be packaged along with all objects
>         added since its 10th ancestor commit.  There is no explicit
>         limit to the number of references and objects that may be

We seem to have {tilde} defined in Documentation/asciidoc.conf.
I wonder which is better.  We should pick one that gives more
reasonable format, and is less susceptible to differences
between AsciiDoc 7 and 8.
