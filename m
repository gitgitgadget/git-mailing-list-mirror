From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: configure.ac and friends could use some love
Date: Tue, 02 Jun 2009 03:16:48 -0700 (PDT)
Message-ID: <m3zlcr9c0a.fsf@localhost.localdomain>
References: <1243892495.5366.11.camel@norseth> <4A24C60C.3000600@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "C.J. Adams-Collier" <cjac@colliertech.org>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Jun 02 12:17:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBR3F-0001LM-VM
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 12:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756981AbZFBKQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 06:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756290AbZFBKQu
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 06:16:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:64537 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbZFBKQt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 06:16:49 -0400
Received: by fg-out-1718.google.com with SMTP id d23so780522fga.17
        for <git@vger.kernel.org>; Tue, 02 Jun 2009 03:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=DhpPqVsVy1y97sqXikv6IhHVHpFOYEgeV/51TqBUyKw=;
        b=XCbnkqhJH8BR4KGnhoK70KXgZ7DZ2I72Te2EU1DzIbBdn4gumLjaDHd97FZnlvdoBK
         wwuBoCsqzWgSarozA6DCcz2r3IGXjklz0TSemSt117bjDVQLV+XyHkQb8hWUaYu8zNPa
         SiA8nbsQNwjEsiQeonqZ5fCIrLjF7nUpGA6wc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=HMYbHdvefUZyYcntoQeKTx8apqbLKH1MFCTSNHv4CLYvaycCHhat+7eIkDl0vLl2gX
         yFhwXjJ9UWW3s5u3J3bsjkedQ6lMkO8ly2jsFPBmMCKERY9T2RMD/9O5AX6rfNf2lGph
         YbrdZTKqX57eo0jDbPllZejzu/D6i3bukC9k0=
Received: by 10.86.70.3 with SMTP id s3mr7820922fga.12.1243937810186;
        Tue, 02 Jun 2009 03:16:50 -0700 (PDT)
Received: from localhost.localdomain (abvt75.neoplus.adsl.tpnet.pl [83.8.217.75])
        by mx.google.com with ESMTPS id d4sm13445211fga.14.2009.06.02.03.16.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Jun 2009 03:16:48 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n52AGiTD001805;
	Tue, 2 Jun 2009 12:16:45 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n52AGLZq001796;
	Tue, 2 Jun 2009 12:16:21 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4A24C60C.3000600@op5.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120499>

Andreas Ericsson <ae@op5.se> writes:
> C.J. Adams-Collier wrote:

> > with whom should I co-ordinate?
> >
> 
> git@vger and Jakub Narebski.
> 
>   git shortlog -ns -- configure.ac
> 
> would have told you as much ;-)

While it is true that I was behind adding ./configure support to git
in optional and non-intrusive way (configure.ac and config.mak.in),
mainly to be able to use %configure macro in git.spec -- which never
materialized, I lack in my opinion expertise in autoconf to be
a maintainer for those scripts.

David Syzdek offered to help or take the brunt of the work on our
autoconf corner, see e.g. this post:
  http://article.gmane.org/gmane.comp.version-control.git/111923
but he wanted help of someone whom is familiar with the interaction
between the Makefile and configure.ac... which never materialized.

Instead of git-shortlog, you should take a look at git-blame output
who is responsible for more advanced corners of configure.ac:
David M. Syzydek (GIT_CHECK_FUNC), Ben Walton (GIT_STASH_FLAGS),
Ralf Wildenhues (caching support), etc.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
