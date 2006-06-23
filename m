From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Tracking CVS
Date: Thu, 22 Jun 2006 22:24:16 -0400
Message-ID: <9e4733910606221924v69d71e59y8246925ad92aeba3@mail.gmail.com>
References: <9e4733910606220541y15d66fa6t33ab0c80ae05f764@mail.gmail.com>
	 <20060622135831.GB21864@pasky.or.cz>
	 <9e4733910606221918r775f49f0l4929f4703281115f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 23 04:24:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtbLI-0000Lz-VJ
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 04:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWFWCYT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 22:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWFWCYT
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 22:24:19 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:31878 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750831AbWFWCYS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 22:24:18 -0400
Received: by nz-out-0102.google.com with SMTP id l1so649911nzf
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 19:24:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=koZvR90UtFFWuZAfhHE4OogLjn2L8IafXpVp9yoXATw9VZ8co0zsjrzJ+kt6MG6UtgYPfrgPKSlM2p9KMM4iFlt8qkplwlSbqLkCcISML7KtqhsWvWQ5i5lTSZGp12yBrUVjFxgxG1wZnxZsTe6rQp7iTY8Ukb5AG6qWoE39KnE=
Received: by 10.36.135.5 with SMTP id i5mr2989376nzd;
        Thu, 22 Jun 2006 19:24:16 -0700 (PDT)
Received: by 10.36.37.5 with HTTP; Thu, 22 Jun 2006 19:24:16 -0700 (PDT)
To: "Petr Baudis" <pasky@suse.cz>
In-Reply-To: <9e4733910606221918r775f49f0l4929f4703281115f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22393>

On 6/22/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> > I think the most straightforward way is:
> >
> >         cvs update
> >         cg-rm -a
> >         cg-status -wns \? | xargs cg-add
> >         cg-commit
>
> This doesn't pick up new directories with recursion.

The new directories that came down were empty.

-- 
Jon Smirl
jonsmirl@gmail.com
