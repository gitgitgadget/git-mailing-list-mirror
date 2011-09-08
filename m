From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] send-mail: Add option to sleep between sending each email.
Date: Thu, 08 Sep 2011 22:50:19 +0200
Message-ID: <vpq39g6iws4.fsf@bauges.imag.fr>
References: <1315428191-9769-1-git-send-email-gf@unixsol.org>
	<CALkWK0kH+pD6ymtt9oWLhT0Bftp4EvtrwTtNVw6mjX0aObb-BQ@mail.gmail.com>
	<vpq7h5jtngj.fsf@bauges.imag.fr>
	<7vbouvx8j5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Georgi Chorbadzhiyski <gf@unixsol.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 01:18:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1nrJ-0005wG-Jt
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 01:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354Ab1IHXSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 19:18:08 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56685 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752994Ab1IHXSG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 19:18:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p88KnB8J001075
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 8 Sep 2011 22:49:11 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1R1lYB-0006QL-P3; Thu, 08 Sep 2011 22:50:19 +0200
In-Reply-To: <7vbouvx8j5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 08 Sep 2011 10:12:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 08 Sep 2011 22:51:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p88KnB8J001075
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1316119862.5049@SZiWMlefGj0J6bkK6RETrA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181001>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> There have been discussion (and IIRC a patch) proposing this already in
>> the past. One advantage of sleeping a bit between each email is that it
>> increase the chances for the receiver to receive the emails in the right
>> order.
>
> Huh? Even in the presense of MTAs in the middle that are free to reorder
> messages?

I didn't say it _ensures_ reception in the right order. I said it
increases the chances.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
