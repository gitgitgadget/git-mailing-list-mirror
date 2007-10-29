From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: remote#branch
Date: Mon, 29 Oct 2007 11:17:12 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710291112590.30120@woody.linux-foundation.org>
References: <20071015233800.6306e414@paolo-desktop> <20071016021933.GH12156@machine.or.cz>
 <Pine.LNX.4.64.0710161139530.25221@racer.site> <20071016210904.GI26127@efreet.light.src>
 <Pine.LNX.4.64.0710162228560.25221@racer.site> <20071027204757.GA3058@efreet.light.src>
 <Pine.LNX.4.64.0710280000240.4362@racer.site>
 <20071029174000.GA4449@efreet.light.src>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Oct 29 19:18:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImZBz-0000kC-EM
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 19:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591AbXJ2SSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 14:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756874AbXJ2SSK
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 14:18:10 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55002 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753066AbXJ2SSI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Oct 2007 14:18:08 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9TIHNf4010423
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Oct 2007 11:17:24 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9TIHCiJ016439;
	Mon, 29 Oct 2007 11:17:15 -0700
In-Reply-To: <20071029174000.GA4449@efreet.light.src>
X-Spam-Status: No, hits=-2.436 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_66
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62624>



On Mon, 29 Oct 2007, Jan Hudec wrote:
> 
> If the branch names are not url-escaped, than the result is not an URL. Which
> is just ugly and confusing. If it looks like an URL, it should better be one.

Git remote names already aren't "url"s in the http sense. 

We say "master:some.host/file/goes here/without/any/stupid/web-escapes" 
for the ssh names, and the same goes for "file:///name here" etc.

People who think that git URL's are web-pages had better wake up and smell 
the coffee. They aren't. They never were. They never *should* be.

This whole argument is idiotic. The #branch format was a mistake of 
cogito. Cogito is dead. Get over it already.

We have a format already, and it has nothing to do with '#' or any idiotic 
web escape, or anything else.

			Linus
