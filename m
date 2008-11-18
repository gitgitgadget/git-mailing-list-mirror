From: Gary Yang <garyyang6@yahoo.com>
Subject: Re: "secret key not available". "unable to sign the tag".
Date: Tue, 18 Nov 2008 12:22:09 -0800 (PST)
Message-ID: <832452.93473.qm@web37901.mail.mud.yahoo.com>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Nov 18 21:23:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2X6d-0007LF-OS
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 21:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503AbYKRUWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 15:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752472AbYKRUWM
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 15:22:12 -0500
Received: from web37901.mail.mud.yahoo.com ([209.191.91.163]:24525 "HELO
	web37901.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752439AbYKRUWL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Nov 2008 15:22:11 -0500
Received: (qmail 93756 invoked by uid 60001); 18 Nov 2008 20:22:09 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Message-ID;
  b=0mXdW/F72VLwTTwWkYMpYjFfmRx2m7CstaiHUPDx5WbqoHUmv41JOcZ/oWgwOckIykeLPwvz1CREdK9bDfLq2YWQ9sS5sEeyPCUObfQ+qRx9OoCkPkscm+iCPDban+zwGMrrgol85aP5llcAldPkb7uYv6ti2ccunSZAGQyf4xI=;
X-YMail-OSG: l9RvUisVM1lgRWGAqyTerQDiMZTiy7dOuoUBKttXysiZvOHeR_nclMCXkxb4IwS1l01t4aCaIQLiPAn6_6R3kA316uhEmOD3PiNmKuZlRqgHRGo.PZAVIYqfc3jHxPx013gaE2NO6PSQXVJC0bn0_bjhY1pSAIVDf8gfQ5xu9lfE8UA-
Received: from [76.195.33.70] by web37901.mail.mud.yahoo.com via HTTP; Tue, 18 Nov 2008 12:22:09 PST
X-Mailer: YahooMailWebService/0.7.260.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101281>

All,

I really need to tag my source code. But, somehow I am not able. Can someone help?

Thanks in advance!


Gary



--- On Tue, 11/18/08, Gary Yang <garyyang6@yahoo.com> wrote:

> From: Gary Yang <garyyang6@yahoo.com>
> Subject: Re: "secret key not available". "unable to sign the tag".
> To: "Jeff King" <peff@peff.net>, "Linus Torvalds" <torvalds@linux-foundation.org>
> Cc: git@vger.kernel.org
> Date: Tuesday, November 18, 2008, 8:57 AM
> Hi Linus,
> 
> I do not understand your email. I used the command, git
> config --global user.email garyyang6@yahoo.com. But, I still
> got the same error. Do you have any idea?
> 
> Thank you,
> 
> 
> Gary
> 
> 
> --- On Sun, 11/16/08, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> 
> > From: Linus Torvalds
> <torvalds@linux-foundation.org>
> > Subject: Re: "secret key not available".
> "unable to sign the tag".
> > To: "Jeff King" <peff@peff.net>
> > Cc: "Gary Yang" <garyyang6@yahoo.com>,
> git@vger.kernel.org
> > Date: Sunday, November 16, 2008, 4:16 PM
> > On Fri, 14 Nov 2008, Jeff King wrote:
> > > 
> > > You need to tell git who you are, since it is
> unable
> > to deduce it from
> > > doing host lookups. Try:
> > > 
> > >   git config --global user.email
> garyyang6@yahoo.com
> > > 
> > > or whatever email address you used when you
> created
> > the key, and then
> > > gpg should find it appropriately.
> > 
> > Side note: sometimes you might want to use a different
> key
> > than the one 
> > you use for authorship. Then you can use
> > 
> > 	[user]
> > 		SigningKey = key
> > 
> > (or "git config user.signingkey xyz" if you
> > don't want to edit the 
> > config file manually). 
> > 
> > This can be especially useful if you use different
> keys for
> > different 
> > projects, even if you want to be known under the same
> name
> > in both. Or 
> > because you want to have the local hostname in your
> commit
> > logs, but your 
> > gpg key is using some externally visible
> > "official" email address.
> > 
> > 			Linus


      
