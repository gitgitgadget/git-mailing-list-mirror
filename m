From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 1.5.3.5 will be out tomorrow
Date: Tue, 30 Oct 2007 17:16:23 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710301712240.30120@woody.linux-foundation.org>
References: <7vfxzsjgos.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 01:16:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In1GH-0002r5-GM
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 01:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183AbXJaAQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 20:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752415AbXJaAQc
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 20:16:32 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48743 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751983AbXJaAQb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Oct 2007 20:16:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9V0GOmZ015803
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Oct 2007 17:16:25 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9V0GOnT002916;
	Tue, 30 Oct 2007 17:16:24 -0700
In-Reply-To: <7vfxzsjgos.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-2.731 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62768>



On Tue, 30 Oct 2007, Junio C Hamano wrote:
>
> A fix for a segfaulting bug warrants a new maintenance release,
> so 1.5.3.5 will be out tomorrow.

Is the 

	"Make merge-recursive honor diff.renamelimit"

commit in the maintenance series?

If not, I'd suggest merging it.

The lack of this fix bit us during the kernel x86 merge, where there was 
no way for people using stable git versions to make their merges take 
renames into account, because there were too many of them..

It's commit df3a02f6125f7ac82b6e81e3e32cd7ca3c7905ee by Lars Hjemli.

		Linus
