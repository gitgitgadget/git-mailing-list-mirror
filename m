From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] status: display the SHA1 of the commit being currently
  processed
Date: Mon, 17 Jun 2013 17:10:49 +0200
Message-ID: <51BF26F9.1080900@viscovery.net>
References: <1371471004-9069-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr> <alpine.DEB.2.00.1306171357440.7683@perkele.intern.softwolves.pp.se> <c878cf98bff28ea8b72fb6d33fd9ca85@ensibm.imag.fr> <alpine.DEB.2.00.1306171452340.7683@perkele.intern.softwolves.pp.se> <0b88af05ea8d4723a870476036992abc@ensibm.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>, git@vger.kernel.org,
	gitster@pobox.com,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?UTF-8?B?TWF0aGlldSBMacOpbmFyZC0tTWF5b3I=?= 
	<mathieu.lienard--mayor@ensimag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 17 17:11:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uob59-0003tP-W2
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 17:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299Ab3FQPK4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jun 2013 11:10:56 -0400
Received: from so.liwest.at ([212.33.55.13]:56946 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062Ab3FQPK4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Jun 2013 11:10:56 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Uob50-0004cI-8d; Mon, 17 Jun 2013 17:10:50 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id EDDD91660F;
	Mon, 17 Jun 2013 17:10:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <0b88af05ea8d4723a870476036992abc@ensibm.imag.fr>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228076>

Am 6/17/2013 15:57, schrieb Mathieu Li=C3=A9nard--Mayor:
> Le 2013-06-17 15:54, Peter Krefting a =C3=A9crit :
>> Mathieu Li=C3=A9nard--Mayor:
>>
>>> Actually, at first I dealt with it this way:
>>>
>>> status_printf_ln(s, color,
>>>                 _("Splitting %s while rebasing branch '%s' on '%s'.=
"),
>>>          stopped_sha ? stopped_sha : _("a commit"),
>>>          ....);
>>>
>>> Would this be more suitable for translators ?
>>
>> Not really, the text surrounding "a commit" might need to be
>> inflected differently depending on whether it is a SHA-1 or the "a
>> commit" string. Word order might also be different.
> Okay, I'll use what you suggested then.

That's not a good idea. Do we already use "%1$" style formats elsewhere=
?
I'm afraid that they are not supported everywhere.

-- Hannes
