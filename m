From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-mailinfo may corrupt patch headers on attached
 files
Date: Sun, 6 Jul 2008 14:52:24 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807061450240.3016@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0807061036500.3016@woody.linux-foundation.org> <1215379261-10802-1-git-send-email-dzickus@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 23:54:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFcBG-0003kr-Um
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 23:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037AbYGFVxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 17:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754469AbYGFVxE
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 17:53:04 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44086 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753181AbYGFVxD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jul 2008 17:53:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m66LqPV1027037
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 Jul 2008 14:52:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m66LqOf5026545;
	Sun, 6 Jul 2008 14:52:24 -0700
In-Reply-To: <1215379261-10802-1-git-send-email-dzickus@redhat.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-5.355 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87559>



On Sun, 6 Jul 2008, Don Zickus wrote:
> 
> I noticed this the other day, just never got a chance to send the fix out.
> This might be the same problem I ran into.

Ack. This patch does indeed seem to fix the test-case I had. Thanks,

			Linus
