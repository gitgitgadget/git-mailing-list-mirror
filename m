From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [RFC] Use cases for 'git statistics'
Date: Mon, 12 May 2008 15:01:14 +0200
Message-ID: <bd6139dc0805120601k45ab762eq78c7d6a4927059f6@mail.gmail.com>
References: <bd6139dc0805080851y2065bedfsf0f388cfd6d85929@mail.gmail.com>
	 <200805121319.37512.jnareb@gmail.com>
	 <bd6139dc0805120449j874e4b8j21b90f79230e45a7@mail.gmail.com>
	 <200805121440.12836.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"David Symonds" <dsymonds@google.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 15:02:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvXfo-0007hs-73
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 15:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757041AbYELNBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 09:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756439AbYELNBq
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 09:01:46 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:2244 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757283AbYELNBP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 09:01:15 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2297845wfd.4
        for <git@vger.kernel.org>; Mon, 12 May 2008 06:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=G2X+5H9qyHKXJ14FYo+s6QCxLhXPSVezv0QU8G88Cac=;
        b=gzBccGvIbjreIJkne2sWDpHfdoI6uph2kFAJQ+ZvTwyyhSrSH3qtrx5IZTCfoveBGRcPsi+JCl0fomebHR4W6Mf8oUCtgEvQUWt4hMfS7sC42NrD7iszQXfvBF3JKyyXnPAYmLUaVl5nein0kNdHUnBPxsK/9S0KEy1/UwQvDVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=lyilikDIIit9zgBzaVCbjESiIW2sGWWIE4TCnoh6deRGYFg7a4pE+P9CTZKMtlXaHohmWPcNLz1aEMPCX6fqrSNS/QHST86OHGoTWDs0ZAR7Zx7aFbBB1un5VD05g3BTDgYyOi5LrInyPdv2fGAsryHQg8+057qs7Ko3Db77w/0=
Received: by 10.142.163.14 with SMTP id l14mr3259557wfe.110.1210597274999;
        Mon, 12 May 2008 06:01:14 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Mon, 12 May 2008 06:01:14 -0700 (PDT)
In-Reply-To: <200805121440.12836.jnareb@gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: fc6c4ac51c967dee
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81858>

On Mon, May 12, 2008 at 2:40 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>  This is, IMHO, the most complex example (at least to do properly).
>  It begins with: does given author have code touching given subsystem
>  (i.e. is it for him/her new contribution wrt. subsystem)? How many
>  commits he/she has affecting given subsystem? How often he/she rewrites
>  code? How many bugs were introduced?

Ah, there is a lot more to this example than I thought. Perhaps this
data could all be shown and then, using some "importance" metric per
item a "grade" can be calculated?

>  Details I think need to be provided by maintainer...
>
>
>  > >  * Contributor: what happened with my code?
>  >
>  > Do you mean a "track my code" like feature? Showing the movement of a
>  > particular piece of code through the code? (Displaying information
>  > like "moved from foo.c to bar.c in commit 0123456789abcd"?)
>
>  I was thinking there about "git blame --reverse".
>
>
>  > >  * Searching where to contribute: what are oldest part of code dealing
>  > >   with error messages (find ancient code)?
>  >
>  > In other words, find the lines with the oldest modification time stamp
>  > from 'git blame'?
>
>  Or find the lines with oldest modification stamp with "die" or "warn",
>  or find which messages are oldest, even if wrapper have changed.
>
>
>  P.S. I wonder how hard to be to plug-in such SCM statistic system
>  into something like project management, see
>   "Joel On Software: Evidence based scheduling" (of programming tasks)
>   http://www.joelonsoftware.com/items/2007/10/26.html
>
>  --
>  Jakub Narebski
>  Poland
>



-- 
Cheers,

Sverre Rabbelier
