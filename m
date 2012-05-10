From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 6/8] apply: fall back on three-way merge
Date: Thu, 10 May 2012 17:41:04 +0200
Message-ID: <vpq1ums2gdr.fsf@bauges.imag.fr>
References: <1336629745-22436-1-git-send-email-gitster@pobox.com>
	<1336629745-22436-7-git-send-email-gitster@pobox.com>
	<vpqy5p0bioh.fsf@bauges.imag.fr>
	<7v4nrooyv1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 10 17:42:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSVVb-0004JE-0i
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 17:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919Ab2EJPmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 11:42:22 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43505 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899Ab2EJPmV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 11:42:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q4AFXmvu003817
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 10 May 2012 17:33:48 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SSVUH-0007xQ-8G; Thu, 10 May 2012 17:41:05 +0200
In-Reply-To: <7v4nrooyv1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 10 May 2012 08:10:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 10 May 2012 17:33:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4AFXmvu003817
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1337268830.37779@ScCrfkDwAaBKdP7lKpTXsQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197587>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> What happens if there are multiple objects for the same pre_sha1?
>
> [...]The usefulness of -3 is limited to only two cases
> in practice, and neither case gives you a big chance of seeing such a
> collision. 

Ah, OK, I missed the fact that the index line was using
find_unique_abbrev(), not a fix number of characters. Thanks for the
clarification.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
