From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [ANNOUNCE] Git v1.8.2-rc0
Date: Tue, 19 Feb 2013 08:44:16 +0100
Message-ID: <vpqliaku4rz.fsf@grenoble-inp.fr>
References: <7vk3q6e94s.fsf@alter.siamese.dyndns.org>
	<vpq4nh9v5an.fsf@grenoble-inp.fr>
	<7vobfh8bjc.fsf@alter.siamese.dyndns.org>
	<7vk3q58987.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Tue Feb 19 08:44:55 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1U7hsk-0007DB-AO
	for glk-linux-kernel-3@plane.gmane.org; Tue, 19 Feb 2013 08:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757937Ab3BSHo1 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 19 Feb 2013 02:44:27 -0500
Received: from mx1.imag.fr ([129.88.30.5]:47858 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754723Ab3BSHoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Feb 2013 02:44:25 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r1J7iGqH007367
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 19 Feb 2013 08:44:16 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U7hs8-0001cg-Su; Tue, 19 Feb 2013 08:44:16 +0100
In-Reply-To: <7vk3q58987.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 18 Feb 2013 15:59:04 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 19 Feb 2013 08:44:16 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1J7iGqH007367
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1361864661.46103@XhQ8OZ7Kyl0E5NqLQhbCeQ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216572>

Junio C Hamano <gitster@pobox.com> writes:

> +At Git 2.0 (not *this* one), we
> +plan to change these commands without pathspec to operate on the
> +entire tree, and training your fingers to type "." will protect you
> +against the future change.

My understanding of the plan was more to forbid argumentless git -u|-A
at Git 2.0 (this is the potentially harmful change), and then to
re-allow it with different semantics later.

But I'm OK with changing directly too, as long as we have warned for
some time before, and will continue to warn after for some time too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
