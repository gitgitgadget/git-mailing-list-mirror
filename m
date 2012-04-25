From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 4/7] push: introduce new push.default mode "simple"
Date: Wed, 25 Apr 2012 13:01:57 +0200
Message-ID: <vpqsjfsulay.fsf@bauges.imag.fr>
References: <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335253806-9059-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335253806-9059-5-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqd36weewk.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 13:34:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN0U1-000547-0c
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 13:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759067Ab2DYLd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 07:33:59 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37188 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759045Ab2DYLd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 07:33:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q3PAtWqg001562
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 25 Apr 2012 12:55:33 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SMzyw-0000Tq-9i; Wed, 25 Apr 2012 13:01:58 +0200
In-Reply-To: <xmqqd36weewk.fsf@junio.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 24 Apr 2012 18:53:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 25 Apr 2012 12:55:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3PAtWqg001562
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1335956136.83842@COgVcyJuKLJro+t91+WPWA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196311>

Junio C Hamano <gitster@pobox.com> writes:

>> +	if (!short_upstream)
>> +		short_upstream = branch->merge[0]->src;
>> +	/*
>> +	 * Don't show advice for people who explicitely set
>> +	 * push.default.
>> +	 */
>> +	const char *advice_maybe = "";
>
> I've amended this to avoid decl-after-stmt.

Oops, right, I didn't notice the advice_maybe was a declaration.

Thanks for the fix.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
