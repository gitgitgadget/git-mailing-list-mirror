From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] push: start warning upcoming default change for push.default
Date: Fri, 22 Jun 2012 09:57:36 +0200
Message-ID: <vpqlijfrd73.fsf@bauges.imag.fr>
References: <7vbokeyie3.fsf@alter.siamese.dyndns.org>
	<1340195750-846-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vehp9x3yz.fsf@alter.siamese.dyndns.org>
	<vpqpq8t96zw.fsf@bauges.imag.fr>
	<7va9zxvkyp.fsf@alter.siamese.dyndns.org>
	<7v62alvk2e.fsf@alter.siamese.dyndns.org>
	<vpqd34su0io.fsf@bauges.imag.fr>
	<7vobocsipo.fsf@alter.siamese.dyndns.org>
	<vpq62aksicy.fsf@bauges.imag.fr>
	<7vk3z0shri.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 09:57:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShykW-0003x6-Ke
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 09:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761567Ab2FVH5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 03:57:44 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47663 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761559Ab2FVH5o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 03:57:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5M7vDZC016142
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 22 Jun 2012 09:57:13 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1ShykL-0001NT-8a; Fri, 22 Jun 2012 09:57:37 +0200
In-Reply-To: <7vk3z0shri.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 21 Jun 2012 10:21:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 22 Jun 2012 09:57:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5M7vDZC016142
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340956636.10075@RcapZuSM50lFu2hG5GWipA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200423>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Re-read the part you omitted with [...].  Doesn't it say something
>>> about "only available"?
>>
>> It does, but it seems you're trying hard to avoid telling the user "you
>> should use 'current'", where 'current' is the only reasonable option for
>> this user. I still don't understand what problem you're trying to solve.
>
> I am avoiding to say "you should use simple/current".  Choice
> between matching and simple/current is for the user to make (mostly
> dictated by the project's workflow) and we cannot make a suggestion
> better than what user knows.
>
> Choice between simple and current is mechanically derivable. If the
> user also uses older version of git, simple is not an option.

I do agree with that. My message tells the user to use 'current' instead
of 'simple' when not appropriate, not to use 'current' instead of
'matching', which would indeed be a nonsense. I thought it was clear
enough, but we can make that more explicit. How about:

  (the 'simple' mode was introduced in Git 1.7.11. Use the similar mode
  'current' instead of 'simple' if you sometimes use older versions of Git)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
