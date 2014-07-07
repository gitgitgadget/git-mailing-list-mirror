From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 2/2] test-config: Add tests for the config_set API
Date: Mon, 07 Jul 2014 09:11:37 +0200
Message-ID: <vpqvbr91w46.fsf@anie.imag.fr>
References: <1404631162-18556-1-git-send-email-tanayabh@gmail.com>
	<1404631162-18556-3-git-send-email-tanayabh@gmail.com>
	<CALkWK0n9MWux3tA02n-hDvPjXt3Q1RCVd+x8tJV9ABjndaGQCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tanay Abhra <tanayabh@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 09:11:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X435f-0005RZ-QN
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 09:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbaGGHLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 03:11:51 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55863 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255AbaGGHLt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 03:11:49 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s677BaUk032652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 7 Jul 2014 09:11:36 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s677Bb2K026405;
	Mon, 7 Jul 2014 09:11:37 +0200
In-Reply-To: <CALkWK0n9MWux3tA02n-hDvPjXt3Q1RCVd+x8tJV9ABjndaGQCQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Sun, 6 Jul 2014 19:24:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 07 Jul 2014 09:11:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s677BaUk032652
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1405321897.45393@F04debAudcmlcg8NbmOMbQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252958>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> A couple of quick nits.
>
> Tanay Abhra wrote:
>> +test_expect_success 'clear default config' '
>> +       rm -f .git/config
>> +'
>
> Unnecessary; a fresh temporary directory is created for each test run.

Hmm, fresh, but not empty.

Anyway, the next test does a cat > on this file, so it will erase its
content, so the "rm -f" is actually not needed.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
