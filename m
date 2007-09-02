From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] rebase--interactive: do not use one-or-more (\+) in sed.
Date: Sun, 02 Sep 2007 08:53:58 +0200
Message-ID: <85abs5v9q1.fsf@lola.goethe.zz>
References: <200709010925.27926.johannes.sixt@telecom.at>
	<7vmyw6u5ca.fsf@gitster.siamese.dyndns.org>
	<7vejhiu565.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 08:54:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRjM3-00017P-Uc
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 08:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181AbXIBGyV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 02:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752842AbXIBGyV
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 02:54:21 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:40793 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752840AbXIBGyU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Sep 2007 02:54:20 -0400
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 9EE4E1E5334;
	Sun,  2 Sep 2007 08:54:18 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id 88C3B28EE1C;
	Sun,  2 Sep 2007 08:54:18 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-038-061.pools.arcor-ip.net [84.61.38.61])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 175B91C331F;
	Sun,  2 Sep 2007 08:54:01 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id ACD171C15372; Sun,  2 Sep 2007 08:53:58 +0200 (CEST)
In-Reply-To: <7vejhiu565.fsf_-_@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Sat\, 01 Sep 2007 02\:05\:22 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4127/Sun Sep  2 06:35:44 2007 on mail-in-05.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57298>

Junio C Hamano <gitster@pobox.com> writes:

> This is a continuation of the other one to avoid one-or-more operator
> in sed.  At the same time, it actually tightens error checking,
> because the numbers in the squash messages are not padded with
> leading zero and cannot begin with 0.
>
> With this, I think we do not have any more use of one-or-more
> (\+) in sed scripts.

Just for the record: I believe that \{1,\} might be portable.

As usual, <URL:info:autoconf#Limitations%20of%20Usual%20Tools> (aka as
(info "(autoconf) Limitations of Usual Tools")
) provides a real horror show of sed variants.

Actually, one can get the cursor right on the spot by typing
info autoconf      (or the respective Emacs command C-h i g (autoconf))
i sed RET

There is something to be said for well-indexed documentation...

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
