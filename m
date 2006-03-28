From: "Yasushi SHOJI" <Yasushi.SHOJI@atmark-techno.com>
Subject: Re: Selecting the minor revs
Date: Wed, 29 Mar 2006 01:01:49 +0900
Message-ID: <f18709460603280801t47772341lcb32ccfd5261e021@mail.gmail.com>
References: <BAYC1-PASMTP12827905B389678EB07BDAAED30@CEZ.ICE>
	 <0e7d01c651fb$fa11ceb0$a100a8c0@casabyte.com>
	 <BAYC1-PASMTP1277D14C35B0D95512243BAED30@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Greg Lee" <glee@swspec.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 28 18:02:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOGdt-0006AS-C1
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 18:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWC1QBv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 11:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWC1QBv
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 11:01:51 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:20620 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750780AbWC1QBu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 11:01:50 -0500
Received: by xproxy.gmail.com with SMTP id t10so1073678wxc
        for <git@vger.kernel.org>; Tue, 28 Mar 2006 08:01:49 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ExibLXnMwgf5REcvjck/w2JGq66IALzo6EeGSvd9NNoOnLcF2/f+R7G/SSr9nLBDp2e6zEJ1hpXBoZR3NHyq7C8vpWo4EdbXl3WC9JJTPscoJq5kHrfUd9cJnMZwydj8E3Ckdcfs3qk2kmApGR0dMXBQ6LBtvC+0pcDcsajTln8=
Received: by 10.70.113.3 with SMTP id l3mr6605426wxc;
        Tue, 28 Mar 2006 08:01:49 -0800 (PST)
Received: by 10.70.78.1 with HTTP; Tue, 28 Mar 2006 08:01:49 -0800 (PST)
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP1277D14C35B0D95512243BAED30@CEZ.ICE>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18125>

On 3/28/06, sean <seanlkml@sympatico.ca> wrote:
> On Mon, 27 Mar 2006 19:10:09 -0500
> "Greg Lee" <glee@swspec.com> wrote:
>
> > > If you're interested in the stable-series releases of the
> > > kernel, unfortunately they're not in the git repository.
> >
> > As I feared ... I'm curious, why?
>
> Because the stable-series is maintained by people other than Linus.
>
> They may have their own git tree, i'm not sure.  Even if they don't,
> you could create a stable-series branch and import the patches
> into your git repo if it was something you needed often.

they do.  and you can just do, ie for 2.6.15.y

    git fetch git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.15.y.git
master:v2.6.15.y

you might wanna use --tags for fetch.  see git-fetch(1) for more detail.

see http://kernel.org/git/ for other stable branches.  and thanks for
stable branch maintainers.
--
       yashi
