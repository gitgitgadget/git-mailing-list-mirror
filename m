From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/3] Test environment of git-remote-mw
Date: Sat, 02 Jun 2012 12:47:54 +0200
Message-ID: <vpqipfa9ehx.fsf@bauges.imag.fr>
References: <4FC64B0C.6070507@ensimag.imag.fr>
	<1338547317-26088-1-git-send-email-guillaume.sasdy@ensimag.imag.fr>
	<1338547317-26088-2-git-send-email-guillaume.sasdy@ensimag.imag.fr>
	<vpqmx4n9rq6.fsf@bauges.imag.fr> <4FC8D501.20207@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	git@vger.kernel.org, Charles Roussel <charles.roussel@ensimag.fr>,
	Simon Perrat <Simon.Perrat@ensimag.imag.fr>,
	Charles Roussel <Charles.Roussel@ensimag.imag.fr>,
	Julien Khayat <Julien.Khayat@ensimag.imag.fr>
To: Simon.Cathebras@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Sat Jun 02 12:48:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Salt0-0004y7-1B
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 12:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760357Ab2FBKsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jun 2012 06:48:04 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35475 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760352Ab2FBKsC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2012 06:48:02 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q52AdTJp031493
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 2 Jun 2012 12:39:29 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SalsB-0005Bm-IC; Sat, 02 Jun 2012 12:47:55 +0200
In-Reply-To: <4FC8D501.20207@ensimag.imag.fr> (Simon Cathebras's message of
	"Fri, 01 Jun 2012 16:43:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 02 Jun 2012 12:39:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q52AdTJp031493
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339238372.64657@cLbRf785coVNA9WlskKdRQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199037>

"Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr> writes:

>>> +wiki_getpage () {
>>> +	../test-gitmw.pl get_page -p "$1" "$2"
>>> +}
>> Any reason why test-gitmw.pl and wiki_getpage have this slightly
>> different API? The perl version has a "-p" flag, and the shell command
>> has only positionnal arguments.
> The "-p" flag exists to specify if we have to use the admin login on
> wiki to do the command.

(then, maybe --admin would be a better name?)

> For instance, here we fetch a page from the wiki with Admin privilege.
> Others arguments remains the same.

What I don't understand is why you need the flexibility to choose
between admin and non-admin on the Perl side, and you don't need in on
the shell side.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
