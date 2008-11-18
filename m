From: Gary Yang <garyyang6@yahoo.com>
Subject: Re: "secret key not available". "unable to sign the tag".
Date: Mon, 17 Nov 2008 17:59:10 -0800 (PST)
Message-ID: <424422.27374.qm@web37902.mail.mud.yahoo.com>
References: <20081115035743.GA19633@coredump.intra.peff.net>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 18 03:00:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2FtK-0007Hl-Pl
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 03:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbYKRB7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 20:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbYKRB7N
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 20:59:13 -0500
Received: from web37902.mail.mud.yahoo.com ([209.191.91.164]:39120 "HELO
	web37902.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751767AbYKRB7M (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Nov 2008 20:59:12 -0500
Received: (qmail 27489 invoked by uid 60001); 18 Nov 2008 01:59:11 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=u1nFuFjcAdNvqePXokjXRHDkDNOSPVi2YtlV5PSBiubMwBhWaE7kGssKwj13Uy97bVl+V7WuP8e9q49M0JAxXfixRzyX7JTcX0lZDjrYo+hwsrK4eE1e++uGrFiozNPaH4BC3xynFVhw6oriAkLB6A21A6mgA1wANmjo7vtx+TE=;
X-YMail-OSG: iXykY2YVM1lK4VHhJopqvlmQieANpWOhitFwYQS0793Yxn.EvCOaqZgPAEPSvENkVx4eatwb2UdXLhuFXzH4f9cvmvxnyUJo6OLU3XYl5vWHLKRoN6GkeVEogmRrDqCX_qIp6Pqe9daqFK5GdaMixNwV3eNrOS92Ph3.E0VdbPiCVyBlv9sTgm9nMmIx
Received: from [76.195.33.70] by web37902.mail.mud.yahoo.com via HTTP; Mon, 17 Nov 2008 17:59:10 PST
X-Mailer: YahooMailWebService/0.7.260.1
In-Reply-To: <20081115035743.GA19633@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101257>

Jeff King,

I followed your instruction. But, I still got error when I tag the code. Can you please tell me why?

>   git config --global user.email garyyang6@yahoo.com

git tag -s my-second-tag

gpg: WARNING: using insecure memory!
gpg: please see http://www.gnupg.org/faq.html for more information
gpg: skipped `Gary Yang <garyyang6@yahoo.com>': secret key not available
gpg: signing failed: secret key not available
error: gpg failed to sign the tag
fatal: unable to sign the tag



Thanks,


Gary

--- On Fri, 11/14/08, Jeff King <peff@peff.net> wrote:

> From: Jeff King <peff@peff.net>
> Subject: Re: "secret key not available". "unable to sign the tag".
> To: "Gary Yang" <garyyang6@yahoo.com>
> Cc: git@vger.kernel.org
> Date: Friday, November 14, 2008, 7:57 PM
> On Fri, Nov 14, 2008 at 03:28:44PM -0800, Gary Yang wrote:
> 
> > I got errors and warnings when I used "git tag -s
> my-tag". It says,
> > "secret key not available". "unable to
> sign the tag". 
> 
> Probably because it can't find your secret key, like it
> says.
> 
> > gpg: please see http://www.gnupg.org/faq.html for more
> information
> > gpg: skipped `Gary Yang
> <gyang@linux123.(none)>': secret key not available
> > gpg: signing failed: secret key not available
> > error: gpg failed to sign the tag
> > fatal: unable to sign the tag
> > 
> > I ran "gpg --gen-key" and generated keypair.
> But, still got the same
> > error. Please help.
> 
> Did the key you generated have the email address
> "gyang@linux123.(none)"? If not, then that is
> your problem.
> 
> You need to tell git who you are, since it is unable to
> deduce it from
> doing host lookups. Try:
> 
>   git config --global user.email garyyang6@yahoo.com
> 
> or whatever email address you used when you created the
> key, and then
> gpg should find it appropriately.
> 
> -Peff
> --
> To unsubscribe from this list: send the line
> "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html


      
