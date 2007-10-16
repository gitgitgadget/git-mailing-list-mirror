From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: On Tabs and Spaces
Date: Tue, 16 Oct 2007 12:47:17 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710161240510.6887@woody.linux-foundation.org>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
 <471476B7.5050105@users.sourceforge.net> <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>
 <47148F72.1090602@users.sourceforge.net> <1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
 <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu> <3awb7zw6.fsf@blue.sea.net>
 <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
 <20071016193605.GA829@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 21:48:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhsOW-0006Zh-3U
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 21:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189AbXJPTrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 15:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752036AbXJPTrt
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 15:47:49 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48724 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751957AbXJPTrs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 15:47:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9GJlIdD022696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 16 Oct 2007 12:47:19 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9GJlHpx012544;
	Tue, 16 Oct 2007 12:47:18 -0700
In-Reply-To: <20071016193605.GA829@glandium.org>
X-Spam-Status: No, hits=-2.718 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61243>



On Tue, 16 Oct 2007, Mike Hommey wrote:
> 
> Actually, part of the mess with tabs is due to the fact they're not
> exactly 8 spaces wide, but any width that ends at a multiple of 8
> characters from the start of the line. So 0 <= n < 8 spaces and a tab
> is still 8 spaces.

Umm.. That's the definition of "tab width".

The tab width is 8. Not "0 < n <= 8". Not "depends on where you are". The 
tab width is 8.

The whole history of tab is that it comes from mechanical "tab stops" that 
you could set, and that were independent of the text - pressing the tab 
key would move to the next tab stop.

Now, those tab stops were movable, and in fact, I think lots of terminals 
still support setting those tab stops dynamically (ie you can send control 
sequences to set their "tab stops" to different points, exactly like an 
old mechanical typewriter).

But when it comes to computers, 8-character wide tab stops is the 
de-facto standard. It's what every single terminal defaults to. It's the 
only thing that some printers/terminals support. Anything else is by 
definition non-standard.

			Linus
