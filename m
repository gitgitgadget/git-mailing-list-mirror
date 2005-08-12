From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [OT?] git tools at SourceForge ?
Date: Sat, 13 Aug 2005 11:17:57 +1200
Message-ID: <46a038f90508121617560d00c@mail.gmail.com>
References: <20050812190739.AC222352633@atlas.denx.de>
	 <Pine.LNX.4.63.0508121634570.12816@iabervon.org>
	 <Pine.LNX.4.58.0508121513530.3295@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Wolfgang Denk <wd@denx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 01:18:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3imn-0003PN-52
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 01:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbVHLXR6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 19:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVHLXR6
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 19:17:58 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:51734 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751303AbVHLXR5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 19:17:57 -0400
Received: by rproxy.gmail.com with SMTP id i8so526109rne
        for <git@vger.kernel.org>; Fri, 12 Aug 2005 16:17:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lP2cpAL4CdjjsP2qdYWpCNHFd9RISXu01cbOr2zGqz6YdSvTiQXhKLjNiYsL8vRc4Gwzri0IJ26+O1AYX7Tvt6NUAwa50/ENL6VwFT7kggDhE/sN2FDnc1Itn2+nM6Ke3V0RIZo+GaQiogd9ixx+WsiQbZWHYdkRkpfSNl7cMBU=
Received: by 10.38.104.22 with SMTP id b22mr1164179rnc;
        Fri, 12 Aug 2005 16:17:57 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Fri, 12 Aug 2005 16:17:57 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508121513530.3295@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>  - the git architecture is admirably suited to an _untrusted_ central
>    server, ie exactly the SourceForge kind of setup. I realize that the

Definitely. And beyond that too. Using SF for CVS means that when SF's
CVS service is down (often enough) you can't commit (or even fscking
diff) until they are back up. Every single damn operation does a
roundtrip. This also means a huge load on their servers.

I'm sure SF will be glad to see CVS fall our of favour.

>    Yes, developers can just merge with each other directly

I take it that you mean an exchange of patches that does not depend on
having public repos. What are the mechanisms available on that front,
other than patchbombs?

>    This is _exactly_ where something like SF really ends up being helpful.
>    It's a _hosting_ service, and git is eminently suitable to being

Not sure whether SF is offering rsync, but they do support hosting of
arbitrarty data -- and a project using GIT can use that to host
several developer trees . It'd be nice if SF offered gitweb and
similar niceties. As my usage of GIT increases, I may add support for
it on Eduforge.org

If I had more (hw/time) resources I'd do the git proxying of CVS
projects, but that's huge.

> And so I'd be thrilled to have some site like SF support it.

Eduforge's charter is to host education-related projects, so that's
not a free-for-all-comers, but I'm considering git support, as our
usage of git is growing.

cheers,



martin
