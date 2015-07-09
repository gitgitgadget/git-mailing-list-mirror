From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4] log: add log.follow config option
Date: Thu, 09 Jul 2015 10:38:10 +0200
Message-ID: <vpqfv4xafpp.fsf@anie.imag.fr>
References: <1436377321-8495-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 10:38:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZD7Lc-00071F-0T
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 10:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbbGIIiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 04:38:19 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45495 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064AbbGIIiR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 04:38:17 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t698c9cn023078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 9 Jul 2015 10:38:09 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t698cALS011305;
	Thu, 9 Jul 2015 10:38:10 +0200
In-Reply-To: <1436377321-8495-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 8 Jul 2015 13:42:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 09 Jul 2015 10:38:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t698c9cn023078
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1437035893.36826@sy/1TLbmoIEnhPMB1D16gw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273730>

David Turner <dturner@twopensource.com> writes:

> This version uses tweak, and also includes Matthieu Moy's suggested
> whitespace fix.

This comment should come below the --- after the commit message (right
before the diffstat). Otherwise, Junio will get this as the commit
message when applying, and your actual commit message will be ignored.

> ---
> Many users prefer to always use --follow with logs.  Rather than
> aliasing the command, an option might be more convenient for some.
>
> Junio C Hamano <gitster@pobox.com> suggested using the tweak
> functionality for this, which is much nicer than what I had before.

I would avoid using "what I had before" in the commit message: readers
of "git log" do not know what you had before. OTOH, crediting Junio for
the idea is good.

> Signed-off-by: David Turner <dturner@twopensource.com>
> ---

(This is the place for comments)

>  Documentation/git-log.txt |  6 ++++++
>  builtin/log.c             | 16 ++++++++++++++++
>  diff.c                    |  5 +++--
>  diff.h                    |  1 +
>  t/t4202-log.sh            | 23 +++++++++++++++++++++++
>  5 files changed, 49 insertions(+), 2 deletions(-)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
