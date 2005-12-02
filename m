From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: minor problems in git.c
Date: Fri, 2 Dec 2005 09:12:05 +0100
Message-ID: <81b0412b0512020012m3bfbfe9fka1f412d70b2255d0@mail.gmail.com>
References: <72499e3b0512010400i1de76ed2la22cd745f811007f@mail.gmail.com>
	 <81b0412b0512010448u7fcdddacnd7de5df217ab3ca@mail.gmail.com>
	 <20051201135113.GW8383MdfPADPa@greensroom.kotnet.org>
	 <81b0412b0512010602l63ecev1ba03fb90d06e071@mail.gmail.com>
	 <7v1x0wb936.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 09:12:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ei61c-0000EN-4Y
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 09:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbVLBIMI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 03:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbVLBIMI
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 03:12:08 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:40824 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751755AbVLBIMH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 2 Dec 2005 03:12:07 -0500
Received: by nproxy.gmail.com with SMTP id o25so155656nfa
        for <git@vger.kernel.org>; Fri, 02 Dec 2005 00:12:06 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YeJ4ttAQe+tj7+ww7ZauuuIre1HMQcxLzwx5O940vz+lDm8+XstO9f2xh71TYw0Id2ZbSu/GlBGu0+gZmFU7yzSmFdnQmwDojiUJWJabUOtgIDWFG5AqrUjNt7m3de6kjx72b36rMhXpICfr8pytRbDM4U/M0COOVKTOa6ZDTZ0=
Received: by 10.48.246.18 with SMTP id t18mr44370nfh;
        Fri, 02 Dec 2005 00:12:05 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Fri, 2 Dec 2005 00:12:05 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x0wb936.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13103>

On 12/2/05, Junio C Hamano <junkio@cox.net> wrote:
> >> Shouldn't you check the return value of snprintf
> >
> > Probably. For the case where length of a git-command-name +
> > --exec-prefix together are longer than PATH_MAX.
>
> Combined, something like this.

Thanks!
