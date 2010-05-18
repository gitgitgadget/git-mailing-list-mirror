From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] t9129: fix UTF-8 locale detection
Date: Tue, 18 May 2010 13:00:32 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005181300130.7559@i5.linux-foundation.org>
References: <1274202486.4228.22.camel@localhost> <1274203013-1349-1-git-send-email-yann@droneaud.fr> <alpine.LFD.2.00.1005181037250.4195@i5.linux-foundation.org> <m24oi5j81q.fsf@igel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Yann Droneaud <yann@droneaud.fr>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue May 18 22:03:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OET0U-00086R-8X
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 22:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758159Ab0ERUDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 16:03:08 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35666 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756096Ab0ERUDG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 May 2010 16:03:06 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o4IK2g6F027935
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 May 2010 13:02:43 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o4IK2fg3032675;
	Tue, 18 May 2010 13:02:41 -0700
In-Reply-To: <m24oi5j81q.fsf@igel.home>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.446 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147307>



On Tue, 18 May 2010, Andreas Schwab wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > Wouldn't it be easier to just make it ignore case, and do
> >
> > 	grep -qi '^en_US\.utf-?8$'
> 
> You'll need ERE's for the ? operator.

Oh, just replace it with '*' then. It's not like anybody cares.

		Linus
