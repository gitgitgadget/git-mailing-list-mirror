From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: feature request: git-log should accept sth like
 v2.6.26-rc8-227
Date: Thu, 10 Jul 2008 13:36:26 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807101334310.11076@woody.linux-foundation.org>
References: <200807102057.15063.toralf.foerster@gmx.de> <7vk5ftpnek.fsf@gitster.siamese.dyndns.org> <m3d4lledbn.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 22:38:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH2uM-0001H6-8z
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 22:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709AbYGJUhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 16:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753983AbYGJUhc
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 16:37:32 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39257 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753647AbYGJUhb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jul 2008 16:37:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6AKaQGK010979
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 Jul 2008 13:36:27 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6AKaQlR013732;
	Thu, 10 Jul 2008 13:36:26 -0700
In-Reply-To: <m3d4lledbn.fsf@localhost.localdomain>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.358 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88011>



On Thu, 10 Jul 2008, Jakub Narebski wrote:
> 
> Nevertheless it _could_ be unique.

NO IT COULD NOT!

It doesn't matter if it's unique in _one_ repository. What matters is if 
it is globally unique!

Otherwise, people will start sending these version numbers out in emails, 
and now somethign that was unique in the senders repo is actually not 
unique at the receivers side (or _is_ unique, but points to something 
totally different).

So no. A revision number like "v2.6.26-rc8-227" is fundamentally and 
utterly broken. No way it should ever be accepted, even as a "helpful" 
thing, because it's not helpful at all. It would be a sure way to crap.

		Linus
