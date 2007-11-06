From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-log -p --raw broken?
Date: Tue, 6 Nov 2007 15:10:59 -0800 (PST)
Message-ID: <alpine.LFD.0.999.0711061508490.15101@woody.linux-foundation.org>
References: <f329bf540711061448iab9d4a9q37e13b846dbc5ff1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Wed Nov 07 00:11:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpXZo-0001F7-Tz
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 00:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755085AbXKFXLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 18:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754681AbXKFXLE
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 18:11:04 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41304 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754673AbXKFXLC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Nov 2007 18:11:02 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA6NB09P011048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 6 Nov 2007 15:11:01 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA6NAxaC013938;
	Tue, 6 Nov 2007 15:11:00 -0800
In-Reply-To: <f329bf540711061448iab9d4a9q37e13b846dbc5ff1@mail.gmail.com>
X-Spam-Status: No, hits=-2.739 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63744>



On Tue, 6 Nov 2007, Han-Wen Nienhuys wrote:
>
> The manual page suggests that I should be able to do
> 
>  git log -p --raw COMMIT-RANGE
> 
> however, when I try that, I get always get the same style output,
> which is the (to me: useless) human readable output.
> 
> Am I missing something?

No, you're not *missing* anything. You have something *too much*.

Please remove the "-p" if you don't want a patch.

This works:

	git log --raw COMMIT-RANGE

(actually, most of the time you'd want to use "-r" too when you get raw 
output, but git log enables that by default)

			Linus
