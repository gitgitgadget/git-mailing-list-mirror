From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: gitk from subdirectory
Date: Fri, 31 Aug 2007 00:38:50 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708310038080.25853@woody.linux-foundation.org>
References: <7vabs85ntg.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0708302200160.25853@woody.linux-foundation.org>
 <7vejhk45q5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 09:39:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR15n-0008OZ-DP
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 09:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbXHaHi5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 03:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbXHaHi5
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 03:38:57 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35272 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752834AbXHaHi4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Aug 2007 03:38:56 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7V7coB7009358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 31 Aug 2007 00:38:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7V7coDF029907;
	Fri, 31 Aug 2007 00:38:50 -0700
In-Reply-To: <7vejhk45q5.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-2.746 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.30__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57125>



On Thu, 30 Aug 2007, Junio C Hamano wrote:

> "git log" family of commands, even when run from a subdirectory,
> do not limit the revision range with the current directory as
> the path limiter, but with double-dash without any paths after
> it, i.e. "git log --" do so.  It was a mistake to have a
> difference between "git log --" and "git log" introduced in
> commit ae563542bf10fa8c33abd2a354e4b28aca4264d7 (First cut at
> libifying revlist generation).
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Looks obviously correct.

Acked-by: Linus Torvalds <torvalds@linux-foundation.org>

		Linus
