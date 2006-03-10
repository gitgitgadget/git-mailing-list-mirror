From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: bug?: stgit creates (unneccessary?) conflicts when pulling
Date: Fri, 10 Mar 2006 11:13:41 +0000
Message-ID: <b0943d9e0603100313l37f67f62h@mail.gmail.com>
References: <20060227204252.GA31836@diana.vm.bytemark.co.uk>
	 <20060227222600.GA11797@spearce.org> <tnx1wxmig75.fsf@arm.com>
	 <20060301145105.GB3313@spearce.org>
	 <b0943d9e0603010708l72cb14d1w@mail.gmail.com>
	 <20060301155043.GA3706@spearce.org>
	 <b0943d9e0603091400o2cd0291h@mail.gmail.com>
	 <7vslpr2ojz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Shawn Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 10 12:13:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHfZ4-00021w-AL
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 12:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729AbWCJLNn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 06:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752231AbWCJLNn
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 06:13:43 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:21252 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750820AbWCJLNm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 06:13:42 -0500
Received: by xproxy.gmail.com with SMTP id h29so473430wxd
        for <git@vger.kernel.org>; Fri, 10 Mar 2006 03:13:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GiHiz+tHXBCdpITlvE6iems9SqKVGHqWvKqjOtrdrWrQNxI046Qmum/h7Yq7NDA0F35PeiY0qb30Cdka3pL9eWilqVpHNhv72HBXN0VukFu686Nr+ZmDT6RKJVk2eSNW2N81+EsM+57tL0UgWhmOpRHNpCvMkWexJl6lUM7nBsg=
Received: by 10.70.76.8 with SMTP id y8mr3329919wxa;
        Fri, 10 Mar 2006 03:13:41 -0800 (PST)
Received: by 10.70.31.4 with HTTP; Fri, 10 Mar 2006 03:13:41 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vslpr2ojz.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17470>

On 09/03/06, Junio C Hamano <junkio@cox.net> wrote:
> "Catalin Marinas" <catalin.marinas@gmail.com> writes:
>
> > Trying to implement this, I've just noticed that git-read-tree has a
> > --aggressive option which takes care of the file removals. Adding this
> > option lowered the pushing time in StGIT from ~2 min to under 2
> > seconds (merges between 2.6.14 and the latest kernel). There's
> > probably no need to deal with file removals in pg--merge-all anymore.
>
> Yup, it was originally done to improve the performance of
> resolve merge strategy, but I am glad somebody else has found
> use for it.

Actually, I asked for it about 6 months ago:

http://marc.theaimsgroup.com/?l=git&m=112677889118711&w=2

and I got the reply from you :-):

http://marc.theaimsgroup.com/?l=git&m=112690084826630&w=2

Anyway, it's good we have it, it saved me some time with implementing
Shawn's merging algorithm.

--
Catalin
