From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 4/4] format-patch: add format.cover-letter configuration
Date: Sun, 07 Apr 2013 16:50:08 +0200
Message-ID: <vpqwqsefl9b.fsf@grenoble-inp.fr>
References: <1365318630-11882-1-git-send-email-felipe.contreras@gmail.com>
	<1365318630-11882-5-git-send-email-felipe.contreras@gmail.com>
	<7v4nfi92q1.fsf@alter.siamese.dyndns.org>
	<CAMP44s0rsWCZE=MyW3zuBoVM5ZtEGQQb+deQJB5-i6tBzFdTfw@mail.gmail.com>
	<7vmwta7lx3.fsf@alter.siamese.dyndns.org>
	<CAMP44s1pMLzkQrE1iKmYyj_FOZqkUp46HRQ6kjWfNvOYA5FkVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 16:50:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOqvZ-000460-I5
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 16:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933854Ab3DGOuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 10:50:35 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35454 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761083Ab3DGOue (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 10:50:34 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r37Eo7dD030517
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 7 Apr 2013 16:50:07 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UOqv3-0003dB-2e; Sun, 07 Apr 2013 16:50:09 +0200
In-Reply-To: <CAMP44s1pMLzkQrE1iKmYyj_FOZqkUp46HRQ6kjWfNvOYA5FkVQ@mail.gmail.com>
	(Felipe Contreras's message of "Sun, 7 Apr 2013 04:11:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 07 Apr 2013 16:50:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r37Eo7dD030517
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1365951012.55627@Z//vMO8JhGtcrtcovevz3Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220310>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> So, I'm a user that does 'git format-patch --cover-letter=auto origin'
> so I don't have the format.coverletter=auto configuration. Why? Why am
> I not setting that configuration, and why am I running
> --cover-letter=auto?

The command may well be ran from a script or alias. It is good in
general to give the user/script writer a simple way to get predictible
behavior regardless of the configuration.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
