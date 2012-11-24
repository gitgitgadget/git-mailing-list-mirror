From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH 0/2] second try
Date: Sat, 24 Nov 2012 20:07:33 +0100
Message-ID: <50B11AF5.2090701@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de> <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org> <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5F08.2060705@tu-clausthal.de> <7vpqf91kqo.fsf@alter.siamese.dyndns.org> <4EFAF241.9050806@tu-clausthal.de> <7v39c41keo.fsf@alter.siamese.dyndns.org> <7vpqf8z8a6.fsf@alter.siamese.dyndns.org> <4F00B7F3.1060105@tu-clausthal.de> <4F038E49.9080809@tu-clausthal.de> <7vy5toqqab.fsf@alter.siamese.dyndns.org> <
  50704BB8.1020603@tu-clausthal.de> <7vmwzzqwud.fsf@alter.siamese.dyndns.org> <509FD4F6.5050606@gym-oha.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 24 20:07:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcL4w-0001th-FL
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 20:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141Ab2KXTHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2012 14:07:32 -0500
Received: from mailrelay2.rz.tu-clausthal.de ([139.174.2.43]:10126 "EHLO
	mailrelay2.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752043Ab2KXTHb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Nov 2012 14:07:31 -0500
Received: from poseidon.rz.tu-clausthal.de (poseidon.rz.tu-clausthal.de [139.174.2.21])
	by mailrelay2.rz.tu-clausthal.de (Postfix) with ESMTP id EDFFE289CC3;
	Sat, 24 Nov 2012 20:07:28 +0100 (CET)
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id D283826D736;
	Sat, 24 Nov 2012 20:07:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=Hoj5z/ciduj869IOEp/Yw+alDEY=; b=W3XyfeoyCd3usYMoozEJ+eDh7NRX
	ZSD4/U8jX2CIV6PUJ1qg+zqvfxdhtkYsVo3wM4uiMX62nWqzzKIYzRzzYw4OqrPD
	bg0wk6iovE4gk2Ab+H26IqRizWCvB9rMkggnjYwjb69Yv5wJb5bzF7v/aW371hPl
	HrV5x3OZ1HDwR5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=mWLMOQki0owq7ncfRo0eSU24IfIXb9Ovbi/PwA/OiXNK7a5bgUZnpbk
	TtNQh9WkCG+2edwzsM/xQjaaKuImCIMdzE+CRc6vL4RHjkAKpsxHqm15VE56veEF
	QaBdE3z1G3x7LDQCJGn04CWCy42OlV2XMAlRoZDuPl1uwoDNliZo=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id 9BDDD26D508;
	Sat, 24 Nov 2012 20:07:28 +0100 (CET)
Received: from [139.174.5.19] (account sstri@tu-clausthal.de [139.174.5.19] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.8)
  with ESMTPSA id 40888279; Sat, 24 Nov 2012 20:07:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <509FD4F6.5050606@gym-oha.de>
X-Enigmail-Version: 1.4.6
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (8%, '
 MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1000_LESS 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, BODY_SIZE_800_899 0, DKIM_SIGNATURE 0, DOMAINKEY_SIG 0, __ANY_URI 0, __BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_FROM 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MOZILLA_USER_AGENT 0, __MULTIPLE_RCPTS_CC_X2 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __URI_NO_MAILTO 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210327>

Hi,

Am 11.11.2012 17:40 schrieb Sven Strickroth:
> Am 06.10.2012 20:28 schrieb Junio C Hamano:
>> It is either that it was simply forgotten, or after I wrote the part
>> you quoted early in January there were discussions later that showed
>> the patch was not desirable for some reason. I do not recall which.
> 
> I noticed no threads about possible problems, so I try again.

On November 11th I submitted the updated patches again, however, without
any reaction or comments.

git pull git://github.com/csware/git.git gitsvn-askpass

Maybe the reason that this was forgotten was, that the git-svn code was
rearranged and splitted into different files in the past and the code
did not apply cleanly any more.

So, what's the status of this issue? It's now open for nearly one year.

-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
