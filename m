From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] block-sha1/sha1.c: silence compiler complaints by casting
 void* to uintptr_t
Date: Sat, 15 Aug 2009 11:43:11 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908151142470.3162@localhost.localdomain>
References: <alpine.LFD.2.00.0908130017080.10633@xanadu.home> <_-0l9qI_nKm-VVtKlL5hzen4bhcyRmiZ1z4jSmKK1LwECXueziRDzSTyacEehOkoqsfYIaEUlds@cipher.nrlssc.navy.mil> <alpine.DEB.1.00.0908150207270.8306@pacific.mpi-cbg.de> <alpine.LFD.2.01.0908141714040.3162@localhost.localdomain>
 <5HEgWEs64y4Ty7FnekstRP8Q71pNi_FTweLbMhYWc6zoZBA4jkJqpQ@cipher.nrlssc.navy.mil> <7v8whl7ss9.fsf@alter.siamese.dyndns.org> <MecVLMUB15cEJQiZpwSBg9ysnmFSB1QYZfIQuSOStnFx2KoeScNXGQ@cipher.nrlssc.navy.mil> <7v63cp22cc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, nico@cam.org,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 20:45:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McOFg-0007hW-4Z
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 20:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbZHOSng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 14:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbZHOSng
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 14:43:36 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42014 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751357AbZHOSng (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Aug 2009 14:43:36 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7FIhEVV002386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 15 Aug 2009 11:43:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7FIhBaU029414;
	Sat, 15 Aug 2009 11:43:11 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7v63cp22cc.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-5.462 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126017>



On Fri, 14 Aug 2009, Junio C Hamano wrote:
>
> From: Brandon Casey <drafnel@gmail.com>
> Date: Fri, 14 Aug 2009 17:52:15 -0500
> Subject: [PATCH] block-sha1/sha1.c: silence compiler complaints by casting void * to char *
> 
> Some compilers produce errors when arithmetic is attempted on pointers to
> void.  We want computations done on byte addresses, so cast them to char *
> to work them around.
> 
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Unnecessary outer parentheses, but ack anyway.

		Linus
