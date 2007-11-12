From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Cloning from kernel.org, then switching to another repo
Date: Mon, 12 Nov 2007 12:21:20 -0500
Message-ID: <9e4733910711120921q651208cby1276426ccd4b5fa4@mail.gmail.com>
References: <9e4733910711120557w62a9966bvb61a02a2bf9b99e9@mail.gmail.com>
	 <Pine.LNX.4.64.0711121412410.4362@racer.site>
	 <9e4733910711120736g31e3e84cx5a213afc4b889de7@mail.gmail.com>
	 <Pine.LNX.4.64.0711121613570.4362@racer.site>
	 <9e4733910711120822x18019fe6v40eb8ee0e48282dd@mail.gmail.com>
	 <Pine.LNX.4.64.0711121635130.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 18:21:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ircyh-0005j3-Io
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 18:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755116AbXKLRVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 12:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754140AbXKLRVY
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 12:21:24 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:29346 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753812AbXKLRVX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 12:21:23 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1598076wah
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 09:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RSCGvFzxXpyKNm1/v0VaP42LjwF3dAmcQkrV7cRO8Ec=;
        b=QKPhIDqdk6028AhygiDD99dYVQVvs7CZ8Jx5jPRqqIGrUAeCgZR8G2ymbeMPou/EG1VVaVrOBnpE+3OOm7YDskiytxAzTL81yfdq31bl15ulDXOMfwk+iDoxkFvYpj16HoVX+udlp0PzokqR8PzfulfsqwnjXmESa2t+1C9qPUE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y6VYGmUM8REBqrRD2I0yjiKFCXf9SwKbNH4dHiLlRTpBkbccPk6YAFUkzu7jTzRE1B341U5qtnWPLEUQHXIVRsoG/RbQqsfQ5AVyMiCOKyxCGL0Xg1QrnJVcCf/rwMmYizPM0dMek1ByPvrlRKvM+x2i4alaLntYuWPYgA9BYF8=
Received: by 10.115.90.1 with SMTP id s1mr130849wal.1194888081017;
        Mon, 12 Nov 2007 09:21:21 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Mon, 12 Nov 2007 09:21:20 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711121635130.4362@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64667>

On 11/12/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 12 Nov 2007, Jon Smirl wrote:
>
> > On 11/12/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > > On Mon, 12 Nov 2007, Jon Smirl wrote:
> > >
> > > > jonsmirl@terra:~/foo$ git clone
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git ds
> > > > clone.....
> > >
> > > This sets up branch.master.{remote,merge} to {origin,master}.
>
> You haven't shown me that this is set correctly in your set up, and if it
> is, when it stops being correctly set up.

Running git update-server-info at the remote end fixed it.

I am using 'git push' to send changes, I though that was supposed to
update the server info automatically.


>
> Ciao,
> Dscho
>


-- 
Jon Smirl
jonsmirl@gmail.com
