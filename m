From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] clean: confirm before cleaning files and directories
Date: Fri, 26 Apr 2013 18:19:12 +0200
Message-ID: <vpqzjwl9se7.fsf@grenoble-inp.fr>
References: <1826d070612808b301f9295838e226e02d8097ad.1366963586.git.worldhello.net@gmail.com>
	<vpqfvydhfbx.fsf@grenoble-inp.fr>
	<CANYiYbFzEoEgJzKsB_hiKNy2JCxaTDX30wXNjnzComOzJJF_cw@mail.gmail.com>
	<7vbo91z30e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 18:19:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVlNK-00058L-3D
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 18:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756601Ab3DZQTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 12:19:50 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50962 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756590Ab3DZQTs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 12:19:48 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r3QGJAcB017177
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 26 Apr 2013 18:19:10 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UVlMe-0005r9-Gl; Fri, 26 Apr 2013 18:19:12 +0200
In-Reply-To: <7vbo91z30e.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 26 Apr 2013 09:10:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 26 Apr 2013 18:19:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3QGJAcB017177
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1367597952.62923@H34tXfGufMoSNkCailLAog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222538>

Junio C Hamano <gitster@pobox.com> writes:

> "git clean" without -n/f errors out, hinting the availablilty of -n
> while mentioning -f; that is the safety, isn't it?  Once the user
> decides to give -f, the user _wants_ to remove cruft, and it is a
> hinderance to require any further confirmation.

This is only half true: because "git clean" does nothing without -f,
people's fingers get trained to type "git clean -f" without really
thinking about it. Just like people alias rm='rm -i' and then type
"rm -fr *" mechanically.

The nice thing with the confirmation dialog is that it shows the list
before asking (and unlike 'rm -i', it asks only once).

But as I said in another thread, I fully agree that adding the
confirmation by default even with -f is nonsense.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
