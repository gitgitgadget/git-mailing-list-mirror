From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] status: show tracking branch even no difference
Date: Wed, 07 Aug 2013 17:50:08 +0200
Message-ID: <vpqr4e5h55b.fsf@anie.imag.fr>
References: <46fb1948a57990b0ea737401f2d60f654da4bb4f.1375890091.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 07 17:50:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V760N-0003uk-4L
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 17:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880Ab3HGPu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 11:50:27 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51789 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753797Ab3HGPu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 11:50:26 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r77Fo6FQ028709
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 7 Aug 2013 17:50:06 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V7600-0007TJ-DC; Wed, 07 Aug 2013 17:50:08 +0200
In-Reply-To: <46fb1948a57990b0ea737401f2d60f654da4bb4f.1375890091.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Wed, 7 Aug 2013 23:42:01 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 07 Aug 2013 17:50:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r77Fo6FQ028709
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1376495409.28319@FtUez02epS270dSn5LQ6ig
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231832>

Jiang Xin <worldhello.net@gmail.com> writes:

> With this patch, "git status" will report relationship between current
> branch and its upstream counterpart even if there is no difference.
>
>     $ git status
>     # On branch master
>     # Your branch is identical to its tracking branch: 'origin/master'.

Why not, but we try to say "remote-tracking branch" instead of just
"tracking". Adding "remote-" in your wording may make the line a bit
long, but it may be sufficient to say

# Your branch is identical to 'origin/master'

That's consistant with other messages like

# Your branch is ahead of '%s' by %d commits

(And this would deserve a test)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
