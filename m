From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Potential bug in gitweb 1.7.2
Date: Mon, 26 Jul 2010 10:23:56 -0500
Message-ID: <20100726152356.GA6564@burratino>
References: <4C4D152A.7050505@gmail.com>
 <20100726050849.GA16858@burratino>
 <alpine.DEB.2.00.1007260508290.14251@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: julio.lajara@alum.rpi.edu, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Jul 26 17:25:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdPYK-0007le-FD
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 17:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575Ab0GZPZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 11:25:09 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54947 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753651Ab0GZPZI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 11:25:08 -0400
Received: by wwj40 with SMTP id 40so279581wwj.1
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 08:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=hQ6g1Vx4LDaAS54W+6JSrVMe/uv6jKn8+oboqJJUnhE=;
        b=wVgK8gR1QdipWTw0SN6ga24uqQ3whA9D6mU/U+95Fs/ixj3O+0Td+WsjMSZ5lz2aMg
         GL4UOw4aO78LL5QyrrirTG52AgOIe0qEJl4xZg2XjsYVsoSdGME1pV+3kWwBF4TjNvK5
         K24+WKK7uK2R+CdYOrsNjtO/DUcPCe1oTqDMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=t8Je4/ESc6UNLCz2GsrDCLgomrZBk7qISrZrsJZCEcBQ7rp7Rn8yUjO4vborAhdaap
         SD/ZZsoFw7bLUPvyedgnuLTzRagjVZJ4lBE30QjXvnWEJ2kYMLaeZFtu91I18Clb4Edu
         lSrFSKnl+qDEZ+LTdN+6lhHmrW3a8rDIkRDWA=
Received: by 10.227.138.72 with SMTP id z8mr5960535wbt.187.1280157906984;
        Mon, 26 Jul 2010 08:25:06 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p45sm1997755weq.45.2010.07.26.08.25.04
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 08:25:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1007260508290.14251@dr-wily.mit.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151845>

Hi Anders,

Anders Kaseorg wrote:

> the 1.7.2-0ppa1 package in the git-core PPA 
> was constructed by merging your jrn/for-gerrit branch (1.7.2~rc3-0.1, 
> commit f84e1eb) with upstream v1.7.2, and updating 
> debian/versions.upstream and debian/changelog.upstream.  It already 
> includes that commit.

Good to know.  Is there a public git repository for the PPA?  (I am
asking selfishly, because it would be convenient to be able to tell
what commit each version corresponds to and to steal changes
back.)

> Indeed, when I install the gitweb 1.7.2-0ppa1 package, put some 
> repositories into /var/cache/git, and go to http://localhost/gitweb/ , it 
> works correctly for me.

Hm, I should have tried that myself.

Thanks.
