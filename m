From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] push: avoid suggesting "merging" remote changes
Date: Mon, 08 Jul 2013 15:47:19 +0200
Message-ID: <vpqd2qtkvtk.fsf@anie.imag.fr>
References: <cover.1373223663.git.john@keeping.me.uk>
	<cover.1373223663.git.john@keeping.me.uk>
	<2a6f4a3c31e667aa03b06ce63ae5319a25beaca0.1373223663.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>,
	Philip Oakley <philipoakley@iee.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jul 08 15:47:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwBn8-0000Qt-Ko
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 15:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182Ab3GHNrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 09:47:42 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53753 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183Ab3GHNrl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 09:47:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r68DlI11006343
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 8 Jul 2013 15:47:18 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UwBmh-0006Zv-VY; Mon, 08 Jul 2013 15:47:19 +0200
In-Reply-To: <2a6f4a3c31e667aa03b06ce63ae5319a25beaca0.1373223663.git.john@keeping.me.uk>
	(John Keeping's message of "Sun, 7 Jul 2013 20:02:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 08 Jul 2013 15:47:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r68DlI11006343
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1373896039.45111@vdd9W2m9dIKPFn3q/Qmzkw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229855>

John Keeping <john@keeping.me.uk> writes:

>  static const char message_advice_pull_before_push[] =
>  	N_("Updates were rejected because the tip of your current branch is behind\n"
> -	   "its remote counterpart. Merge the remote changes (e.g. 'git pull')\n"
> -	   "before pushing again.\n"
> +	   "its remote counterpart. Integrate the remote changes (e.g.\n"
> +	   "'git pull ...') before pushing again.\n"

To me, "merge" includes "rebase", so I'd say the merge -> integrate
change is not needed, but I have nothing against it either.

The "..." added are a bit weird with the quotes around. Quotes may
suggest that the content is to be taken literally, which is not the case
anymore. Not a real objection anyway, just thinking aloud.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
