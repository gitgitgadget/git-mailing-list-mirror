From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz
 origin/frotz"
Date: Sun, 6 Jun 2010 18:46:42 +0200
Message-ID: <20100606164642.GA10104@localhost>
References: <20100605110930.GA10526@localhost>
 <vpqljas5e33.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Peter Rabbitson <ribasushi@cpan.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jun 06 18:47:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLIzx-0002wD-Tr
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 18:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757816Ab0FFQqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 12:46:51 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:57360 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755906Ab0FFQqu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 12:46:50 -0400
Received: by ewy23 with SMTP id 23so225661ewy.1
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=gprFkgf7fWnCEaDV1tIlvAUVE1DmUYEAn1o+QHIydx8=;
        b=P2IeZXr9nkK98HESPx1zWZyF8EjN20E9aB6rhpH0mG8lgvhFB4LjPQpxBPlqxuoQCK
         Py9h0ufOA9F45+7Uu+T7tWuARuuF8OVVqRNeQ54MTlmTCPslskfBHmd+n4TvQASXmohH
         T0VMH9K9MhkWKC68I0Smen66lv2RmPtbkW1lU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=Tg1sls/wl9fAevU4yYzLyfR1PSs1Awo3bUndU0f18TO1M6x6HBKzCRz/j09xNGTrGB
         BQDbaS0D3tiRiCFwckl3UYrLcq9Uo/nRcVoHeZPTETgpw6bP+s7xV9mI1Ck2FHSYzFR3
         mtqzoxq/G6FjK7Jr+GRdI2Nf8djaUehmW+Krw=
Received: by 10.213.31.140 with SMTP id y12mr346265ebc.26.1275842808403;
        Sun, 06 Jun 2010 09:46:48 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id 13sm2086569ewy.5.2010.06.06.09.46.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Jun 2010 09:46:46 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OLIzj-0002fA-0R; Sun, 06 Jun 2010 18:46:43 +0200
Content-Disposition: inline
In-Reply-To: <vpqljas5e33.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148525>

On Sun, Jun 06, 2010 at 06:18:56PM +0200, Matthieu Moy wrote:

> $ git clone git://git.kernel.org/pub/scm/git/git.git
> $ cd git
> $ git checkout next
> error: pathspec 'next' did not match any file(s) known to git.
> To create a local branch from the same named remote branch, use
>   git checkout -b next origin/next
> 
> The newbie does not immediately understand the difference between
> local and remote branches, he's been told about the branch "next", and
> wants to check it out.

That is exactly my point. Trying to read the user's mind is not a
solution to this problem. The user does not even know what they are
doing and will inevitably end up even more confused.

The suggestion above would be perfect. It is an easy and obvious
solution, and the user is even educated about their mistake.
