From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v1] travis-ci: build documentation
Date: Mon, 25 Apr 2016 11:26:02 +0200
Message-ID: <vpqr3duyr85.fsf@anie.imag.fr>
References: <1461314042-3132-1-git-send-email-larsxschneider@gmail.com>
	<vpq37qeovu4.fsf@anie.imag.fr>
	<xmqqinz9pl3l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: larsxschneider@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 11:26:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aucmk-0000gd-VC
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 11:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956AbcDYJ00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 05:26:26 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58344 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753753AbcDYJ0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 05:26:25 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u3P9Q1to011089
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 25 Apr 2016 11:26:01 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u3P9Q2fV010210;
	Mon, 25 Apr 2016 11:26:02 +0200
In-Reply-To: <xmqqinz9pl3l.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 22 Apr 2016 11:14:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Mon, 25 Apr 2016 11:26:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u3P9Q1to011089
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1462181164.86815@SJK3bjGYWt7sWvpzKUXayA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292462>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> larsxschneider@gmail.com writes:
>>
>>> +      if [[ "$TRAVIS_OS_NAME" = linux ]] && [[ "$CC" = gcc ]];
>>
>> [[ is a bashism, and doesn't bring anything here compared to the POSIX
>> [ ... ], or "test" which is prefered in Git's source code.
>>
>> The ; or the newline is not needed either.
>
> Honestly, I didn't know that we were even trying to be pure POSIX,
> avoid bashism or GNUism, or in general to follow our shell scripting
> style in the scriptlet in the .travis.yml file.

I'm not implying that we should absolutely avoid non-POSIX constructs,
just that the conjuction "non-POSIX + not useful" made me prefer to
remain POSIX.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
