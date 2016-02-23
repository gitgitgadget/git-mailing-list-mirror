From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/5] README.md: add hyperlinks on filenames
Date: Tue, 23 Feb 2016 20:52:48 +0100
Message-ID: <vpqwppvfblb.fsf@anie.imag.fr>
References: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr>
	<1456249229-30454-3-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqio1f1bw7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, emma.westby@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 20:52:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYJ0z-0004l8-9e
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 20:52:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754630AbcBWTwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 14:52:54 -0500
Received: from mx1.imag.fr ([129.88.30.5]:39383 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753249AbcBWTwx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 14:52:53 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1NJqk9J016962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 23 Feb 2016 20:52:46 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NJqm49014364;
	Tue, 23 Feb 2016 20:52:48 +0100
In-Reply-To: <xmqqio1f1bw7.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 23 Feb 2016 11:10:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 23 Feb 2016 20:52:47 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1NJqk9J016962
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1456861967.48813@JL+tfPJyiFypM63w4ElKfg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287108>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>>  README.md | 19 +++++++++++++------
>>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> Makes sense, provided if we want to do Markdown.

I'd say it the other way around: declaring README as markdown costs
almost nothing and doesn't harm source code readability. This patch
slightly decreases the source's readability so we may want to drop it.

> If I were pushing this topic (i.e. cater to those who browse at
> GitHub, not with "less" in the source tree), I'd have further made
> these links to the preformatted documentation at git-scm.com; I
> expected the later steps in this series to do that, but it seems you
> stopped short of it for some reason.

I tried to keep the spirit of the README as "this is the entry point to
the source code" rather than "this is the new homepage of Git" (as some
project do on GitHub, but we have such a nice git-scm.com ...).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
