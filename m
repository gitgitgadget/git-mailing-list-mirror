From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Trying to get GIT running on SCO OpenServer
Date: Wed, 23 Jan 2008 18:50:33 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801231846540.2803@woody.linux-foundation.org>
References: <20080123212613.GN2230@yugib.highrise.ca> <alpine.LSU.1.00.0801232346010.5731@racer.site> <7vsl0oax42.fsf@gitster.siamese.dyndns.org> <4797F902.4000104@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Aidan Van Dyk <aidan@highrise.ca>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 03:51:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHsBf-0006JG-6P
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 03:51:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbYAXCvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 21:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbYAXCvB
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 21:51:01 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51406 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751392AbYAXCvA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2008 21:51:00 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0O2oYTN018046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Jan 2008 18:50:35 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0O2oXrd006473;
	Wed, 23 Jan 2008 18:50:33 -0800
In-Reply-To: <4797F902.4000104@zytor.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.724 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71583>



On Wed, 23 Jan 2008, H. Peter Anvin wrote:
> 
> That's what va_copy() is for.

Well, anybody who has such an old setup that they have a broken vsnprintf, 
I'd expect they don't have va_copy() either. It's C99, I think (although 
there were obviously implementations of it before that).

			Linus
