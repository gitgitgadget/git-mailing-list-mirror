From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 2/3] branch: mark missing tracking branch as gone
Date: Wed, 21 Aug 2013 09:37:36 +0200
Message-ID: <vpqeh9nh4u7.fsf@anie.imag.fr>
References: <cover.1376618877.git.worldhello.net@gmail.com>
	<7vzjsio99d.fsf@alter.siamese.dyndns.org>
	<cover.1376620130.git.worldhello.net@gmail.com>
	<a4b446b4ff63f56f8203df0723eeb319b2ba58dc.1376620130.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 09:37:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VC2zO-0008G8-VI
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 09:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506Ab3HUHhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 03:37:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60575 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752399Ab3HUHhy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 03:37:54 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7L7baKa023364
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 21 Aug 2013 09:37:36 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VC2z3-000541-8h; Wed, 21 Aug 2013 09:37:37 +0200
In-Reply-To: <a4b446b4ff63f56f8203df0723eeb319b2ba58dc.1376620130.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Fri, 16 Aug 2013 10:29:33 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 21 Aug 2013 09:37:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7L7baKa023364
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1377675457.9052@dikgpdTdJARTQ6mSJEvIyw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232690>

Jiang Xin <worldhello.net@gmail.com> writes:

>     $ git status
>     # On branch topic
>     # Your branch is based on 'topicbase', but the upstream is gone.
>     #   (use "git branch --unset-upstream" to fixup)

Sorry, I didn't follow closely the previous discussions. I'm not sure
"gone" is right either, since the user may just have configured an
upstream that does not exist and never existed. Perhaps "absent" would
be better.

Just a thought, shouldn't block the patch.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
