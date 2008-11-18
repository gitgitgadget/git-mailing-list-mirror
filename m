From: Gary Yang <garyyang6@yahoo.com>
Subject: Re: "secret key not available". "unable to sign the tag".
Date: Tue, 18 Nov 2008 13:20:42 -0800 (PST)
Message-ID: <31942.12221.qm@web37902.mail.mud.yahoo.com>
References: <810496.66936.qm@web37903.mail.mud.yahoo.com>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Nov 18 22:22:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2Y1R-0004op-4H
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 22:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbYKRVUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 16:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752233AbYKRVUo
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 16:20:44 -0500
Received: from web37902.mail.mud.yahoo.com ([209.191.91.164]:24744 "HELO
	web37902.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750868AbYKRVUo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Nov 2008 16:20:44 -0500
Received: (qmail 12351 invoked by uid 60001); 18 Nov 2008 21:20:43 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=Z2/N0BE0oR5fLIJw/2CcEuMu3Zmz+4q0CoX96DXQL5b1I0HRDMncPkR1uWquqTi2ahoeZbT0g30zuVE7MeK7jo1DvQJP1DOIL0yb0b9mnT2xNuK3bXgmJF0jkR2ATE7wc8o98fBKf06xnEHO7PkLpvZbuaSAjrrk8BYUY0RvJ9k=;
X-YMail-OSG: W4xG.EUVM1kNTxsAM8yp6pmdjQGNuIhJc2nVeVlUnMyhr4BRkUvAKWnnDlxF0bevpS0vY5JbErzWTNI4.AGGig.WLUD_fztS00yujdH20E1lWgMvsf6iF0WR3_WZauHKPkGxwlc2sOBvnGz5.W87bIFZ6cvvPVzP.EwdsHtj_7I_Kn4-
Received: from [76.195.33.70] by web37902.mail.mud.yahoo.com via HTTP; Tue, 18 Nov 2008 13:20:42 PST
X-Mailer: YahooMailWebService/0.7.260.1
In-Reply-To: <810496.66936.qm@web37903.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101287>



The gpg works. But, git tag dose not work. Any idea?


gpg --detach-sign foo.bar
gpg: WARNING: using insecure memory!
gpg: please see http://www.gnupg.org/faq.html for more information

You need a passphrase to unlock the secret key for
user: "Gary Yang (For git.) <garyyang6@yahoo.com>"
1024-bit DSA key, ID A3F6A45E, created 2008-11-14
Enter passphrase: 
[garyyang6@svdclc313 ~/git-repository]%


It successfully signed.


Gary


--- On Tue, 11/18/08, Gary Yang <garyyang6@yahoo.com> wrote:

> From: Gary Yang <garyyang6@yahoo.com>
> Subject: Re: "secret key not available". "unable to sign the tag".
> To: "Jeff King" <peff@peff.net>, "Linus Torvalds" <torvalds@linux-foundation.org>
> Cc: git@vger.kernel.org
> Date: Tuesday, November 18, 2008, 12:26 PM
> Here are the errors I got:
> 
> git tag -s my-second-tag
> 
> gpg: WARNING: using insecure memory!
> gpg: please see http://www.gnupg.org/faq.html for more
> information
> gpg: skipped `Gary Yang <garyyang6@yahoo.com>':
> secret key not available
> gpg: signing failed: secret key not available
> error: gpg failed to sign the tag
> fatal: unable to sign the tag
> 
> 
> 
> Thanks,
> 
> 
> Gary
> 
> 
> 
> --- On Tue, 11/18/08, Gary Yang <garyyang6@yahoo.com>
> wrote:
> 
> > From: Gary Yang <garyyang6@yahoo.com>
> > Subject: Re: "secret key not available".
> "unable to sign the tag".
> > To: "Jeff King" <peff@peff.net>,
> "Linus Torvalds"
> <torvalds@linux-foundation.org>
> > Cc: git@vger.kernel.org
> > Date: Tuesday, November 18, 2008, 12:22 PM
> > All,
> > 
> > I really need to tag my source code. But, somehow I am
> not
> > able. Can someone help?
> > 
> > Thanks in advance!
> > 
> > 
> > Gary
> > 
> > 
> > 
> > --- On Tue, 11/18/08, Gary Yang
> <garyyang6@yahoo.com>
> > wrote:
> > 
> > > From: Gary Yang <garyyang6@yahoo.com>
> > > Subject: Re: "secret key not
> available".
> > "unable to sign the tag".
> > > To: "Jeff King" <peff@peff.net>,
> > "Linus Torvalds"
> > <torvalds@linux-foundation.org>
> > > Cc: git@vger.kernel.org
> > > Date: Tuesday, November 18, 2008, 8:57 AM
> > > Hi Linus,
> > > 
> > > I do not understand your email. I used the
> command,
> > git
> > > config --global user.email garyyang6@yahoo.com.
> But, I
> > still
> > > got the same error. Do you have any idea?
> > > 
> > > Thank you,
> > > 
> > > 
> > > Gary
> > > 
> > > 
> > > --- On Sun, 11/16/08, Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > 
> > > > From: Linus Torvalds
> > > <torvalds@linux-foundation.org>
> > > > Subject: Re: "secret key not
> > available".
> > > "unable to sign the tag".
> > > > To: "Jeff King"
> <peff@peff.net>
> > > > Cc: "Gary Yang"
> > <garyyang6@yahoo.com>,
> > > git@vger.kernel.org
> > > > Date: Sunday, November 16, 2008, 4:16 PM
> > > > On Fri, 14 Nov 2008, Jeff King wrote:
> > > > > 
> > > > > You need to tell git who you are, since
> it
> > is
> > > unable
> > > > to deduce it from
> > > > > doing host lookups. Try:
> > > > > 
> > > > >   git config --global user.email
> > > garyyang6@yahoo.com
> > > > > 
> > > > > or whatever email address you used when
> you
> > > created
> > > > the key, and then
> > > > > gpg should find it appropriately.
> > > > 
> > > > Side note: sometimes you might want to use a
> > different
> > > key
> > > > than the one 
> > > > you use for authorship. Then you can use
> > > > 
> > > > 	[user]
> > > > 		SigningKey = key
> > > > 
> > > > (or "git config user.signingkey
> xyz" if
> > you
> > > > don't want to edit the 
> > > > config file manually). 
> > > > 
> > > > This can be especially useful if you use
> > different
> > > keys for
> > > > different 
> > > > projects, even if you want to be known under
> the
> > same
> > > name
> > > > in both. Or 
> > > > because you want to have the local hostname
> in
> > your
> > > commit
> > > > logs, but your 
> > > > gpg key is using some externally visible
> > > > "official" email address.
> > > > 
> > > > 			Linus
> > 
> > 
> >       
> > --
> > To unsubscribe from this list: send the line
> > "unsubscribe git" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> > http://vger.kernel.org/majordomo-info.html
> 
> 
>       
> --
> To unsubscribe from this list: send the line
> "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html


      
