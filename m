From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [Opinion gathering] Git remote whitelist/blacklist
Date: Tue, 24 May 2016 14:55:50 +0200
Message-ID: <vpq37p74nu1.fsf@anie.imag.fr>
References: <1040142021.5607762.1463753271105.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<584027154.5608416.1463754104066.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<001001d1b2a3$06d7bbb0$14873310$@nexbridge.com>
	<1929221963.5686879.1464007899902.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<1884904685.12056.1464084750628.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<84BDC4A4-FBE1-4542-868C-FA77A25469F3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Francois Beutin <beutinf@ensimag.grenoble-inp.fr>,
	"Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	wiliam duclot <wiliam.duclot@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 24 14:56:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5BsY-00026Z-Rv
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 14:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932722AbcEXM4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 08:56:00 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40864 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932237AbcEXM4A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 08:56:00 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u4OCtnPw003282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 24 May 2016 14:55:49 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4OCtocV021796;
	Tue, 24 May 2016 14:55:50 +0200
In-Reply-To: <84BDC4A4-FBE1-4542-868C-FA77A25469F3@gmail.com> (Lars
	Schneider's message of "Tue, 24 May 2016 06:55:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Tue, 24 May 2016 14:55:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4OCtnPw003282
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1464699351.60525@GAjt0z0pqv/jxTGnVjXwGQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295493>

Lars Schneider <larsxschneider@gmail.com> writes:

> To answer your question,
> I would reject the push (because the remote is in the denied list) and
> print a warning to point out the conflicting configs to the user.

So, when trying a forbidden push, Git would deny it and the only way to
force the push would be to remove the blacklist from the config, right?

Probably the sanest way to go. I thought about adding a "git push
--force-even-if-in-blacklist" or so, but I don't think the feature
deserves one specific option (hence add some noise in `git push -h`).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
