From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Fix Solaris Workshop Compiler issues
Date: Wed, 14 Nov 2007 16:44:05 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711141640400.2786@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0711142125460.17530@bianca.dialin.t-online.de> <20071114204732.GE3973@steel.home> <7vprycfrk6.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711150011020.4135@bianca.dialin.t-online.de> <20071114232809.GH3973@steel.home>
 <20071115001756.GA25021@atjola.homenet> <7v3av89wq7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>,
	Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 01:45:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsSr9-0005wx-A7
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 01:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756645AbXKOApB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 19:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755640AbXKOApB
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 19:45:01 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36600 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755390AbXKOApA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Nov 2007 19:45:00 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAF0i5rH013998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 Nov 2007 16:44:06 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAF0i5dM002017;
	Wed, 14 Nov 2007 16:44:05 -0800
In-Reply-To: <7v3av89wq7.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-4.737 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65033>



On Wed, 14 Nov 2007, Junio C Hamano wrote:
> 
> Maybe your compiler needs -DFLEX_ARRAY=0 in CFLAGS?

Actually, for old pre-C99 compilers, you're probably better off using 
-DFLEX_ARRAY=1, since a zero-sized array could be considered bogus by 
some.

			Linus
