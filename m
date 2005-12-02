From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: git pull aborts in 50% of cases
Date: Sat, 3 Dec 2005 00:12:50 +0300
Message-ID: <20051202211250.GA11384@mipter.zuzino.mipt.ru>
References: <20051202190412.GA10757@mipter.zuzino.mipt.ru> <43909963.60901@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 22:00:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiHyi-00023h-QM
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 21:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVLBU56 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 15:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbVLBU56
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 15:57:58 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:745 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750749AbVLBU55 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Dec 2005 15:57:57 -0500
Received: by nproxy.gmail.com with SMTP id o25so224093nfa
        for <git@vger.kernel.org>; Fri, 02 Dec 2005 12:57:56 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=OcAjq05qlOBrrbsCeQIeYIJnS3rfbVy9DthDzk+QitfV1MguHsq4frbeMvSfS2Z7TVuUV5JHXS1qqfA8vZ7yUVVLaS81kZQI/w8y2/FsvJyKxlhX5g+XbRxd5vO4l3KbJSEfvwaS76dOAhY0OPzJNpa3yGiYF07Hg3bGz5js9Z8=
Received: by 10.49.2.14 with SMTP id e14mr130748nfi;
        Fri, 02 Dec 2005 12:57:56 -0800 (PST)
Received: from gmail.com ( [217.10.38.130])
        by mx.gmail.com with ESMTP id y23sm1021162nfb.2005.12.02.12.57.54;
        Fri, 02 Dec 2005 12:57:55 -0800 (PST)
Received: by gmail.com (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	adobriyan@gmail.com; Sat,  3 Dec 2005 00:12:52 +0300 (MSK)
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <43909963.60901@zytor.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13125>

On Fri, Dec 02, 2005 at 10:58:43AM -0800, H. Peter Anvin wrote:
> Alexey Dobriyan wrote:
> >$ git pull
> >Already up-to-date.
> >$ git pull
> >Already up-to-date.
> >$ git pull
> >Already up-to-date.
> >$ git pull
> >fatal: unexpected EOF
> >Fetch failure: git://git.kernel.org/pub/scm/git/git.git
> >$ git pull
> >fatal: unexpected EOF
> >Fetch failure: git://git.kernel.org/pub/scm/git/git.git
> >$ git pull
> >Already up-to-date.
> >$ git pull
> >fatal: unexpected EOF
> >Fetch failure: git://git.kernel.org/pub/scm/git/git.git
> >$ git pull
> >fatal: unexpected EOF
> >Fetch failure: git://git.kernel.org/pub/scm/git/git.git
> >
> >Ditto for "git fetch --tags".
> >
> >Can somebody explain what's going on?
> >
>
> Do you know which IP address is aborting?  There are two servers behind
> git.kernel.org.

Heisenbug :-\. I'll send IP next time.

~/linux/linux-linus $ while true; do git pull; done
Already up-to-date.
Already up-to-date.
Already up-to-date.
Already up-to-date.
Already up-to-date.
Already up-to-date.
Already up-to-date.
Already up-to-date.
Already up-to-date.
Already up-to-date.
Already up-to-date.
