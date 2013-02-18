From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [ANNOUNCE] Git v1.8.2-rc0
Date: Mon, 18 Feb 2013 19:35:28 +0100
Message-ID: <vpq4nh9v5an.fsf@grenoble-inp.fr>
References: <7vk3q6e94s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Mon Feb 18 19:36:27 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1U7VZd-0008M4-9c
	for glk-linux-kernel-3@plane.gmane.org; Mon, 18 Feb 2013 19:36:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451Ab3BRSfk (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 18 Feb 2013 13:35:40 -0500
Received: from mx1.imag.fr ([129.88.30.5]:43763 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753000Ab3BRSfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Feb 2013 13:35:38 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r1IIZR2Y001732
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 18 Feb 2013 19:35:27 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U7VYn-0002QC-3K; Mon, 18 Feb 2013 19:35:29 +0100
In-Reply-To: <7vk3q6e94s.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 17 Feb 2013 16:52:19 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 18 Feb 2013 19:35:27 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1IIZR2Y001732
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1361817330.90879@G+P747OSOFDj+BbLePvLQA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216492>

Junio C Hamano <gitster@pobox.com> writes:

> Git v1.8.2 Release Notes (draft)
> ========================
>
> Backward compatibility notes
> ----------------------------
>
> In the upcoming major release (tentatively called 1.8.2), we will
> change the behavior of the "git push" command.
>
> When "git push [$there]" does not say what to push, we have used the
> traditional "matching" semantics so far (all your branches were sent
> to the remote as long as there already are branches of the same name
> over there).  We will use the "simple" semantics

I don't understand: wasn't this supposed to happen in Git 2.0? Did you
mean "In the upcoming major release (tentatively called *2.0*)"?

Also, you may want to mention the argumentless "git add -u" change too.
It currently has an item below, but this is a future
backward-incompatible change so it may deserve to appear in this section
too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
