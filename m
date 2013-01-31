From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/7] Undocument deprecated alias 'push.default=tracking'
Date: Thu, 31 Jan 2013 21:08:11 +0100
Message-ID: <vpqwqutw1xw.fsf@grenoble-inp.fr>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-3-git-send-email-Matthieu.Moy@imag.fr>
	<CACBZZX552fnD+u9Zp-BhqDyYWN+OiyvCyub-xjMZ-_GXCG-vQA@mail.gmail.com>
	<7vvcadgss0.fsf@alter.siamese.dyndns.org>
	<20130131190747.GE27340@google.com>
	<7vip6dgmx2.fsf@alter.siamese.dyndns.org>
	<20130131200434.GI27340@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r?= =?iso-8859-1?Q?=F0?= Bjarmason 
	<avarab@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 21:08:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U10RG-0000of-IF
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 21:08:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756718Ab3AaUI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 15:08:29 -0500
Received: from mx2.imag.fr ([129.88.30.17]:49028 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753567Ab3AaUI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 15:08:27 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r0VK898n017742
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 31 Jan 2013 21:08:09 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U10Qe-0004Hp-76; Thu, 31 Jan 2013 21:08:12 +0100
In-Reply-To: <20130131200434.GI27340@google.com> (Jonathan Nieder's message of
	"Thu, 31 Jan 2013 12:04:34 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 31 Jan 2013 21:08:10 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r0VK898n017742
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1360267694.28731@0XgmJ1/dXpKZT19NUufwIQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215161>

Jonathan Nieder <jrnieder@gmail.com> writes:

> How about the following?
>
>     * `nothing` - ...
>     * `matching` - ...
>     * `upstream` - ...
>     * `simple` - ...
>     * `current` - ...
>
>   For compatibility with ancient config files, the following synonym
>   is also supported.  Don't use it.
>
>     * `tracking` - old name for `upstream`

Sounds good to me.

I'm the author of the removal patch, but the patch was just part of a
larger serie explaining push.default, the idea of cleaning up the
obsolete alias came in the discussion and I did it, but I'm fine with
reintroducing it in the doc (as long as it does not disturb new users
too much).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
