From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: get description from repo.git/config
Date: Mon, 06 May 2013 17:42:49 +0200
Message-ID: <vpq1u9kunba.fsf@grenoble-inp.fr>
References: <15tsj20cizd.fsf@tux.uio.no>
	<7vtxmgruhc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Trond Hasle Amundsen <t.h.amundsen@usit.uio.no>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 06 17:43:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZNZM-00025P-R2
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 17:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755234Ab3EFPnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 11:43:13 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34586 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755014Ab3EFPnM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 11:43:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r46FgmeI010127
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 6 May 2013 17:42:48 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UZNYw-0004xQ-AE; Mon, 06 May 2013 17:42:50 +0200
In-Reply-To: <7vtxmgruhc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 06 May 2013 08:36:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 06 May 2013 17:42:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r46FgmeI010127
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1368459772.27527@QUWKLuqOLqlNF0TThjyswg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223464>

Junio C Hamano <gitster@pobox.com> writes:

> Trond Hasle Amundsen <t.h.amundsen@usit.uio.no> writes:
>
>> Hello,
>>
>> The included patch attempts to improve post-receive-email. It's a
>
> Please don't ;-)

More precisely: you should have a look at git-multimail (in directory
contrib/, in branch for now pu/, or from
https://github.com/mhagger/git-multimail) before spending time on
post-receive-email.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
