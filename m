From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [OT] Re: Feature request - Subtree checkouts
Date: Tue, 10 Apr 2007 15:12:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704101501590.6730@woody.linux-foundation.org>
References: <20070410074444.GA18541@curie-int.orbis-terrarum.net>
 <20070410132011.GH5436@spearce.org> <7vslb8ug7y.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0704101338060.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704101414330.15823@blackbox.fnordora.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
To: alan <alan@clueserver.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 05:25:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbOa1-00045v-HM
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 00:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965661AbXDJWMq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 18:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965687AbXDJWMq
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 18:12:46 -0400
Received: from smtp.osdl.org ([65.172.181.24]:49050 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965661AbXDJWMp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 18:12:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3AMCFVZ014135
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Apr 2007 15:12:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3AMCEvq018990;
	Tue, 10 Apr 2007 15:12:14 -0700
In-Reply-To: <Pine.LNX.4.64.0704101414330.15823@blackbox.fnordora.org>
X-Spam-Status: No, hits=-0.956 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44169>



On Tue, 10 Apr 2007, alan wrote:
> > 
> > For example, I will personally never see email that comes directly to my
> > email address though an open mail relay *or* from something that appears
> > to be just a random botnet PC (I forget the exact rule, since I'm hapily
> > ignorant of MIS, but I think it boils down to requiring a good reverse DNS
> > lookup).
> 
> Depending on your definition of "good".

Well, the most common case (and the thing I *think* our spam software does 
here) is to just confirm that the reverse DNS lookup (that you want to do 
*anyway* for the "Received" headers for the email) will resolve back to 
the same IP (aka "FCrDNS").

It's also possible to just not accept mail if the reverse lookup indicates 
that the sending IP address is a dynamic address, which you can sometimes 
see from the hostname. I would suggest you *not* name your hosts to 
contain a lot of numbers and the string "dhcp", for example ;)

> Sometimes I think the anti-spam methods are as obnoxious as the 
> spammers. Almost.)

I'll take strict anti-spam methods any day. I get about 10 pieces of spam 
a day, that I can handle easily without worrying about it. I shudder to 
even just think about what it used to be like before aggressive spam 
filtering.

So I'm personally *solidly* in the camp that says "if you want to send me 
email, it's worth making a conscious effort to not look like spam".

		Linus
