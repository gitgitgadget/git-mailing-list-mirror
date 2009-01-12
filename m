From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC PATCH 4/3] Add example git-vcs-p4
Date: Mon, 12 Jan 2009 00:41:19 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901120026290.19665@iabervon.org>
References: <alpine.LNX.1.00.0901110336380.19665@iabervon.org> <7vy6xhl1i7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 06:42:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMFZU-00016y-8f
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 06:42:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbZALFlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 00:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbZALFlV
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 00:41:21 -0500
Received: from iabervon.org ([66.92.72.58]:43207 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316AbZALFlU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 00:41:20 -0500
Received: (qmail 29289 invoked by uid 1000); 12 Jan 2009 05:41:19 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jan 2009 05:41:19 -0000
In-Reply-To: <7vy6xhl1i7.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105294>

On Sun, 11 Jan 2009, Junio C Hamano wrote:

> Hmm...
> 
>     CC vcs-p4.o
> cc1: warnings being treated as errors
> vcs-p4.c: In function 'output_data':
> vcs-p4.c:253: warning: format '%d' expects type 'int', but argument 2 has type 'size_t'
> vcs-p4.c: In function 'p4_where':
> vcs-p4.c:291: warning: ISO C90 forbids mixed declarations and code
> vcs-p4.c: In function 'p4_submit':
> vcs-p4.c:363: warning: ISO C90 forbids mixed declarations and code
> vcs-p4.c: In function 'p4_print':
> vcs-p4.c:433: warning: format '%d' expects type 'int', but argument 2 has type 'size_t'
> vcs-p4.c: In function 'p4_change':
> vcs-p4.c:453: warning: ISO C90 forbids mixed declarations and code
> vcs-p4.c: In function 'p4_filelog':
> vcs-p4.c:504: warning: ISO C90 forbids mixed declarations and code
> make: *** [vcs-p4.o] Error 1

I haven't been over the 4/3 stuff for coding style yet. But how do you get 
these warnings? My gcc 4.1.2 doesn't seem to want to complain about 
non-C90 usage except in strict C90 mode, where it gets more upset about 
"inline" all over the place.

	-Daniel
*This .sig left intentionally blank*
