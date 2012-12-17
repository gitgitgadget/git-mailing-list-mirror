From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH 0/2] second try
Date: Mon, 17 Dec 2012 16:54:08 +0100
Message-ID: <50CF4020.4090901@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de> <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org> <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5F08.2060705@tu-clausthal.de> <7vpqf91kqo.fsf@alter.siamese.dyndns.org> <4EFAF241.9050806@tu-clausthal.de> <7v39c41keo.fsf@alter.siamese.dyndns.org> <7vpqf8z8a6.fsf@alter.siamese.dyndns.org> <4F00B7F3.1060105@tu-clausthal.de> <4F038E49.9080809@tu-clausthal.de> <7vy5toqqab.fsf@alter.siamese.dyndns.org> <7vmwzzqwud.fsf@alter.siamese.dyndns.org> <509FD4F6.5050606@gym-oha.de> <50B11AF5.2090701@tu-clausthal.
 de> <7vtxsdvug3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 16:54:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkd1Q-0004kX-T9
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 16:54:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626Ab2LQPyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 10:54:10 -0500
Received: from mailrelay1.rz.tu-clausthal.de ([139.174.2.42]:47329 "EHLO
	mailrelay1.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751935Ab2LQPyJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2012 10:54:09 -0500
Received: from hades.rz.tu-clausthal.de (mailrelay1.rz.tu-clausthal.de [139.174.2.42])
	by mailrelay1.rz.tu-clausthal.de (Postfix) with ESMTP id 652B942E2DA;
	Mon, 17 Dec 2012 16:54:06 +0100 (CET)
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 27B5E4220F0;
	Mon, 17 Dec 2012 16:54:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=ZdrLobnNdsLU1rc0kD4Hj9OKSG8=; b=11cb3ixlllXxlsH5eyllmNiheMnm
	ZBx+1sSGTMGihffK1UahfZY3ZI4HL7c81+SKrocZdJzgcbKCkjlA6CLPnWAMFwNJ
	wc2TpCSnK18ZFR9wXSbuL+bjX8PARWagamCowt528IXnh226cKdoWqBYwVzDxZQt
	PGo6Li/xb19UCCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=qfYXeV6HwVpa7ksIGEcUy+haJgtjFdT1mOVk7h3ZnYxwoBNpqdPIYHk
	gd0syWe+QK3Xol5H4/s+hc3Qn8hJThfDCWVY0yKtC6iMX2afah/j7y8/A5V2gvXx
	1Bua1PH6YHRYzQM8Wo1vscqu3afyQo/vNza78tTFrOYe3KOasMLk=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id 218CD4220F3;
	Mon, 17 Dec 2012 16:54:04 +0100 (CET)
Received: from [139.174.242.80] (account sstri@tu-clausthal.de [139.174.242.80] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.8)
  with ESMTPSA id 41957216; Mon, 17 Dec 2012 16:54:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vtxsdvug3.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (8%, '
 MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1000_1099 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, DKIM_SIGNATURE 0, DOMAINKEY_SIG 0, __ANY_URI 0, __BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_FROM 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MOZILLA_USER_AGENT 0, __MULTIPLE_RCPTS_CC_X2 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211688>

Hi,

Am 26.11.2012 05:50 schrieb Junio C Hamano:
> Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:
> 
>> Am 11.11.2012 17:40 schrieb Sven Strickroth:
>>> Am 06.10.2012 20:28 schrieb Junio C Hamano:
>>>> It is either that it was simply forgotten, or after I wrote the part
>>>> you quoted early in January there were discussions later that showed
>>>> the patch was not desirable for some reason. I do not recall which.
>>>
>>> I noticed no threads about possible problems, so I try again.
>>
>> On November 11th I submitted the updated patches again, however, without
>> any reaction or comments.
> 
> I think between Peff and me it fell in the cracks during the
> hand-off; I do not know about the others, probably people did not
> find it interesting perhaps?
> 
> I'll add Eric Wong (git-svn submaintainer) to Cc.

I received no feedback, so is there any progress on this issue?

I'd really appreciate if we could fix it soon.

-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
