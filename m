From: Junio C Hamano <junkio@cox.net>
Subject: Re: Replacement for cvs2cl, for generating ChangeLog
Date: Tue, 27 Feb 2007 04:23:38 -0800
Message-ID: <7vzm6zg56d.fsf@assigned-by-dhcp.cox.net>
References: <877iu3q13r.fsf@latte.josefsson.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Simon Josefsson <simon@josefsson.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 13:23:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM1N8-0004Ce-8G
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 13:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933089AbXB0MXl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 07:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933095AbXB0MXk
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 07:23:40 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:41577 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933094AbXB0MXk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 07:23:40 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070227122340.MRCE2394.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 07:23:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UcPf1W0011kojtg0000000; Tue, 27 Feb 2007 07:23:39 -0500
In-Reply-To: <877iu3q13r.fsf@latte.josefsson.org> (Simon Josefsson's message
	of "Tue, 27 Feb 2007 12:41:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40716>

Simon Josefsson <simon@josefsson.org> writes:

> Hi!  I'm considering switching to git for my projects (shishi, gsasl,
> gnutls, libtasn1, opencdk, ...) and I have some questions:
>
> * How do I discard all locally modified or added files?  'cvs upd -C'
>   does some of that, but I've been using a tool 'cvsco' which quickly
>   restore a CVS checkout into a pristine state.

"git reset --hard" (RTFM).

> * Is there a tool that produce ChangeLog files in the GNU format,
>   based on the git logs?  Similar to the 'cvs2cl' tool.  The output
>   should look like:

No, but that should probably be trivial.  I would suggest you
postprocess "git log --pretty --numstat --summary" output, which
is probably the most parsable.
