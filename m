From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] gcc constant expression warning...
Date: Sun, 28 Oct 2007 21:37:29 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710282136410.30120@woody.linux-foundation.org>
References: <7vy7dnvd6w.fsf@gitster.siamese.dyndns.org>
 <slrnfi8pj7.mb4.antti-juhani@kukkaseppele.kaijanaho.fi>
 <alpine.LFD.0.999.0710281000260.30120@woody.linux-foundation.org>
 <alpine.LFD.0.9999.0710282053590.22100@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Antti-Juhani Kaijanaho <antti-juhani@kaijanaho.fi>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Oct 29 05:38:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImMO4-0007kn-Ry
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 05:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbXJ2Ehw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 00:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbXJ2Ehv
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 00:37:51 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48563 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751230AbXJ2Ehv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Oct 2007 00:37:51 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9T4bUhs023378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 28 Oct 2007 21:37:31 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9T4bTpw019154;
	Sun, 28 Oct 2007 21:37:30 -0700
In-Reply-To: <alpine.LFD.0.9999.0710282053590.22100@xanadu.home>
X-Spam-Status: No, hits=-3.235 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62599>



On Sun, 28 Oct 2007, Nicolas Pitre wrote:
> 
> The test must also make sure off_t isn't signed, since in that case it 
> can only hold 31 bits.

Sinc eneither 31 _nor_ 32 bits is really enough, it's perfectly fine to 
just check that the size of "off_t" is *bigger* than 4 bytes, which my 
pseudo-patch did.

		Linus
