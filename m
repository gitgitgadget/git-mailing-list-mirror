From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [patch 11/15] no-hstrerror.patch
Date: Sun, 25 Apr 2010 03:39:40 -0500 (CDT)
Message-ID: <20100316085731.GE26540@thor.il.thewrittenword.com>
References: <20100316054220.075676000@mlists.thewrittenword.com>
 <20100316054352.704479000@mlists.thewrittenword.com>
 <7veijkn2yo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 10:40:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5xOB-0007Yx-TJ
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 10:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368Ab0DYIjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 04:39:41 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:57928 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287Ab0DYIjl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 04:39:41 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id B55F75CED
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 09:00:42 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com B55F75CED
Received: from localhost.localdomain (unknown [192.168.1.254])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 74C45A77
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 08:39:40 +0000 (UTC)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 2808857C; Sun, 25 Apr 2010 03:39:40 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <7veijkn2yo.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145730>

On Tue, Mar 16, 2010 at 12:24:47AM -0700, Junio C Hamano wrote:
> "Gary V. Vaughan" <git@mlists.thewrittenword.com> writes:
> > @@ -526,11 +526,22 @@ test -n "$NEEDS_SOCKET" && LIBS="$LIBS -
> >  
> >  #
> >  # Define NEEDS_RESOLV if linking with -lnsl and/or -lsocket is not enough.
> > -# Notably on Solaris hstrerror resides in libresolv and on Solaris 7
> > -# inet_ntop and inet_pton additionally reside there.
> > -AC_CHECK_LIB([c], [hstrerror],
> > +# Notably on Solaris 7 inet_ntop and inet_pton additionally reside there.
> 
> You lost the thing they are "additional" to, so this needs a bit of
> rewording?

I did that to minimise the changes in this patch.  no-inet_ntop.patch
rewrites the inet_ntop test and deletes the incomplete comment line
too.

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
