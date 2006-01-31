From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: git-http-fetch failure/segfault -- alas no patch
Date: Tue, 31 Jan 2006 10:32:00 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060131093200.GA5154@informatik.uni-freiburg.de>
References: <17374.30792.548889.344768@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 10:32:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3rrs-0002Wp-1g
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 10:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWAaJcF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 04:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWAaJcE
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 04:32:04 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:10370 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1750730AbWAaJcC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 04:32:02 -0500
Received: from juno.informatik.uni-freiburg.de ([132.230.151.45])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1F3rrl-0006pO-IP; Tue, 31 Jan 2006 10:32:01 +0100
Received: from juno.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11) with ESMTP id k0V9W1ot005377;
	Tue, 31 Jan 2006 10:32:01 +0100 (MET)
Received: (from zeisberg@localhost)
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11/Submit) id k0V9W01T005376;
	Tue, 31 Jan 2006 10:32:00 +0100 (MET)
To: Mark Wooding <mdw@distorted.org.uk>
Mail-Followup-To: Mark Wooding <mdw@distorted.org.uk>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <17374.30792.548889.344768@metalzone.distorted.org.uk>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15306>

Hello,

Mark Wooding wrote:
> (Yes, that repository exists and is live; the server is fairly
> well-connected.  FWIW, I've put up a tarball of the repository called
> .../funt.git.tar.gz too.)  You ought to be greeted with text like this:
> 
>   error: Unable to find b4f495485ca9ae825ec8c504cdcf24652342f43c under
>   http://boyle.nsict.org/~mdw/funt/.git/
> 
>   Cannot obtain needed commit b4f495485ca9ae825ec8c504cdcf24652342f43c
>   while processing commit 351c72525b9ee5b2321c65598ce82a4e79015012.
> 
> If you're very lucky, git-http-fetch will segfault.
I have the same problem here with an other http repo.  I just finished
bisecting when i got your mail.

The offending commit is 056211053b7516a57ff7a6dd02f503ecef6fca70:

git-clone: do not special case dumb http.

Best regards
Uwe


-- 
Uwe Zeisberger

primes where sieve (p:xs) = [ x | x<-xs, x `rem` p /= 0 ]; \
primes = map head (iterate sieve [2..])
