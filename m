From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Mon, 16 Jul 2007 13:29:38 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707161327120.20061@woody.linux-foundation.org>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de>
 <vpqd4yss1vo.fsf@bauges.imag.fr> <469BC17D.60806@slamb.org>
 <20070716200024.GD16878@cip.informatik.uni-erlangen.de>
 <alpine.LFD.0.999.0707161315120.20061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Scott Lamb <slamb@slamb.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Mon Jul 16 22:31:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAXDv-00022L-GK
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 22:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729AbXGPUbM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 16:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753365AbXGPUbM
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 16:31:12 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49493 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752055AbXGPUbL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 16:31:11 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6GKThtF016303
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2007 13:29:44 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6GKTcFU032323;
	Mon, 16 Jul 2007 13:29:38 -0700
In-Reply-To: <alpine.LFD.0.999.0707161315120.20061@woody.linux-foundation.org>
X-Spam-Status: No, hits=-4.634 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52717>



On Mon, 16 Jul 2007, Linus Torvalds wrote:
>
> [..] mkdir/rmdir have existed as 
> system calls since at least SVR3.

Correction. Apparently since 4.2BSD (1983).

		Linus
