From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Clean way to disable pager
Date: Sun, 19 Aug 2007 10:52:58 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708191051390.30176@woody.linux-foundation.org>
References: <vpq1wdz307k.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Aug 19 19:53:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMoxf-0001Dt-TL
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 19:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663AbXHSRxM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 13:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753553AbXHSRxM
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 13:53:12 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59911 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753345AbXHSRxM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Aug 2007 13:53:12 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7JHr4TO006840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 19 Aug 2007 10:53:05 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7JHqwcw018985;
	Sun, 19 Aug 2007 10:52:59 -0700
In-Reply-To: <vpq1wdz307k.fsf@bauges.imag.fr>
X-Spam-Status: No, hits=-3.251 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56132>



On Sun, 19 Aug 2007, Matthieu Moy wrote:
> 
> I think that deserves an less-hacky, and documented way. I'd suggest a
> --no-pager, or --dont-paginate, that would do the opposite of -p as a
> global option for git.

Ack. I think it makes sense. The GIT_PAGER thing is equivalent, but at the 
same time, having a way to explicitly disable it with a command line 
option just seems to be the RightThing(tm) to do.

		Linus
