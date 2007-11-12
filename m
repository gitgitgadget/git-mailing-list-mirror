From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Cloning from kernel.org, then switching to another repo
Date: Mon, 12 Nov 2007 15:54:59 -0500
Message-ID: <9e4733910711121254j5af5dba6k5acdce939936af66@mail.gmail.com>
References: <9e4733910711120557w62a9966bvb61a02a2bf9b99e9@mail.gmail.com>
	 <Pine.LNX.4.64.0711121412410.4362@racer.site>
	 <alpine.LFD.0.9999.0711121229090.3062@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0711122040350.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 21:55:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrgJT-00006Q-W3
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 21:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbXKLUzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 15:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbXKLUzE
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 15:55:04 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:49998 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbXKLUzB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 15:55:01 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1668263wah
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 12:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=C0c+kMFmzY7f6jCYY3UqR8wWCI1U3YhLGIrVr/r8pN8=;
        b=kjotymKnUdezxA90vat3bFRDYviAyhwE7CAB8I0+0awKIUnIky8prtEoATlWvhVO4AaDzNQBfGaqk+iecOUYgWFpRJ22NrPEGKwMWrN5pJKfXRRIelxUuIPbcZdfXpfUWkTDJu83SagAA6abbiXz4YgcSazfDjCkzgcrZJfWgmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AMt+8UrcB1gpBe3pHyonv5hFCfg4cQd0yEdq7tOSNYGCtdzZJwLNpTSyb6Hwq2tsFujFskwvYJAZiN/3h/dMWy5Lerayl+7bmpiYScP2f5h9bU18quB7JFKTFEAYopWxIyv8PIhAdLFZnNfh1PgHAWUAwGU2xMOkBtA1zJIYE3c=
Received: by 10.114.209.1 with SMTP id h1mr514531wag.1194900900003;
        Mon, 12 Nov 2007 12:55:00 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Mon, 12 Nov 2007 12:54:59 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711122040350.4362@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64708>

On 11/12/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 12 Nov 2007, Linus Torvalds wrote:
>
> > On Mon, 12 Nov 2007, Johannes Schindelin wrote:
> > >
> > > On Mon, 12 Nov 2007, Jon Smirl wrote:
> > >
> > > > I'd like to do this sequence, but I can't figure out how without
> > > > editing the config file. There doesn't seem to be a simple command
> > > > to move the origin.
> > > >
> > > > git clone linus
> > > > move origin to digispeaker.git
> > >
> > > AKA "git config remote.origin.url <your-digispeaker-url-here>"
> >
> > I really think people should at least also mention:
> >
> >       "Or just edit your .git/config file by hand"
>
> FWIW I agree.  The intent of git-repo-config (as it was named then) was to
> have a program for _scripts_ to use.
>
> But for some reasons, people on IRC refuse to edit .git/config by hand.
> *sigh*  Will have to relearn giving proper help.

It is eaiser to put
  git config remote.origin.url
http://git.digispeaker.com/projects/digispeaker-kernel.git
in a cookbook web page sequence than say edit the config file by hand.

I added the cookbook sequence to my git project page.
http://git.digispeaker.com/
Without cloning from kernel.org first it takes an hour to clone from
dreamhost, but what do you want for $5/mth. I'll more to a better host
when traffic picks up.

-- 
Jon Smirl
jonsmirl@gmail.com
