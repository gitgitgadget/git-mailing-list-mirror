From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] fast-import: initialize variable require_explicit_termination
Date: Fri, 26 Aug 2011 19:59:59 +0200
Message-ID: <vpqr548hx40.fsf@bauges.imag.fr>
References: <1314378689-8997-1-git-send-email-Matthieu.Moy@imag.fr>
	<7v8vqgdpsv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 26 20:00:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx0ha-0006AM-I9
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 20:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755474Ab1HZSAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 14:00:07 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48498 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755466Ab1HZSAG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 14:00:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p7QHxYSo029436
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 26 Aug 2011 19:59:34 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Qx0hD-000384-C1; Fri, 26 Aug 2011 19:59:59 +0200
In-Reply-To: <7v8vqgdpsv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 26 Aug 2011 10:51:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 26 Aug 2011 19:59:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p7QHxYSo029436
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1314986375.71418@Gd4DqS3piI3mFPVBjLeyOw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180187>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> The uninitialized variable seems harmless in practice, but let's still be clean.
>
> It is not "in practice", but by definition, file scope "static int"
> variables are initialized to 0 by the C language

OK, I didn't know this was specified in C, but you're right.

> Please do not write unnecessary " = 0" there.

I prefer being explicit, but that's a matter of taste, and I don't
really care, so let's drop this patch.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
