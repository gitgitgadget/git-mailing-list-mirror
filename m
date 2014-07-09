From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 2/2] test-config: Add tests for the config_set API
Date: Wed, 09 Jul 2014 14:10:52 +0200
Message-ID: <vpqegxud96b.fsf@anie.imag.fr>
References: <1404719566-3368-1-git-send-email-tanayabh@gmail.com>
	<1404719566-3368-3-git-send-email-tanayabh@gmail.com>
	<vpqvbr9w154.fsf@anie.imag.fr> <53BD243C.6010907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 14:11:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4qiO-0004TN-5y
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 14:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755831AbaGIMLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 08:11:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33118 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755816AbaGIMLE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 08:11:04 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s69CApov029195
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 9 Jul 2014 14:10:51 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s69CAqg2023984;
	Wed, 9 Jul 2014 14:10:52 +0200
In-Reply-To: <53BD243C.6010907@gmail.com> (Tanay Abhra's message of "Wed, 09
	Jul 2014 16:45:08 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 09 Jul 2014 14:10:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s69CApov029195
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1405512654.95004@qTn6F4nkvFH3N4vilkYsnA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253120>

Tanay Abhra <tanayabh@gmail.com> writes:

> On 7/7/2014 10:34 PM, Matthieu Moy wrote:
>> Tanay Abhra <tanayabh@gmail.com> writes:
>> 
>>> diff --git a/t/t1308-config-hash.sh b/t/t1308-config-hash.sh
>>> new file mode 100755
>>> index 0000000..ad99f8b
>>> --- /dev/null
>>> +++ b/t/t1308-config-hash.sh
>>> +test_expect_success 'setup default config' '
>>> +	cat >.git/config << EOF
>> 
>> Missing && here (sorry, I should have noticed the first time).
>> 
>
> Does a single cat command warrant a `&&`? It errors out when I try
> to add it there.

Ahh, my bad, I didn't notice that cat was the only command in the test.

You're right, no && needed or possible here.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
