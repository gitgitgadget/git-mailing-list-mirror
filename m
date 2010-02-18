From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFD] Deepen the git directory structure a bit.
Date: Thu, 18 Feb 2010 14:20:09 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1002181418160.4141@localhost.localdomain>
References: <alpine.LFD.2.00.1002181010590.4141@localhost.localdomain>  <7vbpfm9tst.fsf@alter.siamese.dyndns.org> <32541b131002181350p245b7fbdw4398501b65835cac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 23:20:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiEjl-0005yl-A7
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 23:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758718Ab0BRWUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 17:20:41 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33756 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755012Ab0BRWUk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Feb 2010 17:20:40 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o1IMK9kI000702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Feb 2010 14:20:10 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o1IMK9hE007227;
	Thu, 18 Feb 2010 14:20:09 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <32541b131002181350p245b7fbdw4398501b65835cac@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.948 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140388>



On Thu, 18 Feb 2010, Avery Pennarun wrote:
> 
> If you don't move it, then it'll continue to interfere with
> autocompletion.  Though maybe that's not a good enough reason :)

Yeah, that's not a huge deal. We have other files that share prefixes. The 
"builtin-" prefix was just _so_ common as to really screw up 
auto-completion in a big way.

So the reason for moving builtin.h was simply that _most_ of the users are 
the builtin headers themselves (and as mentioned, I was thinking of 
making it builtin/cmd.h but avoided it to keep the patch size down).

		Linus
