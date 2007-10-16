From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: On Tabs and Spaces
Date: Tue, 16 Oct 2007 16:05:34 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu> 
 <471476B7.5050105@users.sourceforge.net>  <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>
  <47148F72.1090602@users.sourceforge.net>  <1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
  <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu> <3awb7zw6.fsf@blue.sea.net>
  <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
 <1192565900.6430.16.camel@athena>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Tom Tobin <korpios@korpios.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 01:06:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhvTz-0001ii-KI
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 01:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935788AbXJPXFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 19:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755668AbXJPXFj
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 19:05:39 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48703 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752789AbXJPXFh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 19:05:37 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9GN5ZxN003064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 16 Oct 2007 16:05:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9GN5YMh022417;
	Tue, 16 Oct 2007 16:05:34 -0700
In-Reply-To: <1192565900.6430.16.camel@athena>
X-Spam-Status: No, hits=-2.717 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61274>



On Tue, 16 Oct 2007, Tom Tobin wrote:
> 
> But you then dismiss out of hand the option of using all spaces

I do indeed. I don't think it's sensible. And I did think I already 
answered that issue by talking about how most editors don't even support 
it or show the difference between tabs and spaces.

For example, the editor I use - microemacs - supports tabs just fine. It 
does auto-indentation etc. But it does it with hard-tabs by default, so 
now you have to have some editor-specific setup for that particular 
project if you ever want to do anything else.

And that's really what it boils down to. Everybody support 8-character 
hardtabs (and usually by default). They may support other things *too*, 
but any time you move away from that standard behaviour, you'll most 
likely find something that doesn't support the alternatives.

So yes, the answer really is: "git uses 8-character hard-tabs, live with 
it". 

		Linus
