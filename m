From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v17 00/14] port tag.c to use ref-filter APIs
Date: Thu, 10 Sep 2015 18:57:14 +0200
Message-ID: <vpqr3m6nrf9.fsf@scolette.imag.fr>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 18:57:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za5A8-0004oE-V2
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 18:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbbIJQ5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 12:57:25 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43764 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484AbbIJQ5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 12:57:24 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t8AGvDSq001301
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 10 Sep 2015 18:57:13 +0200
Received: from scolette (scolette.imag.fr [129.88.43.86])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8AGvEOR025258;
	Thu, 10 Sep 2015 18:57:14 +0200
In-Reply-To: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Thu, 10 Sep 2015 21:18:16 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 10 Sep 2015 18:57:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8AGvDSq001301
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1442509033.55843@nB9CC1P7fPep+vxBOunaEA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277604>

Karthik Nayak <karthik.188@gmail.com> writes:

> This is part of the series of unifying the code used by
> "git tag -l, git branch -l, git for-each-ref".
>
> The previous version can be found here (version 16):
> article.gmane.org/gmane.comp.version-control.git/277394
>
> Changes in this version:
> * The arguments of the %(align) atom are interchangeable.
> * Small grammatical changes.
> * Small changes in the tests to reflect changes in the align
> atom code.

Clearly, we're almost there. I did a few minor remarks. I suggest
(admitedly, Eric suggested of-list to suggest ;-) ) that you reply to
them by re-sending only individual patches that changed (replying to the
original patch) so that we can check the new patches individually. I
think we can do the finishing touches for each patch in a subthread of
this patch.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
