From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 6/6] zlib: zlib can only process 4GB at a time
Date: Sun, 12 Jun 2011 23:46:05 +0200
Message-ID: <vpqfwneraea.fsf@bauges.imag.fr>
References: <1307736948-16956-1-git-send-email-gitster@pobox.com>
	<1307736948-16956-7-git-send-email-gitster@pobox.com>
	<BANLkTikmLDZj2qdkmF-kBUkB33o9EjtBpg@mail.gmail.com>
	<7v4o3uspiy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: kusmabite@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 12 23:46:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVsU9-0002Lw-Q4
	for gcvg-git-2@lo.gmane.org; Sun, 12 Jun 2011 23:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841Ab1FLVqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2011 17:46:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34614 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753302Ab1FLVqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2011 17:46:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p5CLk3gU013453
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 12 Jun 2011 23:46:03 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QVsTu-00035B-3o; Sun, 12 Jun 2011 23:46:06 +0200
In-Reply-To: <7v4o3uspiy.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 12 Jun 2011 14:33:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 12 Jun 2011 23:46:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p5CLk3gU013453
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1308519966.11121@D4f9lm3cFPqn8qAdHdcM3g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175669>

Junio C Hamano <gitster@pobox.com> writes:

> Implementation of git on 32-bit platforms has always been limited to 4GB
> from day one. This topic is not about changing it.

Erik's remark was about Win64, not about 32-bit.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
