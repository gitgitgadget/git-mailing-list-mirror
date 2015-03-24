From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 3/3] t0302: test credential-store support for XDG_CONFIG_HOME
Date: Tue, 24 Mar 2015 10:52:00 +0100
Message-ID: <vpqbnjivi2n.fsf@anie.imag.fr>
References: <1427174429-5876-1-git-send-email-pyokagan@gmail.com>
	<1427174429-5876-3-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 10:52:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaLVZ-0003Q3-Vg
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 10:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbbCXJwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 05:52:21 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37347 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328AbbCXJwU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 05:52:20 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t2O9q08c014685
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Mar 2015 10:52:00 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t2O9q0uX031686;
	Tue, 24 Mar 2015 10:52:00 +0100
In-Reply-To: <1427174429-5876-3-git-send-email-pyokagan@gmail.com> (Paul Tan's
	message of "Tue, 24 Mar 2015 13:20:29 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 24 Mar 2015 10:52:00 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t2O9q08c014685
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1427795521.96242@C2zdLcHEgaFNZZc0GtOkDA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266181>

Paul Tan <pyokagan@gmail.com> writes:

> Matthieu and Eric: I know I said I will try to re-order the patches to
> put the tests before the implementation, but after thinking and trying
> to rewrite the commit messages I realised it seems really weird to me.
> In this patch series, the implementation is split across the first two
> patches. The first patch should use the old tests, and ideally, the new
> tests should be squashed with the second patch because it seems more
> logical to me to implement the tests at the same time as the new
> feature. However, since the tests patch is very long, to make it easier
> to review it is split into a separate patch which is applied after the
> implementation patches.

No problem, your version is very good. I was pointing out alternatives,
but not requesting a change, and your reasoning makes perfect sense.

I had reviewed v4 in details, and checked the diff between v4 and v5.
The whole series is now

Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
