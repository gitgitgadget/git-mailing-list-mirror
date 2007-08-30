From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Buffer overflows
Date: Thu, 30 Aug 2007 13:46:32 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708301340470.25853@woody.linux-foundation.org>
References: <1188502009.29782.874.camel@hurina>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Timo Sirainen <tss@iki.fi>
X-From: git-owner@vger.kernel.org Thu Aug 30 22:47:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQqum-0008A3-5T
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 22:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762634AbXH3Uqq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 16:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762552AbXH3Uqo
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 16:46:44 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37328 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762453AbXH3Uqn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Aug 2007 16:46:43 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7UKkX4t018296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 30 Aug 2007 13:46:34 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7UKkWqR007479;
	Thu, 30 Aug 2007 13:46:33 -0700
In-Reply-To: <1188502009.29782.874.camel@hurina>
X-Spam-Status: No, hits=-2.018 required=5 tests=AWL,BAYES_00,INFO_TLD
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.30__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57070>



On Thu, 30 Aug 2007, Timo Sirainen wrote:
>
> Looks like nothing has happened since my last mail about this
> (http://marc.info/?l=git&m=117962988804430&w=2).

Perhaps because your patch was using a totally nonstandard and slow 
interface, and had nasty string declaration issues, as people even pointed 
out to you.

If you were to send in a patch that simply just fixed some random case 
without introducing the other stuff in forms that nobody is used to, 
people would probably react more.

Especially since:

> I sure hope no-one's using git-mailinfo to do any kind of automated mail 
> processing from untrusted users.

Obviously nobody would do that. Not because of any email buffer overflows, 
but because people wouldn't want to apply untrusted patches in the first 
place!

IOW, if I don't trust the mail, I'd sure as hell not apply it - not 
because I'm afraid the email is misformed, but because I'd not trust the 
*patch*.

			Linus
