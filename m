From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv6 1/3] git-rebase -i: add command "drop" to remove a commit
Date: Tue, 23 Jun 2015 22:22:11 +0200
Message-ID: <vpq8ubamaz0.fsf@anie.imag.fr>
References: <1435009369-11496-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<CAPig+cT+idnGkR0V-UfwbHwvjd_U=zbjHx+so7Jz+4o1XU5eHw@mail.gmail.com>
	<1637608183.731706.1435086079947.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpq1th2p7ka.fsf@anie.imag.fr>
	<392249968.731834.1435087097209.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 23 22:22:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7Ui8-0004GC-9G
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 22:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754910AbbFWUWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 16:22:20 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60068 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754783AbbFWUWS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 16:22:18 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5NKM8t1018990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 23 Jun 2015 22:22:08 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5NKMB3A011544;
	Tue, 23 Jun 2015 22:22:11 +0200
In-Reply-To: <392249968.731834.1435087097209.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Galan Alfonso's message of "Tue, 23 Jun 2015 21:18:17 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 23 Jun 2015 22:22:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5NKM8t1018990
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435695729.9879@Qa9NkDTYCbHkWrKbaPJXsw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272495>

Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:

> I think that the indentation on its own is enough to avoid confusion
>> test_rebase_end () {
>> 	test_when_finished "git checkout master &&
>> 		git branch -D $1 &&
>> 		test_might_fail git rebase --abort" &&
>> 	git checkout -b $1 master
>> }
> but your idea is fine as well, so I'm ok with either way.

Read too quickly, it looks like a mis-indentation (I could laugh at Eric
here, but I made the same confusion when reading the code at first). By
"avoid the confusion" I mean "make it clear it's not a mis-indentation".

Anyway, we're just bikeshedding here. Any version is fine with me.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
