From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] rebase -i: demonstrate incorrect behavior of post-rewrite hook with exec
Date: Fri, 22 May 2015 08:35:25 +0200
Message-ID: <vpqoald2k7m.fsf@anie.imag.fr>
References: <1432231982-31314-1-git-send-email-Matthieu.Moy@imag.fr>
	<1432231982-31314-2-git-send-email-Matthieu.Moy@imag.fr>
	<CAPig+cRFwruC8DwPhH_=Jb8YAZPB5J2e0F2NBob3zLPGoMLWgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	antoine.delaite@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 22 08:35:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvgYW-0003lS-O2
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 08:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218AbbEVGfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 02:35:36 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35930 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790AbbEVGff (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 02:35:35 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4M6ZPQH009912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 May 2015 08:35:25 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4M6ZPJF017682;
	Fri, 22 May 2015 08:35:25 +0200
In-Reply-To: <CAPig+cRFwruC8DwPhH_=Jb8YAZPB5J2e0F2NBob3zLPGoMLWgA@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 21 May 2015 17:12:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 22 May 2015 08:35:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4M6ZPQH009912
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1432881325.98776@PBHukaNhHVJn4mBS9aS6+g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269692>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +test_expect_failure 'git rebase -i (exec)' '
>> +       git reset --hard D &&
>> +       clear_hook_input &&
>> +       FAKE_LINES="edit 1 exec_false 2" git rebase -i B
>
> Broken &&-chain.

Thanks, will add in v2.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
