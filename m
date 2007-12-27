From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/4] Allow selection of different cleanup modes for commit
 messages
Date: Wed, 26 Dec 2007 16:44:46 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712261643440.21557@woody.linux-foundation.org>
References: <1198382136-15724-1-git-send-email-gitster@pobox.com> <1198382136-15724-2-git-send-email-gitster@pobox.com> <1198382136-15724-3-git-send-email-gitster@pobox.com> <1198382136-15724-4-git-send-email-gitster@pobox.com>
 <7vmyrxm2qh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 27 01:45:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7gsO-0006zZ-Lw
	for gcvg-git-2@gmane.org; Thu, 27 Dec 2007 01:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbXL0ApA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2007 19:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbXL0ApA
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Dec 2007 19:45:00 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42929 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751709AbXL0Ao7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Dec 2007 19:44:59 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBR0ikME028918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 26 Dec 2007 16:44:47 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBR0ikTv000996;
	Wed, 26 Dec 2007 16:44:46 -0800
In-Reply-To: <7vmyrxm2qh.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-3.217 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69252>



On Wed, 26 Dec 2007, Junio C Hamano wrote:
> 
> Any comments on the cleaned-up series?

Me likee. I think there's still room for some possible future discussions 
(the whole "flag in the file to allow the editor to choose" kind of 
thing), but this seems like a good improvement on the current state.

		Linus
