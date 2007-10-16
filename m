From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: git-merge performance
Date: Tue, 16 Oct 2007 11:18:25 -0700
Message-ID: <20071016111825.5a142f00.akpm@linux-foundation.org>
References: <20071016101748.ff132685.akpm@linux-foundation.org>
	<4714F612.2010905@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Oct 16 20:19:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihr0B-0001kb-LT
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 20:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965257AbXJPSSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 14:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965255AbXJPSSd
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 14:18:33 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39318 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965247AbXJPSSb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 14:18:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9GIIPVQ017322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 16 Oct 2007 11:18:26 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id l9GIIPh2009194;
	Tue, 16 Oct 2007 11:18:25 -0700
In-Reply-To: <4714F612.2010905@op5.se>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
X-Spam-Status: No, hits=-2.647 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61235>

On Tue, 16 Oct 2007 19:34:10 +0200
Andreas Ericsson <ae@op5.se> wrote:

> Andrew Morton wrote:
> > My git-pulling script (git-1.4.2) seems to have got quite a bit slower
> > since the post-2.6.23 patchflood.  I just did a bit of poking and it's
> > git-merge which is taking most of the time.
> > 
> 
> That's odd. If it had been the remote fetching it would have been
> understandable. Is this also happening with more recent gits? I know there
> are some significant performance-improvements in 1.5.3.4 (or below).
> 

1.5.0 is no faster, but 1.5.3 appears to be seven times quicker.  Neato.
