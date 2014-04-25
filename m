From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Harmful LESS flags
Date: Fri, 25 Apr 2014 08:56:01 +0200
Message-ID: <vpqfvl1rj7i.fsf@anie.imag.fr>
References: <4dc69237123e8962b2b2b901692ea78e.id@mailtor>
	<87lhuvb9kr.fsf@fencepost.gnu.org>
	<xmqqha5iv9eb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Kastrup <dak@gnu.org>, d9ba@mailtor.net, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 08:57:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wda4C-0007fe-TR
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 08:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbaDYG44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 02:56:56 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33773 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997AbaDYG4z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 02:56:55 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s3P6u1c7013507
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 Apr 2014 08:56:01 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3P6u1lq024200;
	Fri, 25 Apr 2014 08:56:01 +0200
In-Reply-To: <xmqqha5iv9eb.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 24 Apr 2014 12:02:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 25 Apr 2014 08:56:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3P6u1c7013507
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1399013762.77827@dmvKuTzqbiXt/G261me9fw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247033>

Junio C Hamano <gitster@pobox.com> writes:

> I am not opposed to changing the default in the longer term, as long
> as we have a solid transition plan to ensure that it won't disrupt
> and/or upset existing users too much.

I am personally in favor of changing the default to drop the S. Silently
hiding stuff from the user's eyes is really bad. With good coding
standard and reasonable terminal size, it actually doesn't matter. And
on projects actually containing very long lines (e.g. some people write
LaTeX code with whole paragraphs for each lines), showing only the
beginning of the line (i.e. the first line of the paragraph in my
LaTeX example) isn't very useful.

I do not think we particularly need a transition plan here: it's purely
a user-interface thing, not something that may break any script or other
tool. Changing the default and documenting the way to return to the old
default in release notes and in the manual would be sufficient IMHO.

GUI usually don't warn when the shape of a button is going to change in
the next version ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
