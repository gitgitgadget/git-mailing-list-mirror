From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] builtin/receive-pack.c: use parse_options API
Date: Wed, 02 Mar 2016 09:23:46 +0100
Message-ID: <vpqsi09xp7x.fsf@anie.imag.fr>
References: <1456846560-9223-1-git-send-email-tigerkid001@gmail.com>
	<1456846560-9223-1-git-send-email-tigerkid001@gmail.com>
	<1456863661-22783-1-git-send-email-tigerkid001@gmail.com>
	<vpqvb56yltc.fsf@anie.imag.fr>
	<xmqq4mcp7t28.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Sidhant Sharma \[\:tk\]" <tigerkid001@gmail.com>,
	git@vger.kernel.org, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 09:24:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab24f-0002Tc-VB
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 09:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711AbcCBIX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 03:23:56 -0500
Received: from mx1.imag.fr ([129.88.30.5]:50131 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753692AbcCBIXz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 03:23:55 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u228NjEH018946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 2 Mar 2016 09:23:46 +0100
Received: from anie (ensi-vpn-229.imag.fr [129.88.57.229])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u228Nk7Q027820;
	Wed, 2 Mar 2016 09:23:46 +0100
In-Reply-To: <xmqq4mcp7t28.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 01 Mar 2016 14:05:19 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 02 Mar 2016 09:23:46 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u228NjEH018946
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1457511829.00598@YIwMWerw+xXVUnUJFQp9Zg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288105>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> "Sidhant Sharma [:tk]" <tigerkid001@gmail.com> writes:
>>
>>> Make receive-pack use the parse_options API,
>>> bringing it more in line with send-pack and push.
>>
>> Thanks. This version looks good to me.
>
> I'll queue this with your "Reviewed-by:" to 'pu', just as a
> Microproject reward ;-).  Given that the program will never see an
> interactive use from a command line, however, I am not sure if it is
> worth actually merging it down thru 'next' to 'master'.

Git can certainly live without this patch and users won't see any
difference indeed. But the slight code reduction might be worth it:

 builtin/receive-pack.c | 53 +++++++++++++++++++-------------------------------
 1 file changed, 20 insertions(+), 33 deletions(-)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
