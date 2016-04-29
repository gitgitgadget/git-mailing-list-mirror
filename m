From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] travis-ci: build documentation
Date: Fri, 29 Apr 2016 14:21:43 +0200
Message-ID: <vpqeg9o7gh4.fsf@anie.imag.fr>
References: <1461922534-49293-1-git-send-email-larsxschneider@gmail.com>
	<20160429121429.GB27952@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: larsxschneider@gmail.com, git@vger.kernel.org,
	stefan.naewe@atlas-elektronik.com, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 29 14:22:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw7RB-0000A9-N0
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 14:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346AbcD2MWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 08:22:15 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38038 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753026AbcD2MWN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 08:22:13 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u3TCLgMY006154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 29 Apr 2016 14:21:42 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u3TCLhvk011963;
	Fri, 29 Apr 2016 14:21:43 +0200
In-Reply-To: <20160429121429.GB27952@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 29 Apr 2016 08:14:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Fri, 29 Apr 2016 14:21:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u3TCLgMY006154
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1462537302.41377@EzQAjOazgmPA6/GiA5Hoiw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292988>

Jeff King <peff@peff.net> writes:

> On Fri, Apr 29, 2016 at 11:35:34AM +0200, larsxschneider@gmail.com wrote:
>
>> +# The follow numbers need to be adjusted when new documentation is added.
>> +test_file_count html 233
>> +test_file_count xml 171
>> +test_file_count 1 152
>
> This seems like it will be really flaky and a pain in the future. I'm
> not really sure what it's accomplishing, either. The earlier steps would
> complain if something failed to render, wouldn't they? At some point we
> have to have some faith in "make doc".

I agree. My proposal to check for a handful of generated files was just
because this extra paranoia was almost free (just 3 lines of code that
won't need particular maintenance).

In this case, I'm afraid the maintenance cost is much bigger than the
expected benefits.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
