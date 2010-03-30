From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/3] Add support for GIT_ONE_FILESYSTEM
Date: Tue, 30 Mar 2010 15:43:01 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1003301537150.3707@i5.linux-foundation.org>
References: <1268855753-25840-1-git-send-email-lars@pixar.com> <1268855753-25840-4-git-send-email-lars@pixar.com> <20100328092253.GA17563@coredump.intra.peff.net> <7vr5n44crq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, "Lars R. Damerow" <lars@pixar.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 00:48:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwkEH-0007a1-Dt
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 00:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653Ab0C3WsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 18:48:08 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52128 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750962Ab0C3WsH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 18:48:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2UMlSEN022108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Mar 2010 15:47:30 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2UMlRUk009485;
	Tue, 30 Mar 2010 15:47:28 -0700
In-Reply-To: <7vr5n44crq.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.949 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143615>



On Sun, 28 Mar 2010, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > With those fixes, I think it should be ready for 'next'.
> 
> Yeah, looks nice; thanks both.

I realize that I'm late to the party, but I do wonder if the "one 
filesystem" mode shouldn't be the default, rather than be enabled by a 
config option? IOW, just switch the meaning of the config option the other 
way.

I suspect that it is _very_ unusual to have a source repo that crosses 
multiple filesystems, and the original reason for this patch-series seems 
to me to be likely to be more common than that multi-fs case. So having 
the logic go the other way would seem to match the common case, no?

			Linus
