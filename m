From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Reporting bugs and bisection
Date: Wed, 16 Apr 2008 21:39:41 +0200
Message-ID: <bd6139dc0804161239h17e79c70ta5e938619e5743c9@mail.gmail.com>
References: <20080413205406.GA9190@2ka.mipt.ru>
	 <alpine.DEB.1.10.0804131546370.9318@asgard>
	 <20080414043939.GA6862@1wt.eu>
	 <20080414053943.GU9785@ZenIV.linux.org.uk>
	 <20080413232441.e216a02c.akpm@linux-foundation.org>
	 <20080414072328.GW9785@ZenIV.linux.org.uk>
	 <Xine.LNX.4.64.0804150131300.4160@us.intercode.com.au>
	 <4804765B.2070300@davidnewall.com>
	 <bd6139dc0804160515s64a36748v49556c56d475dda4@mail.gmail.com>
	 <20080416132634.GA545@cs181133002.pp.htv.fi>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	"James Morris" <jmorris@namei.org>,
	"Al Viro" <viro@zeniv.linux.org.uk>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Willy Tarreau" <w@1wt.eu>, david@lang.hm,
	"Stephen Clark" <sclark46@earthlink.net>,
	"Evgeniy Polyakov" <johnpol@2ka.mipt.ru>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	"Tilman Schmidt" <tilman@imap.cc>, Valdis.Kletnieks@vt.edu,
	"Mark Lord" <lkml@rtr.ca>, "David Miller" <davem@davemloft.net>,
	jesper.juhl@gmail.com, yoshfuji@linux-ipv6.org, jeff@garzik.org,
	netdev@vger.kernel.org, "David Newall" <davidn@davidnewall.com>
To: "Adrian Bunk" <bunk@kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 16 21:48:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmDUc-0002Cd-Tk
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 21:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbYDPTjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 15:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbYDPTjo
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 15:39:44 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:33254 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbYDPTjm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 15:39:42 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2537615wff.4
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 12:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YgZgsXM7DhkMZNjTQUpv78+W20J49OQDQQQNWRVDDeI=;
        b=cg8oud+t6yrg2UdntPnRTKnAVIaPXYjontZywDnIZhH561dmTKgTzi8saNR1sGMLVAqZrX9O2i4IT+/cjkNGBOr7jPTkNpzwyqhCACWmzZcF4P4rHSptCkzZtuUc+RWjkiwLArNM73VUm8G8qB6czVOPcfexgSz88kEQnzDf0Nk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VP3K+EjK+WBVDTceAEywVBorxjGTfSLU4XOhp2F6axzKhWEp3GiLD6lnrtRuhF/awV7eOxmYa+1p291iyXvyX6t7oTWJ8SiEbQeJnDenTIZk187PGEeQVtpTm6vfYPwRGEJSoXUYIwZ4nSj174iQdu2P5W8IHB1HBRHCapmWCDQ=
Received: by 10.142.134.20 with SMTP id h20mr114806wfd.188.1208374781781;
        Wed, 16 Apr 2008 12:39:41 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Wed, 16 Apr 2008 12:39:41 -0700 (PDT)
In-Reply-To: <20080416132634.GA545@cs181133002.pp.htv.fi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79731>

On Wed, Apr 16, 2008 at 3:26 PM, Adrian Bunk <bunk@kernel.org> wrote:
> On Wed, Apr 16, 2008 at 02:15:22PM +0200, Sverre Rabbelier wrote:
>  At least with the data we have currently in git it's impossible to
>  figure that out automatically.

I don't quite agree, as I explained in my proposal there are several
ways to detect that a commit was a bugfix. From thereon you can deduct
that if it was a bugfix, that the commit that introduced the fixed
change was a bug! From thereon you can start sifting and get more
confirmations. Junio has made several suggestions as to how this could
be implemented and I'm confident that and algorithm can be devised
that is at least capable of 'guessing' what type a commit is. Aside
from the guessing part I think a lot of information can be gathered
from commit msgs.

Of course, some commits might not be able to be typed (as there might
not be any 'follow up' information on them). Those commits can be
marked as 'unknown' and be ignored. Agreed, should all commits be
'unknown' then the command wouldn't be very useful, but especially on
large repos there is a very large dataset. As the size of the dataset
increases I estimate that the correlation between commits increases
(less commits that add new code which then is never changed
therafter). The higher the degree of correlation between individual
commits the more we can determine about the nature of a commit.


>  E.g. if you look at commit f743d04dcfbeda7439b78802d35305781999aa11
>  (ide/legacy/q40ide.c: add MODULE_LICENSE), how could you determine
>  automatically that it is a bugfix, and the commit that introduced
>  the bug?

Well, a dead giveaway would be:
"http://bugzilla.kernel.org/show_bug.cgi?id=10124"

>  You can always get some data, but if you want to get usable statistics
>  you need explicit tags in the commits, not some algorithm that tries
>  to guess.

As said above, I don't agree, you can 'guess' very reliably on a large
dataset. Also, most commits are already 'tagged' in some way or
another. The trick is to find the pattern in this tagging and use it.

I hope this clears things up a bit,

Cheers,

Sverre Rabbelier
