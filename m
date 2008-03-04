From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: tracking renames
Date: Tue, 4 Mar 2008 14:10:29 -0800
Message-ID: <20080304141029.52b12065.akpm@linux-foundation.org>
References: <20080304135734.b2c2f473.akpm@linux-foundation.org>
	<590657100803041403q2cc68e21p1c92c244939eb148@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Harvey Harrison" <harvey.harrison@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 23:11:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWfLp-0002DU-9j
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 23:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757826AbYCDWKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 17:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757941AbYCDWKc
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 17:10:32 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40685 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757600AbYCDWKb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Mar 2008 17:10:31 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.14.2/Debian-2build1) with ESMTP id m24MAhoh004807
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 Mar 2008 14:10:44 -0800
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m24MATSh031704;
	Tue, 4 Mar 2008 14:10:29 -0800
In-Reply-To: <590657100803041403q2cc68e21p1c92c244939eb148@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
X-Spam-Status: No, hits=-2.746 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76147>

On Tue, 4 Mar 2008 14:03:54 -0800
"Harvey Harrison" <harvey.harrison@gmail.com> wrote:

> On Tue, Mar 4, 2008 at 1:57 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> >  When I do
> >
> >         git-whatchanged drivers/watchdog/iTCO_wdt.c
> >
> 
> git-whatchanged --follow drivers/watchdog/iTCO_wdt.c
> 

Oh.  Thanks.  It seems dumb that one needs to add an option to get it to do this.
