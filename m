From: =?UTF-8?Q?Mathieu_Li=C3=A9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
Subject: Re: [PATCH] status: display the SHA1 of the commit being currently  processed
Date: Mon, 17 Jun 2013 15:57:33 +0200
Message-ID: <0b88af05ea8d4723a870476036992abc@ensibm.imag.fr>
References: <1371471004-9069-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
 <alpine.DEB.2.00.1306171357440.7683@perkele.intern.softwolves.pp.se>
 <c878cf98bff28ea8b72fb6d33fd9ca85@ensibm.imag.fr>
 <alpine.DEB.2.00.1306171452340.7683@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	<git@vger.kernel.org>, <gitster@pobox.com>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Jun 17 16:02:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uoa0O-0004vZ-V0
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 16:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756344Ab3FQOBx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jun 2013 10:01:53 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60897 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756229Ab3FQOBw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 10:01:52 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5HDvWFr019081
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Jun 2013 15:57:33 +0200
Received: from web-ensimag.imag.fr (web-ensimag.imag.fr [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5HDvYrn013342;
	Mon, 17 Jun 2013 15:57:34 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id r5HDvYf1017618;
	Mon, 17 Jun 2013 15:57:34 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id r5HDvX1n017617;
	Mon, 17 Jun 2013 15:57:33 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to mathieu.lienard--mayor@ensimag.fr using -f
In-Reply-To: <alpine.DEB.2.00.1306171452340.7683@perkele.intern.softwolves.pp.se>
X-Sender: mathieu.lienard--mayor@ensimag.fr
User-Agent: Roundcube Webmail/0.8.1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 17 Jun 2013 15:57:33 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228072>

Le 2013-06-17 15:54, Peter Krefting a =C3=A9crit=C2=A0:
> Mathieu Li=C3=A9nard--Mayor:
>
>> Actually, at first I dealt with it this way:
>>
>> status_printf_ln(s, color,
>>                 _("Splitting %s while rebasing branch '%s' on=20
>> '%s'."),
>> 		 stopped_sha ? stopped_sha : _("a commit"),
>> 		 ....);
>>
>> Would this be more suitable for translators ?
>
> Not really, the text surrounding "a commit" might need to be
> inflected differently depending on whether it is a SHA-1 or the "a
> commit" string. Word order might also be different.
Okay, I'll use what you suggested then.
--=20
Mathieu Li=C3=A9nard--Mayor,
2nd year at Grenoble INP - ENSIMAG
(+33)6 80 56 30 02
