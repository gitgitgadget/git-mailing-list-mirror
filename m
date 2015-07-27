From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 07/11] ref-filter: add option to match literal pattern
Date: Mon, 27 Jul 2015 14:54:40 +0200
Message-ID: <vpqtwsp92wf.fsf@anie.imag.fr>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
	<1437982035-6658-1-git-send-email-Karthik.188@gmail.com>
	<1437982035-6658-7-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 14:54:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJhvg-0002HH-IF
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 14:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753347AbbG0Mys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 08:54:48 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37273 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752823AbbG0Myr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 08:54:47 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6RCscxA021378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 27 Jul 2015 14:54:39 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6RCsecv011822;
	Mon, 27 Jul 2015 14:54:40 +0200
In-Reply-To: <1437982035-6658-7-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Mon, 27 Jul 2015 12:57:11 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 27 Jul 2015 14:54:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6RCscxA021378
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438606482.18335@uqGKjrX4Smhn8QiZCc3c4w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274676>

Karthik Nayak <karthik.188@gmail.com> writes:

> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -946,6 +946,32 @@ static int commit_contains(struct ref_filter *filter, struct commit *commit)

> +/*
> + * Return 1 if the refname matches one of the patterns, otherwise 0.
>   * A pattern can be path prefix (e.g. a refname "refs/heads/master"
>   * matches a pattern "refs/heads/") or a wildcard (e.g. the same ref
>   * matches "refs/heads/m*",too).

Nit: you used to s/,too/, too/ in the comment in a previous version.

I think I already suggested saying explicitly "... matches a pattern
"refs/heads/" but not "refs/heads/m")", but I won't insist on that. Just
a reminder in case you missed it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
