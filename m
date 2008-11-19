From: Gary Yang <garyyang6@yahoo.com>
Subject: Re: "secret key not available". "unable to sign the tag".
Date: Wed, 19 Nov 2008 08:54:14 -0800 (PST)
Message-ID: <86367.3986.qm@web37907.mail.mud.yahoo.com>
References: <alpine.LFD.2.00.0811190740200.18283@nehalem.linux-foundation.org>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Nov 19 17:55:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2qKx-0001dc-NX
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 17:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbYKSQyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 11:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752770AbYKSQyP
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 11:54:15 -0500
Received: from web37907.mail.mud.yahoo.com ([209.191.91.169]:44184 "HELO
	web37907.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752643AbYKSQyO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Nov 2008 11:54:14 -0500
Received: (qmail 5201 invoked by uid 60001); 19 Nov 2008 16:54:14 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=jjUOCGnCIUxk1eWbf7SjVRL2DDKwX+jSSkTNUy4oTND1EGeesHfzc5Bm/wPBdRwfZNO8wX7bpr/t5X+IDUdUa3pOszTVA9JHJASw8MBrI95ivDW09XOfHfVmgfTRuE+SYOXxwewrsARjLf1P8NQeR1/EspujHOlZhtVrLSiH6Sc=;
X-YMail-OSG: HOS.GkoVM1kajd6wSNFSNIq3Hcpxy.IFtPTOBK3etLp9p.OcyTKN1rxkxFPUuZ8KRf50jeSFi.b.NWLodFIMLkT_KqzHgQFQTzVbD6cHp6.kqOFhvTtDHFmZbcRbgl3g7EYsizY1QFOB9zTMF2HWeRaNAsU.M7rscIT.dcp3E4efwr8-
Received: from [76.195.33.70] by web37907.mail.mud.yahoo.com via HTTP; Wed, 19 Nov 2008 08:54:14 PST
X-Mailer: YahooMailWebService/0.7.260.1
In-Reply-To: <alpine.LFD.2.00.0811190740200.18283@nehalem.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101361>

The command, "git tag -u garyyang6@yahoo.com tag-name" works! Thank you! 
Below is the output of "gpg -k". I have no idea why I have three keys.


gpg -k
gpg: WARNING: using insecure memory!
gpg: please see http://www.gnupg.org/faq.html for more information
/home/garyyang6/.gnupg/pubring.gpg
----------------------------------
pub  1024D/A3F6A45E 2008-11-14 Gary Yang (For git.) <garyyang6@yahoo.com>
sub  1024g/58AE6B3C 2008-11-14

pub  1024D/EE763A89 2008-11-14 Gary Yang (PGP for git.) <garyyang6@yahoo.com>
sub  1024g/AECCA323 2008-11-14

pub  1024D/5015631E 2008-11-18 Gary Yang (For git) <garyyang6@yahoo.com>



--- On Wed, 11/19/08, Linus Torvalds <torvalds@linux-foundation.org> wrote:

> From: Linus Torvalds <torvalds@linux-foundation.org>
> Subject: Re: "secret key not available". "unable to sign the tag".
> To: "Gary Yang" <garyyang6@yahoo.com>
> Cc: "Jeff King" <peff@peff.net>, "Git Mailing List" <git@vger.kernel.org>
> Date: Wednesday, November 19, 2008, 7:42 AM
> On Tue, 18 Nov 2008, Gary Yang wrote:
> > 
> > The gpg works. But, git tag dose not work. Any idea?
> 
> Does
> 
> 	git tag -u garyyang6@yahoo.com tag-name
> 
> work (ie when you use an explicitly given key to tag with)?
> 
> And if not, please do list the output of "gpg -K"
> if that doesn't work.
> 
> 			Linus
> --
> To unsubscribe from this list: send the line
> "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html


      
