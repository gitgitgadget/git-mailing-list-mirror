From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v11 06/10] bisect: don't mix option parsing and non-trivial code
Date: Tue, 30 Jun 2015 13:46:16 +0200
Message-ID: <vpq7fqla06v.fsf@anie.imag.fr>
References: <1435592435-27914-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435592435-27914-7-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqbnfy9s3v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 13:46:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9tzq-0005Yd-EV
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 13:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350AbbF3Lqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 07:46:34 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53821 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750940AbbF3Lqc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 07:46:32 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5UBkERS011049
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Jun 2015 13:46:14 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5UBkG0u021863;
	Tue, 30 Jun 2015 13:46:16 +0200
In-Reply-To: <xmqqbnfy9s3v.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 29 Jun 2015 13:28:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 30 Jun 2015 13:46:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5UBkERS011049
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436269579.21615@p0avOpWDdddYYf0flcEkZw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273041>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu, are you allowing your editor to corrupt the number of
> lines in the hunk on the @@ ... @@ hunk header?  "diff" mode in
> Emacs does that,

Indeed. There's magic in Emac's diff-mode to keep the header up to date,
but it seems totally buggy. I manually deleted a tab (no line added, no
line removed) and it changed the number of lines in the header.

I see that you still managed to apply the series in pu, thanks and sorry
for the inconvenience.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
