From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 0/3] completion: refactor and zsh wrapper
Date: Mon, 15 Oct 2012 18:45:08 +0200
Message-ID: <vpqr4oz65wr.fsf@grenoble-inp.fr>
References: <1350229971-9343-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	SZEDER Gabor <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 18:52:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNnuA-000746-Ay
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 18:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674Ab2JOQw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 12:52:27 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35332 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953Ab2JOQw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 12:52:27 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q9FGd2ok024312
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Oct 2012 18:39:02 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TNnmu-00007h-Kh; Mon, 15 Oct 2012 18:45:08 +0200
In-Reply-To: <1350229971-9343-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sun, 14 Oct 2012 17:52:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 15 Oct 2012 18:39:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q9FGd2ok024312
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1350923946.48201@prkzCblsCfQkkiBHnM0reA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207760>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Hi,
>
> Here's a bit of reorganition. I'm introducing a new __gitcompadd helper that is
> useful to wrapp all changes to COMPREPLY. 2nd and 3rd patches show how it's
> useful.
>
> The zsh wrapper is now very very simple, but I haven't received much feedback
> yet. I hope it will get in at some point in time.

I didn't review the code, but I've installed your patch series, and it
seems to work well.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
