From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Empty config sections are neither deleted nor reused
Date: Sat, 14 May 2016 17:10:47 +0200
Message-ID: <vpq37pk7k08.fsf@anie.imag.fr>
References: <87r3d6knwo.fsf@bernoul.li>
	<xmqqeg95aor6.fsf@gitster.mtv.corp.google.com>
	<877fewzseg.fsf@bernoul.li>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonas Bernoulli <jonas@bernoul.li>
X-From: git-owner@vger.kernel.org Sat May 14 17:11:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1bDo-0005Ay-Ku
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 17:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbcENPLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2016 11:11:03 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33480 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752370AbcENPLD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 11:11:03 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u4EFAjop013156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 14 May 2016 17:10:45 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4EFAluF014252;
	Sat, 14 May 2016 17:10:47 +0200
In-Reply-To: <877fewzseg.fsf@bernoul.li> (Jonas Bernoulli's message of "Sat,
	14 May 2016 15:21:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Sat, 14 May 2016 17:10:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4EFAjop013156
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1463843447.38469@cBIX8Vc/1WaZJDGczHIvHQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294614>

Jonas Bernoulli <jonas@bernoul.li> writes:

>> The configuration sections can have comments and they are preserved
>> even when they become empty.  Adding something unrelated will still
>> make it appear the stale comment applies to it.
>
> Now that you mention it, I think I have read that before.  Unfortunately
> I forgot about it until you reminded me.  I would still prefer if empty
> sections were removed and/or reused provided no comment is nearby, but
> now that you reminded me why the current behavior is how it is, I can
> live with it.

Junio's explanation must not necessarily be read as "it has to be the
way it is", but more as "getting it right is harder than you think", and
that in turn explains why no one changed the behavior.

Actually, Tanay Abhra's GSoC two years ago included working on this, but
the project had other priorities and the empty sections issue was not
tackled.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
