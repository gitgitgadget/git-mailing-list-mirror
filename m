From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Cloning from kernel.org, then switching to another repo
Date: Mon, 12 Nov 2007 11:22:41 -0500
Message-ID: <9e4733910711120822x18019fe6v40eb8ee0e48282dd@mail.gmail.com>
References: <9e4733910711120557w62a9966bvb61a02a2bf9b99e9@mail.gmail.com>
	 <Pine.LNX.4.64.0711121412410.4362@racer.site>
	 <9e4733910711120736g31e3e84cx5a213afc4b889de7@mail.gmail.com>
	 <Pine.LNX.4.64.0711121613570.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 17:23:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irc3v-0008F3-3T
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 17:22:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980AbXKLQWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 11:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752737AbXKLQWn
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 11:22:43 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:29138 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbXKLQWn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 11:22:43 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1579279wah
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 08:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=nS5aNPc6moucR+t6+9ADat3/TnuT+fh4pPlTDUhELkc=;
        b=aCaizhh8TvoIcYsnUO7PR/56x0x/7BnRo30Y0ccdI8YGDOPDBG7/bc/ka0zE14mAQ2zFznhWtIlCbdd4W7XzYDs+DcTTURQPKNifVFtcv0pyTdEo4WbJ4/WsOlHgMBrj46I2EUg9Qn3J/J94s18mhqHc8nA1sOb1QdtzaCaiIeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Kt3j1hSvnec3mVjvEJnL3z61nT7nQKsT+g1WYmOfHJw5OKnf4ijPrRCxTNVea6IqfoV/+T5oYmdWLe2/5mAE/D7Kjwei8tD1IuydV1m/VqWeuK0YcSD7kuF2ClmQjg1/DcLNsQYsyNpoBbLnc34FomAAnnxANlTbZwJKRexIzlc=
Received: by 10.114.184.7 with SMTP id h7mr854516waf.1194884561571;
        Mon, 12 Nov 2007 08:22:41 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Mon, 12 Nov 2007 08:22:41 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711121613570.4362@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64652>

On 11/12/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 12 Nov 2007, Jon Smirl wrote:
>
> > On 11/12/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > > On Mon, 12 Nov 2007, Jon Smirl wrote:
> > >
> > > > git clone linus
> > > > move origin to digispeaker.git
> > >
> > > AKA "git config remote.origin.url <your-digispeaker-url-here>"
> >
> > There is more to this:
>
> You must be hiding something.
>
> > jonsmirl@terra:~/foo$ git clone
> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git ds
> > clone.....
>
> This sets up branch.master.{remote,merge} to {origin,master}.
>
> > jonsmirl@terra:~/foo/ds$ git config remote.origin.url
> > http://git.digispeaker.com/projects/digispeaker-kernel.git
>
> This does not change that setting.

It edited origin:[remote "origin"]
        url = http://git.digispeaker.com/projects/digispeaker-kernel.git
        fetch = +refs/heads/*:refs/remotes/origin/*

> > jonsmirl@terra:~/foo/ds$ git pull
> > You asked me to pull without telling me which branch you
> > want to merge with, and 'branch.master.merge' in
> > your configuration file does not tell me either.  Please
> > name which branch you want to merge on the command line and
> > try again (e.g. 'git pull <repository> <refspec>').
> > See git-pull(1) for details on the refspec.
>
> And this does not come up here.
>
> Maybe you don't have a master branch on digispeaker.

At digispeaker remote repo:
[daedalus]$ git branch
  m24
  m25
  m26
  m28
  m29
* master
[daedalus]$

gitweb is at:
git.digispeaker.com

[daedalus]$ cd refs
[daedalus]$ find
.
./heads
./heads/m24
./heads/m25
./heads/m26
./heads/m28
./heads/m29
./heads/master
./tags
[daedalus]$




>
> Ciao,
> Dscho
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
