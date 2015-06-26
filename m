From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] bisect: revise manpage
Date: Fri, 26 Jun 2015 14:50:16 +0200
Message-ID: <vpqwpyqws53.fsf@anie.imag.fr>
References: <12a2e2d5e545459837b5eb2356cfc2fe4e3ef631.1435317576.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 26 14:50:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8T5R-0001u7-UO
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 14:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbbFZMu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 08:50:26 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36858 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126AbbFZMuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 08:50:25 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5QCoF4N003215
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 26 Jun 2015 14:50:15 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5QCoGwW008727;
	Fri, 26 Jun 2015 14:50:16 +0200
In-Reply-To: <12a2e2d5e545459837b5eb2356cfc2fe4e3ef631.1435317576.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Fri, 26 Jun 2015 13:30:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 26 Jun 2015 14:50:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5QCoF4N003215
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435927816.96829@0O/2WJwXgeVxE9Hg1FZSrQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272776>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> * Remove the "Look for a fix instead of a regression in the code"
>   example, as (1) it was in the "git bisect run" section, but it
>   doesn't use that command, and (2) I think this usage is adequately
>   explained in the "Alternate terms" section.
[...]
> -* Look for a fix instead of a regression in the code
> -+
> -------------
> -$ git bisect start
> -$ git bisect new HEAD    # current commit is marked as new
> -$ git bisect old HEAD~10 # the tenth commit from now is marked as old
> -------------
> -+
> -Let's consider the last commit has a given property, and that we are looking
> -for the commit which introduced this property. For each commit the bisection
> -guide us to, we will test if the property is present. If it is we will mark
> -the commit as new with 'git bisect new', otherwise we will mark it as old.
> -At the end of the bisect session, the result will be the first new commit (e.g
> -the first one with the property).

I disagree with this one: it's in the example section, not bisect run.
The other explanations are nice, but never show the full sequence of
commands so I think an example to sum up does help.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
