From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] repack: rewrite the shell script in C.
Date: Wed, 21 Aug 2013 15:07:11 +0200
Message-ID: <vpqvc2z8a68.fsf@anie.imag.fr>
References: <5213EF74.7020408@googlemail.com>
	<1377038334-15799-1-git-send-email-stefanbeller@googlemail.com>
	<vpqhaeje8e0.fsf@anie.imag.fr> <5214B852.7090504@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mfick@codeaurora.org, apelisse@gmail.com,
	pclouds@gmail.com, iveqy@iveqy.com, gitster@pobox.com,
	mackyle@gmail.com, j6t@kdbg.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 15:10:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VC8As-0005xA-QG
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 15:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848Ab3HUNKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 09:10:03 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40323 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751843Ab3HUNKB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 09:10:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7LD79oN005435
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 21 Aug 2013 15:07:10 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VC87z-0007Sh-C7; Wed, 21 Aug 2013 15:07:11 +0200
In-Reply-To: <5214B852.7090504@googlemail.com> (Stefan Beller's message of
	"Wed, 21 Aug 2013 14:53:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 21 Aug 2013 15:07:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7LD79oN005435
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1377695233.11971@TpxmVHGRMPl0HQpEJzxpLQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232701>

Stefan Beller <stefanbeller@googlemail.com> writes:

> But as these follow up changes heavily rely on the very first patch
> I will first try to get that right, meaning accepted into pu.
> Then I can send patches with these proposals such as making more
> functions.

I think it's better to get the style right before, to avoid doubling the
review effort (review a hard-to-review patch first, and then re-review a
style-fix one).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
