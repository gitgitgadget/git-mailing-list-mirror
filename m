From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Merges without bases
Date: Fri, 26 Aug 2005 21:17:03 +1200
Message-ID: <46a038f905082602176f9eef5d@mail.gmail.com>
References: <1125004228.4110.20.camel@localhost.localdomain>
	 <7vvf1tps9v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Darrin Thompson <darrint@progeny.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 11:17:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8aKu-0003cm-Kn
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 11:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbVHZJRF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 05:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbVHZJRF
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 05:17:05 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:44161 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751235AbVHZJRE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 05:17:04 -0400
Received: by rproxy.gmail.com with SMTP id i8so531182rne
        for <git@vger.kernel.org>; Fri, 26 Aug 2005 02:17:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mt8PKRen/IPvjkPnaiCXtXlOLhUyXWqTy3DhL3cC00M/ITF0MT5vokuXe+lTGRITX2KgT4kfCl1q2A0fSMiEIWFAilrJkRv3vT+ilV0/oOlMEuACEgxKOqrdihFleilSZqF8btsyuvlYyWJBoqbzD6GkjosrFQTkFZBcBXdYI10=
Received: by 10.38.92.14 with SMTP id p14mr1636262rnb;
        Fri, 26 Aug 2005 02:17:03 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Fri, 26 Aug 2005 02:17:03 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf1tps9v.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7795>

On 8/26/05, Junio C Hamano <junkio@cox.net> wrote:
> their core GIT tools come from.  But how would _I_ pull from
> that "My Project", if I did not want to pull unrelated stuff in?

and then... 

> What I think _might_ deserve a bit more support would be a merge
> of a foreign project as a subdirectory of a project.  Linus

tla has an interesting implementation (and horrible name) for
something like this. In Arch-speak, they are called 'configurations',
a versioned control file that describes that in subdirectory foo we
import from this other repo#branch.

In cvs, you just do nested checkouts, and trust a `cvs update` done at
the top will do the right thing;  and in fact recent cvs versions do.

After using cvs and arch for a while, my opinion is that all this
stuff is _bad_, and you want a makefile that pulls the projects
together when you build them. Different projects are going to use
different SCMs anyway, and you'll have to live with how to tag a
release across repositories/scms, and I haven't seen any answer I
like.

cheers,


martin
