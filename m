From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [bug?] checkout -m doesn't work without a base version
Date: Thu, 15 Dec 2011 11:42:10 +0100
Message-ID: <m2vcpiw1z1.fsf@igel.home>
References: <4EDBF4D5.6030908@pcharlan.com>
	<7vbormn8vk.fsf@alter.siamese.dyndns.org>
	<4EE8782A.9040507@elegosoft.com>
	<7vhb13qbs6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Schubert <mschub@elegosoft.com>,
	Pete Harlan <pgit@pcharlan.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 11:42:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rb8lZ-00070W-9Z
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 11:42:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758782Ab1LOKmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 05:42:16 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:37126 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753694Ab1LOKmP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 05:42:15 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 379581853B9B;
	Thu, 15 Dec 2011 11:42:11 +0100 (CET)
X-Auth-Info: fQ8es9BMpaftBF9FOrZEWiZ76l5ljux18MM0dJ23zro=
Received: from igel.home (ppp-88-217-127-96.dynamic.mnet-online.de [88.217.127.96])
	by mail.mnet-online.de (Postfix) with ESMTPA id 53A671C00141;
	Thu, 15 Dec 2011 11:42:11 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 02091CA29C; Thu, 15 Dec 2011 11:42:10 +0100 (CET)
X-Yow: This ASEXUAL PIG really BOILS my BLOOD...  He's so..so.....URGENT!!
In-Reply-To: <7vhb13qbs6.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 14 Dec 2011 09:54:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187203>

Junio C Hamano <gitster@pobox.com> writes:

> The variable "mode" is assigned to when we see an stage #2 entry in the
> loop, and we should have updated threeway[1] immediately before doing so.
> If threeway[1] is not updated, we would have already returned before using
> the variable in make_cache_entry().

How can you be sure that ce_stage(ce) ever returns 2?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
