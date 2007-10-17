From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 08:53:55 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
 <471476B7.5050105@users.sourceforge.net> <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>
 <47148F72.1090602@users.sourceforge.net> <1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
 <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu> <3awb7zw6.fsf@blue.sea.net>
 <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
 <1192565900.6430.16.camel@athena> <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
 <20071017015109.303760cc@localhost.localdomain>
 <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org>
 <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Christer Weinigel <christer@weinigel.se>,
	Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: Luke Lu <git@vicaya.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 17:54:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiBE7-0003ZV-BC
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 17:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761397AbXJQPyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 11:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759530AbXJQPyT
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 11:54:19 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36248 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755164AbXJQPyS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Oct 2007 11:54:18 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9HFrvKu007980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Oct 2007 08:53:58 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9HFrt7G028361;
	Wed, 17 Oct 2007 08:53:56 -0700
In-Reply-To: <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>
X-Spam-Status: No, hits=-2.717 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61386>



On Wed, 17 Oct 2007, Luke Lu wrote:
> 
> Well, we just established that all-space is perfect, look-wise.

But we also established that an all-space model is not stable, because any 
unix developers will start adding tabs instead of spaces.

> As I mentioned, an all-space policy is trivial to enforce.

Hell no, it's not.

More importantly, I can guarantee that certain developers will refuse to 
be part of such a project with such an idiotic design that eats disk-space 
for no gain, and makes it impossible for me to use my normal editor.

> But I still haven't seen any compelling arguments against the "all space"
> case, other than "people will screw it up into mixed spaces", which is really
> a straw man, as many multi-platform projects enforced the all-space policy
> easily by using a pre-commit hook in maintainers' repository.

Hey, you start your own projct, and you can enforce whatever idiotic rules 
you want to. 

But in the meantime, all-tab indentations are equally good, and are the 
defacto rule. So *you* are the one who should show compelling arguments 
for changing, and so far you haven't shown any.

Really: what is the problem with hardtabs? Absolutely none.

			Linus
