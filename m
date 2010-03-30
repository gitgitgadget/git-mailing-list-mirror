From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/3] Add support for GIT_ONE_FILESYSTEM
Date: Tue, 30 Mar 2010 16:12:49 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1003301610151.3707@i5.linux-foundation.org>
References: <1268855753-25840-1-git-send-email-lars@pixar.com> <1268855753-25840-4-git-send-email-lars@pixar.com> <20100328092253.GA17563@coredump.intra.peff.net> <7vr5n44crq.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1003301537150.3707@i5.linux-foundation.org>
 <20100330230211.GC608@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Lars R. Damerow" <lars@pixar.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 31 02:16:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwlbi-0000aD-H4
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 02:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176Ab0CaAQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 20:16:00 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44879 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756764Ab0C3XRi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 19:17:38 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2UNHGkD024939
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Mar 2010 16:17:17 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2UNHFUW011116;
	Tue, 30 Mar 2010 16:17:15 -0700
In-Reply-To: <20100330230211.GC608@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.949 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143626>



On Tue, 30 Mar 2010, Jeff King wrote:
> 
> Fashionably late, of course. I agree with your reasoning that it is
> a more sane default. The only thing that would make me hesitate on it
> now is that it is a behavior change. I suspect the group we would be
> breaking is small or even zero, though.

Well, I have to admit that I'm a _tiny_ bit nervous that some odd OS or 
filesystem has special magic st_dev rules so that it changes randomly even 
within a filesystem, but that would be very non-posix (think of the 
confusion it would cause standard UNIX tools like 'find -xdev' etc), so 
it's more a worry of "I have no idea what st_dev means on Windows" than 
anything really solid.

			Linus
