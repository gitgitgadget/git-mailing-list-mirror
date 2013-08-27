From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] git-remote-mediawiki: reset private ref after non-dumb push
Date: Tue, 27 Aug 2013 09:28:15 +0200
Message-ID: <vpqioyrfv8w.fsf@anie.imag.fr>
References: <1376400700-8863-1-git-send-email-Matthieu.Moy@imag.fr>
	<CAMP44s2u1edB3g9GK_kak3Nc-fe4TDBjFU_JqskBW+J0Q9BJrg@mail.gmail.com>
	<vpqa9ka7mku.fsf@anie.imag.fr>
	<CAMP44s3jh4iEbgONaEU0WSCc5YiGYoK8edcgWU6qmUARToVRuw@mail.gmail.com>
	<vpqbo4o3jba.fsf@anie.imag.fr>
	<CAMP44s281qkdMXUM-2P6T+emFajASX6Jyj4nk8_cU5xYJYvdLA@mail.gmail.com>
	<vpq8uzr5y4v.fsf@anie.imag.fr>
	<xmqq61uumnsz.fsf@gitster.dls.corp.google.com>
	<vpqhaeckfbh.fsf@anie.imag.fr>
	<xmqqmwo4ifk1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 09:28:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEDhS-00045k-1b
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 09:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614Ab3H0H2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 03:28:21 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36139 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752082Ab3H0H2V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 03:28:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7R7SE5T025554
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 27 Aug 2013 09:28:14 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VEDhH-0002JS-Hl; Tue, 27 Aug 2013 09:28:15 +0200
In-Reply-To: <xmqqmwo4ifk1.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 26 Aug 2013 09:26:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 27 Aug 2013 09:28:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7R7SE5T025554
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378193296.23402@UO/E2CTBmVq9U/HD3dJ51Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233077>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> git-remote-mediawiki is kind of a special case, as the remote side uses
>> a very different data model, hence it can make sense to export+reimport
>> to get locally what the remote side received.
>
> Hmm, I am not sure how export+reimport would not make sense for
> others like cvs and p4.

Actually, it is essentially what "git svn rebase" does. I guess it would
make even more sense for CVS (I don't know p4, nor git-p4).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
