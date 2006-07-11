From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: 2 questions on git-send-email usage
Date: Tue, 11 Jul 2006 06:09:17 +0000 (GMT)
Message-ID: <20060711060917.34698.qmail@web25813.mail.ukl.yahoo.com>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 08:09:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0BQx-0006y9-DH
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 08:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWGKGJT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 02:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWGKGJT
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 02:09:19 -0400
Received: from web25813.mail.ukl.yahoo.com ([217.146.176.246]:50284 "HELO
	web25813.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030189AbWGKGJT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 02:09:19 -0400
Received: (qmail 34700 invoked by uid 60001); 11 Jul 2006 06:09:17 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type;
  b=vKH7FHuMYNWe3nnE+R6842UYV2Tiir7p0pmbEAXnIRgWhroYmWXMUt7XS8iMbXsGy1zXJxHa73RnyqbQUeVzGqudvnTa/iGSuqIwEKF1XOoMqlVqzO/byefr4CtosW98BFlRIWjbqMYtPPXJQERK0/WrsWA5xI6ye11hUnx9sBI=  ;
Received: from [82.235.205.153] by web25813.mail.ukl.yahoo.com via HTTP; Tue, 11 Jul 2006 06:09:17 GMT
To: jnareb@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23687>

(please let me CCed when replying)
 
 2006/7/10, Jakub Narebski <jnareb@gmail.com>:
 > moreau francis wrote:
 > 
 > > I'm wondering what am I supposed to answer when git-send-email
 > > is asking me :
 > >
 > > Message-ID to be used as In-Reply-To for the first email?
 > >
 > > I'm running this command:
 > >
 > > $ git-send-email --no-signed-off-by-cc --no-chain-reply-to --to \
 > >   foo@bar.com --compose /tmp/patch/
 > >
 > > to write an introductory message, and all patches are sent as replies to
 > > this introductory email sent.
 > 
 > Empty string (i.e. RET) should do if you don't want to attach your series of
 > patches somewhere in existing thread.
 
 ok I'll try
 
 --in-reply-to ""
 
 > 
 > > I also noticed that git-send-email removes the commit message of each
 > > patches I sent, I don't think this is the normal behaviour though. What
 > > am I missing ?
 > 
 > Are patches formatted using git-format-patch?
 > 
 
 yes
 
 Francis
