From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Makefile: introduce NO_PTHREADS
Date: Tue, 02 Dec 2008 08:41:48 +0100
Message-ID: <4934E6BC.9040203@viscovery.net>
References: <4933A058.3050101@viscovery.net> <1228148005-9404-1-git-send-email-mike@abacus.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 08:43:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Puq-0007Ce-5s
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 08:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbYLBHmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 02:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbYLBHmE
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 02:42:04 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:10275 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbYLBHmB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 02:42:01 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L7PtF-0007yt-9E; Tue, 02 Dec 2008 08:41:57 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 00B416D9; Tue,  2 Dec 2008 08:41:48 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <1228148005-9404-1-git-send-email-mike@abacus.co.uk>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "lilzmailsa03.liwest.at", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Mike Ralphson schrieb: > From: Junio C Hamano <gitster@pobox.com>
	> > This introduces make variable NO_PTHREADS for platforms that lack the
	> support for pthreads library or people who do not want to use it for >
	whatever reason. When defined, it makes the multi-threaded index > preloading
	into a no-op, and also disables threaded delta searching by > pack-objects.
	> > Signed-off-by: Junio C Hamano <gitster@pobox.com> > Signed-off-by: Johannes
	Sixt <j6t@kdbg.org> > Signed-off-by: Mike Ralphson <mike@abacus.co.uk> >
	--- [...] 
	Content analysis details:   (-1.4 points, 7.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102124>

Mike Ralphson schrieb:
> From: Junio C Hamano <gitster@pobox.com>
> 
>  This introduces make variable NO_PTHREADS for platforms that lack the
>  support for pthreads library or people who do not want to use it for
>  whatever reason.  When defined, it makes the multi-threaded index
>  preloading into a no-op, and also disables threaded delta searching by
>  pack-objects.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Mike Ralphson <mike@abacus.co.uk>
> ---

You can add

Tested-by: Johannes Sixt <j6t@kdbg.org> (AIX 4.3.x)

-- Hannes
