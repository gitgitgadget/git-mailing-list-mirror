From: "Govind Salinas" <govindsalinas@gmail.com>
Subject: Re: gitbox status (for those who want to hack on it)
Date: Sat, 11 Aug 2007 16:58:31 -0500
Message-ID: <69b0c0350708111458u5c9d4b16kc118cee4666d376a@mail.gmail.com>
References: <fcaeb9bf0708041040w6d2b3f2cu1680e1e7dc542ffb@mail.gmail.com>
	 <Pine.LNX.4.64.0708051635170.14781@racer.site>
	 <fcaeb9bf0708051841w4701d04dw894b61c5a26d6ed5@mail.gmail.com>
	 <Pine.LNX.4.64.0708060323200.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 23:58:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJyyk-0003PK-W7
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 23:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759309AbXHKV6e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 17:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759538AbXHKV6e
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 17:58:34 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:15538 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759108AbXHKV6d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 17:58:33 -0400
Received: by an-out-0708.google.com with SMTP id d31so218580and
        for <git@vger.kernel.org>; Sat, 11 Aug 2007 14:58:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S6rGyCHcc8JAJ5E/RDdDtTNwNcnlPzdbLpaqAouQ2hZ09L7M6bB/QNOmyCFm06/dPUuKufcI7o0wDLXLbmGjMulUPYa66boi16GwdD/V+5B9KkuoKLXSZEcF09ubhEZ4UC6u9XZv7m9dB6jfCM2LO9Z/dt579Gpby3jbN+L89sU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=On1AJ0ZX+Oxzq+2ACvaGDohMCoTWpatHkcFui7cFYtZovWXMiMnBf8yxQOZGfBsqfSZLXDt0+HtmQVwOU3kDHn1aeBhmMAaqC5W3luJ6ENeqX7p5yr0/94ptepCxSKGlIRFVmDiUg+CPIdpKUi6iohL+poRUc33wDIFI86xojTE=
Received: by 10.100.139.12 with SMTP id m12mr3905903and.1186869512091;
        Sat, 11 Aug 2007 14:58:32 -0700 (PDT)
Received: by 10.100.119.8 with HTTP; Sat, 11 Aug 2007 14:58:31 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0708060323200.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55636>

Hi,

I'm interested in the various git on Windows projects.  I can't seem
to find any information on gitbox on the web though.  Can you tell me
a bit about it?  What makes it different from the other cygwin git or
mingw?

On 8/5/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 5 Aug 2007, Nguyen Thai Ngoc Duy wrote:
>
> > On 8/5/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > Hi,
> > >
> > > On Sat, 4 Aug 2007, Nguyen Thai Ngoc Duy wrote:
> > >
> > > > I would say it's in pretty good state now because it can run through
> > > > test cases. Running tests on Windows can take about an hour so I'll
> > > > put test results here so you don't have to rerun the whole thing if
> > > > you want to know what part needs work.
> > >
> > > I think your project is awesome.  Unfortunately, I did not have time to
> > > check it out yet -- work-tree regressions and msysgit keep me occupied,
> > > along with daytime job...
> >
> > Hey no worries. msysgit is actually good job.
>
> Gee thanks!
>
> > BTW, where was msysgit.git going? I recall I saw something there in
> > repo.or.cz, now it's gone.
>
> No, it's still there: http://repo.or.cz/w/msysgit.git
>
> What you probably saw (for a while) was my unsuccessful attempt to make
> this a fork of mingw.git, which is a fork of git.git.
>
> Ciao,
> Dscho
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
