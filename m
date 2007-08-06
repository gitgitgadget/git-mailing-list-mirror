From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when contents are unchanged
Date: Mon, 06 Aug 2007 22:05:04 +0200
Message-ID: <vpqr6mgwhsf.fsf@bauges.imag.fr>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<vpqhcni47ek.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021050500.14781@racer.site>
	<vpqbqdq45ua.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021147110.14781@racer.site>
	 =?ISO-8859-1?Q?=20<AF1190=04E2-A0F4-?= =?ISO-8859-1?Q?479F-B0A1-50B2C7?= =?ISO-8859-1?Q?278995?=
	=?ISO-8859-1?Q?@yahoo.ca>?=
	<Pine.LNX.4.64.0708021541520.14781@racer.site>
	<46B1F3F4.5030504@midwinter.com>
	<Pine.LNX.4.64.0708021614420.14781@racer.site>
	<20070803053717.GA16379@midwinter.com>
	<7v3az1qgdg.fsf@assigned-by-dhcp.cox.net>
	 =?ISO-8859-1?Q?=20<Pine=04.LNX.4.64.?= =?ISO-8859-1?Q?0708031121000.14?= =?ISO-8859-1?Q?781@ra?=
	=?ISO-8859-1?Q?cer.site>?=
	<7vir7wmk84.fsf@assigned-by-dhcp.cox.net>
	<86bqdkbq59.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 06 22:05:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II8pk-000405-12
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 22:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754387AbXHFUFl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 16:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756857AbXHFUFk
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 16:05:40 -0400
Received: from imag.imag.fr ([129.88.30.1]:47018 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753593AbXHFUFj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 16:05:39 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l76K54vW018724
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 6 Aug 2007 22:05:04 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1II8p6-0006Hf-9h; Mon, 06 Aug 2007 22:05:04 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1II8p6-0003wa-79; Mon, 06 Aug 2007 22:05:04 +0200
Mail-Followup-To: David Kastrup <dak@gnu.org>, git@vger.kernel.org
In-Reply-To: <86bqdkbq59.fsf@lola.quinscape.zz> (David Kastrup's message of "Mon\, 06 Aug 2007 18\:10\:10 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 06 Aug 2007 22:05:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55169>

David Kastrup <dak@gnu.org> writes:

> Ack, ack, ack.  The current default behavior is plainly unusable.  For
> example, I've rsynced -a a tree including .git, and suddenly git-diff
> goes out of kilter.  And stops doing so when running git-status
> once.

Unfortunately, the patch solves the "large and irrelevant output" of
git-diff, but not the performance problem (see the rest of the thread,
I failed to convince Junio that updating the index was a performance
improvement while keeping the same user semantics).

-- 
Matthieu
