From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [WIP/RFC] Allow push and fetch urls to be different
Date: Sat, 6 Jun 2009 10:57:55 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906061057160.6847@localhost.localdomain>
References: <7v1vpztsci.fsf@alter.siamese.dyndns.org> <1244299395-6605-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Nikos Chantziaras <realnc@arcor.de>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Jun 06 19:58:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MD0AL-0005VK-OE
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 19:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbZFFR6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 13:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbZFFR6G
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 13:58:06 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42881 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751828AbZFFR6G (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Jun 2009 13:58:06 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n56HvuS7026522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 6 Jun 2009 10:57:57 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n56Hvt29003521;
	Sat, 6 Jun 2009 10:57:55 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <1244299395-6605-1-git-send-email-git@drmicha.warpmail.net>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.965 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120928>



On Sat, 6 Jun 2009, Michael J Gruber wrote:
>
> This introduces a config setting remote.$remotename.pushurl which is
> used for pushes only. If absent remote.$remotename.url is used for
> pushes and fetches as before.

Ack, looks sane to me. 

			Linus
