From: Gary Yang <garyyang6@yahoo.com>
Subject: Re: "secret key not available". "unable to sign the tag".
Date: Tue, 18 Nov 2008 08:55:53 -0800 (PST)
Message-ID: <876653.99147.qm@web37906.mail.mud.yahoo.com>
References: <alpine.LFD.2.00.0811161609340.3468@nehalem.linux-foundation.org>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Nov 18 17:57:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2Tt1-0001le-HO
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 17:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbYKRQzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 11:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753219AbYKRQzz
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 11:55:55 -0500
Received: from web37906.mail.mud.yahoo.com ([209.191.91.168]:45073 "HELO
	web37906.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751617AbYKRQzy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Nov 2008 11:55:54 -0500
Received: (qmail 223 invoked by uid 60001); 18 Nov 2008 16:55:53 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=xu/IAmtuyurnc+yu+bdPYRuaTDMhWO0+I8/VzBf/dGycu1j8vaxGwY3MqUOZEv93NgNqZ6Yx8BCRFjQ0QxwbLhsggON6ay3UBKssUo0wIA2Mi8zM/LFPrT60Z/t9ZT7UcISLDqOelQgqnimD8U0gi3DM8pwDSLZxqf0w4BWivtQ=;
X-YMail-OSG: FhlFzOEVM1lJZ1yI4wqKPbrkYWsTSuW8sV2dujxSSD9c_x5FE4uj9xGnF45XzAqhUA2bF5sQVLQrFKiyVpsnd.1ZE.Bg3nkouPUqY_9tg27_P7PxR7l1eeImMfDGJSRKnrM56JhQgcwtGa2kDZl7xmbb8vZ5E.4jOPBue93V7j_ar1k-
Received: from [76.195.33.70] by web37906.mail.mud.yahoo.com via HTTP; Tue, 18 Nov 2008 08:55:53 PST
X-Mailer: YahooMailWebService/0.7.260.1
In-Reply-To: <alpine.LFD.2.00.0811161609340.3468@nehalem.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101273>

Hi Jeff,

I do not understand your email. I used the command,
git config --global user.email garyyang6@yahoo.com

But, I still got the same error. Do you have any idea?


Thanks,


Perry




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


      
