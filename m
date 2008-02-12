From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC] diff --relative: output paths as relative to the
 current subdirectory
Date: Tue, 12 Feb 2008 15:33:44 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802121531170.2920@woody.linux-foundation.org>
References: <7vzlu524n9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 00:34:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP4eB-00020N-V5
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 00:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbYBLXeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 18:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752344AbYBLXeI
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 18:34:08 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59354 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752247AbYBLXeG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2008 18:34:06 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1CNXiBT016914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Feb 2008 15:33:46 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1CNXiQZ028688;
	Tue, 12 Feb 2008 15:33:44 -0800
In-Reply-To: <7vzlu524n9.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.241 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73711>



On Tue, 12 Feb 2008, Junio C Hamano wrote:
>
> This adds --relative option to diff family.  When you start from
> a subdirectory, 
> 
>  $ git diff --relative

Ack, except I think it should allow you to actually *set* what the diff is 
relative to.

An example of that could be something like

	git diff --relative=drivers/scsi/ a..b -- drivers/scsi/

where you aren't actually *in* that subdirectory, but for one reason or 
another you're limiting the diff to just stuff in that subdirectory, and 
want a diff that is relative to that one.

Hmm?

			Linus
