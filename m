From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [WIP] Get rid of msys in favor of busybox port for windows
Date: Tue, 10 Jul 2007 12:45:15 -0400
Message-ID: <fcaeb9bf0707100945i2195ed79jf3bbd0d250fc2f2a@mail.gmail.com>
References: <fcaeb9bf0707100832j3c2ff076gab5c9bd4f9d3f4a0@mail.gmail.com>
	 <Pine.LNX.4.64.0707101638521.4047@racer.site>
	 <fcaeb9bf0707100908o4be761b9t920cdc65a72d9aee@mail.gmail.com>
	 <Pine.LNX.4.64.0707101719390.4047@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 10 18:45:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8Iq3-00057Y-KL
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 18:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308AbXGJQpR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 12:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754371AbXGJQpR
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 12:45:17 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:17410 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837AbXGJQpP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 12:45:15 -0400
Received: by an-out-0708.google.com with SMTP id d31so275568and
        for <git@vger.kernel.org>; Tue, 10 Jul 2007 09:45:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vr2Y9DaT/zAMKZLJnbd9B2DrHTc5BzNhYMTfH8LSb4O8LU9H5hWl8Du1xMU+DyA8r9p+KPRQihqLSeMEqoIJdcDBipL/sQA5lIvDLngnbcXqRth/mO+YGLOMSrwjhhAa4+KWAAxqMZ6uxd0LDg3BaENczL8OrTAk139dYmWsQHs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TBZqK4FxvtxzvF7/VtDcVNydwpD1w7ZShzxEOtlf1F5vuAmm1x07LAPqflJdD3b2fTJsEpyaljakM6DyvjbhJBqhAAdQ48+9nuLHfLFtOXXlnqaTvioCKMWfsz/KaOaKEr1MKwtiHFqN6oAg/NiCDa/zx5MfkW9J72OBY83MKY8=
Received: by 10.100.121.12 with SMTP id t12mr2297471anc.1184085915079;
        Tue, 10 Jul 2007 09:45:15 -0700 (PDT)
Received: by 10.100.198.17 with HTTP; Tue, 10 Jul 2007 09:45:15 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707101719390.4047@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52092>

On 7/10/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 10 Jul 2007, Nguyen Thai Ngoc Duy wrote:
>
> > On 7/10/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > On Tue, 10 Jul 2007, Nguyen Thai Ngoc Duy wrote:
> > >
> > > > I'm integrating some code from busybox to mingw tree so that mingw port
> > > > can work without msys. Posix utilities such as sed, awk, head, tail...
> > > > seem to work well. The main obstacle is ash, which is no where near
> > > > usable state (fork issues as always). Busybox ash is about 13000 lines
> > > > of code, not too big.
> > > >
> > > > Anyone interested in?
> > >
> > > Definitely.
> > >
> > > Last time I wanted to assess how much work it is to compile that on MinGW,
> > > though, it seemed to be too much to be tractable.
> >
> > The exact answer is "I don't know" :-) I cross compile all the time
> > however it should build fine on MinGW as it now uses git Makefile.
> > I'll push the patch into mob soon.
>
> Do you mean the whole busybox thing?
>
> If so, please do not put it into mingw.git.  Rather, start a busybox.git
> project (I saw that you have already some projects on repo.or.cz, so it
> should be easy for you.)

No, I don't port the whole busybox (too big, too difficult). I
extracted stuffs that need to run shell scripts (mainly coreutils and
ash) and put them in my mingw tree. Just wanted to push it if you
wanted to try.. maybe later.

-- 
Duy
