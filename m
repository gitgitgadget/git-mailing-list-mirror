From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Status of Mac OS/X ports of git and cogito?
Date: Sat, 27 Aug 2005 18:59:02 +1200
Message-ID: <46a038f905082623595c051c0b@mail.gmail.com>
References: <deofnh$jl0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 27 09:00:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8ueo-0006a1-8N
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 08:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbVH0G7F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Aug 2005 02:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbVH0G7F
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Aug 2005 02:59:05 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:44650 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030324AbVH0G7E convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2005 02:59:04 -0400
Received: by rproxy.gmail.com with SMTP id i8so700080rne
        for <git@vger.kernel.org>; Fri, 26 Aug 2005 23:59:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lughrQickY2EQhq/XleHiPZqXjWJ3RCSnv51Ft9F/9kCetBshHr5Np73vLKsmjYq2Wxqxqm6ff6hwvIAclVc4s9RaJ1dP5VvPUfkn+PfIjUi/oDfFKtDgSeq9Flo3vUajeah4jti4CNxQYfWixEva7sDV4zr6rIcYLcTVM9N8CA=
Received: by 10.38.89.9 with SMTP id m9mr2207208rnb;
        Fri, 26 Aug 2005 23:59:02 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Fri, 26 Aug 2005 23:59:02 -0700 (PDT)
To: John Ellson <ellson@research.att.com>
In-Reply-To: <deofnh$jl0$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7843>

I am running git/cogito on MacOSX 10.3.x mostly as a client, and it
works pretty well. My main dev machines are Debian boxes, so the OSX
build is most often just fetching commits and running cg-log. So it's
not very intensive ;)

I get all my build dependencies from Fink, and also get diffutils from
Fink, as the diff included in MacOSX is old/buggy. The one in Fink's
diffutils matches GIT's expectations ;)

There is _one_ bug I've seen with cg-diff and I haven't had time to
fix. On OSX, running cg-diff with no parameters doesn't show anything.
For some reason, it fails to list the files. If you give it the paths
explicitly, it'll give you the appropriate diff.

And there is a problem with gitk too: the tk that I get from fink gets
the panels sizes all wrong for gitk. I doubt this is a bug in gitk
though.

cheers,


martin 

On 8/27/05, John Ellson <ellson@research.att.com> wrote:
> Do git and cogito build easily on Mac OS/X now?   Are there binaries available
> anywhere?
> 
> 
> John
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
