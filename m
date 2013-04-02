From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: ZSH segmentation fault while completing "git mv dir/"
Date: Tue, 02 Apr 2013 19:00:53 +0200
Message-ID: <vpqppyceuka.fsf@grenoble-inp.fr>
References: <vpqd2v686fi.fsf@grenoble-inp.fr> <513DF4D1.6000500@gmail.com>
	<vpq8v5uueug.fsf@grenoble-inp.fr> <513E3190.20100@gmail.com>
	<20130312013736.GB7105@unpythonic.net>
	<vpqwqtdkq9z.fsf@grenoble-inp.fr>
	<CAMP44s3ocY7qpESHCDRdHJBsH1DV+k1Z5OwSqsWndMZd_s6oBQ@mail.gmail.com>
	<vpqwqslgfzf.fsf@grenoble-inp.fr>
	<7va9pgg9p7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 19:12:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN4kq-00051h-3Z
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 19:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762038Ab3DBRLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 13:11:40 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50983 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761999Ab3DBRKr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 13:10:47 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r32H0pwk014369
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 2 Apr 2013 19:00:51 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UN4Zp-0006Je-Ch; Tue, 02 Apr 2013 19:00:53 +0200
In-Reply-To: <7va9pgg9p7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 02 Apr 2013 09:48:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 02 Apr 2013 19:00:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r32H0pwk014369
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1365526855.18994@TQwsOJkQh/m40RT5Iycffw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219804>

Junio C Hamano <gitster@pobox.com> writes:

> Would it help users more to have that as part of the instruction at
> the beginning of contrib/completion/git-completion.zsh where it
> already says "here is how you use it via fpath", than leaving it
> here in the list archive?

Juging from the answers I got, I do not think many people are hit by the
bug, and the problem will anyway disappear as people update their ZSH,
so I'm not sure it's worth the trouble.

This thread is already #1 on google with "git zsh segmentation fault" so
it's not terribly difficult to find.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
