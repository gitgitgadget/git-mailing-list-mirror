From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Mon, 22 Apr 2013 14:36:49 +0200
Message-ID: <vpqip3eoi72.fsf@grenoble-inp.fr>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
	<vpqa9oqpxx7.fsf@grenoble-inp.fr>
	<CALkWK0nMgbZY7E-wPNj2C7W98Y4HtQ7Hss6uMKngajB5iJrjDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 14:36:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUFzP-0006iW-1l
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 14:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435Ab3DVMgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 08:36:55 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37000 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752840Ab3DVMgy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 08:36:54 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r3MCamvA010178
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 22 Apr 2013 14:36:48 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UUFzF-0002ta-TM; Mon, 22 Apr 2013 14:36:49 +0200
In-Reply-To: <CALkWK0nMgbZY7E-wPNj2C7W98Y4HtQ7Hss6uMKngajB5iJrjDw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 22 Apr 2013 17:59:25 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 22 Apr 2013 14:36:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3MCamvA010178
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1367239009.042@5Rdhe9yEbx9LMFtQjAufhw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222010>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Matthieu Moy wrote:
>> This is somehow expected: the subtree merge changed the filename during
>> merge (it is subtree/file.txt after the merge, and just file.txt
>> before), so "git log" without --follow just considers the file appeared.
>
> No, a merge does not "change" any filenames.

Read again my message, especially the "it is subtree/file.txt after the
merge, and just file.txt before" part. Replace "subtree" with "bar" and
"file.txt" with "ichi".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
