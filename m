From: Gary Yang <garyyang6@yahoo.com>
Subject: Re: "secret key not available". "unable to sign the tag".
Date: Tue, 18 Nov 2008 08:57:33 -0800 (PST)
Message-ID: <525043.96796.qm@web37903.mail.mud.yahoo.com>
References: <alpine.LFD.2.00.0811161609340.3468@nehalem.linux-foundation.org>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Nov 18 17:59:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2Tuc-0002Tp-4P
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 17:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbYKRQ5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 11:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752537AbYKRQ5e
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 11:57:34 -0500
Received: from web37903.mail.mud.yahoo.com ([209.191.91.165]:28822 "HELO
	web37903.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752472AbYKRQ5e (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Nov 2008 11:57:34 -0500
Received: (qmail 97245 invoked by uid 60001); 18 Nov 2008 16:57:33 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=M/RTyRCT5Y92Oewf7tltnc69fFUT4Jpe3bTWy4S0rVwbp4DjLHev3wXQ99ITkVDovz57G7rxzC7Z9nyVtcPG4KhvpKTRzlJlzWzYdWbGZnYBUsa/LZtUQG+qVDVZPWh9ovVO4jKG0lX7/MtJuJlBY9dQmZpgsDPt/jB5YzIQlCA=;
X-YMail-OSG: zppmoU4VM1lFXq1KkGflmtaqumnOgqoYT_DgDSnQFoKiuPG1OqtbKw1pxdUIql5FQu3qaPXOFL7C2ng_UmdqHDA7A9quDW6oOR_WW5jhWG9ZGfBA4T1ji5To3CTy4JN_vajNO9LHtucsopNXgOPdF8QLvfJxHgUmv69h1GihYct3BUU-
Received: from [76.195.33.70] by web37903.mail.mud.yahoo.com via HTTP; Tue, 18 Nov 2008 08:57:33 PST
X-Mailer: YahooMailWebService/0.7.260.1
In-Reply-To: <alpine.LFD.2.00.0811161609340.3468@nehalem.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101274>

Hi Linus,

I do not understand your email. I used the command, git config --global user.email garyyang6@yahoo.com. But, I still got the same error. Do you have any idea?

Thank you,


Gary


--- On Sun, 11/16/08, Linus Torvalds <torvalds@linux-foundation.org> wrote:

> From: Linus Torvalds <torvalds@linux-foundation.org>
> Subject: Re: "secret key not available". "unable to sign the tag".
> To: "Jeff King" <peff@peff.net>
> Cc: "Gary Yang" <garyyang6@yahoo.com>, git@vger.kernel.org
> Date: Sunday, November 16, 2008, 4:16 PM
> On Fri, 14 Nov 2008, Jeff King wrote:
> > 
> > You need to tell git who you are, since it is unable
> to deduce it from
> > doing host lookups. Try:
> > 
> >   git config --global user.email garyyang6@yahoo.com
> > 
> > or whatever email address you used when you created
> the key, and then
> > gpg should find it appropriately.
> 
> Side note: sometimes you might want to use a different key
> than the one 
> you use for authorship. Then you can use
> 
> 	[user]
> 		SigningKey = key
> 
> (or "git config user.signingkey xyz" if you
> don't want to edit the 
> config file manually). 
> 
> This can be especially useful if you use different keys for
> different 
> projects, even if you want to be known under the same name
> in both. Or 
> because you want to have the local hostname in your commit
> logs, but your 
> gpg key is using some externally visible
> "official" email address.
> 
> 			Linus


      
