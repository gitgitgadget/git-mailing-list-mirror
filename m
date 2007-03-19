From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Libification project (SoC)
Date: Mon, 19 Mar 2007 14:04:47 +0100
Message-ID: <e5bfff550703190604n6360659cl3880ec5b3a9b5042@mail.gmail.com>
References: <20070316042406.7e750ed0@home.brethil>
	 <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de>
	 <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070318140816.GG4489@pasky.or.cz>
	 <Pine.LNX.4.63.0703190045520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070319012111.GS18276@pasky.or.cz>
	 <Pine.LNX.4.63.0703190235330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <e5bfff550703190001k761541c7v2c259ef3f7695b10@mail.gmail.com>
	 <Pine.LNX.4.63.0703191329220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>, "Rocco Rutte" <pdmef@gmx.net>,
	git@vger.kernel.org, tytso@mit.edu, spearce@spearce.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 19 14:05:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTHXq-0004jU-Hk
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 14:05:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933876AbXCSNEu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 09:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933861AbXCSNEu
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 09:04:50 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:27584 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933876AbXCSNEt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 09:04:49 -0400
Received: by wr-out-0506.google.com with SMTP id 41so1416025wry
        for <git@vger.kernel.org>; Mon, 19 Mar 2007 06:04:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=audGi2y99oPMwgGN6F+rGG6huealn9fbLDbcURwgNnqCNT1oh61o111wgSPobNC6XhOlTWqIGYH0sn27ZDYJUdykrsDIprqN2maIsCamSe2Bic92aMDqw71ewTnCkICNh4wWsbjitGvmN6NkwdzGYSuBs98LB1f3s/z0Ja7qziQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kCE8WI7HITPhxqN0i4TOJUSsZJJH2jBGSqSjeSrv6er+uB7OleagqFxDAWC7ZlN1V0UktXv8miaqhUOYRfWsFhfFXvXOUidgO7eft+pRiV4FkM1b+NfGWbbBqmTyaVzUZZi3OpFfRUdnIfsa0dJ3uv7Sa00siurwYzEDwMC+ch4=
Received: by 10.90.51.17 with SMTP id y17mr3840360agy.1174309487254;
        Mon, 19 Mar 2007 06:04:47 -0700 (PDT)
Received: by 10.114.60.16 with HTTP; Mon, 19 Mar 2007 06:04:47 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.63.0703191329220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42614>

On 3/19/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 19 Mar 2007, Marco Costalba wrote:
>
> > On 3/19/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > I don't see _any_ problem in making an API which works with _one_ repo
> > > first. This has several advantages:
> > >
> > > - most users (if any!) will work that way,
> > >
> >
> > Sometime could be useful to write a list of possible users before
> > starting to code.
>
> Fair enough.
>
> I expect the most visible users of libgit to be: the core Git programs!
> Because if we don't eat our own dog food, why should anybody else?
>

But in case you eat your own food, why others should to the same?


> And I am absolutely utterly opposed to make them slower just to support a
> program which wants to cache meta data from multiple repositories.
>

The problem, at least with viewers I know, it's not with multiple
repositories but with multiple  views of the same repo.


Anyway. Just to give my two cent:

The two possible features we are talking about are:

  - reentrancy (many views open on the same repo)

  - non-blocking behaviour (loading repo in background)

These two features are _very_ different. I agree an async library it's
not a small thing, and probably it involves using an external thread
library in libgit itself, like pthread, just to not reinventing the
(difficult) wheel.

Regarding reentrancy I don't know what is involved in avoiding globals
and the like, but I would think it's really an absolute minimum to get
people eating your food ;-)

I completely agree that it's impossible to know how a library will be
used when you write it, but giving a good look around before to start
allows you to get a minimum subset of needed features and if you add a
little bit of generalization and you are lucky enough perhaps you will
avoid to rewrite the library in the future.

>From the viewers survey and also from the interesting examples of
Steve I would say that do not planning for reentarncy would be a big
no-no

  Marco
