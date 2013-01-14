From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] rebase --preserve-merges keeps empty merge commits
Date: Mon, 14 Jan 2013 15:12:38 +0100
Message-ID: <vpqpq17zwdl.fsf@grenoble-inp.fr>
References: <1358023561-26773-1-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, phil.hord@gmail.com,
	Neil Horman <nhorman@tuxdriver.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 15:13:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tukmv-0001Cr-8i
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 15:13:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756975Ab3ANONA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 09:13:00 -0500
Received: from mx1.imag.fr ([129.88.30.5]:48089 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756503Ab3ANOM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 09:12:59 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r0EE23Rs013440
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 14 Jan 2013 15:02:03 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TukmE-0007C9-Lx; Mon, 14 Jan 2013 15:12:38 +0100
In-Reply-To: <1358023561-26773-1-git-send-email-hordp@cisco.com> (Phil Hord's
	message of "Sat, 12 Jan 2013 15:46:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 14 Jan 2013 15:02:04 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r0EE23Rs013440
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1358776924.69432@85VZvpUrpvRVIS55KJqocw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213489>

Phil Hord <hordp@cisco.com> writes:

> Subject: [PATCH] rebase --preserve-merges keeps empty merge commits

I would rephrase it as

  rebase --preserve-merges: keep empty merge commits

we usually give orders in commit messages, not state facts (it's not
clear from the existing subject line whether keeping merge commit is the
new behavior or a bug that the commit tries to fix).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
