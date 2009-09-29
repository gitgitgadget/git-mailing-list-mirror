From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: clone from url with email address as username?(escaping @ symbol)
Date: Tue, 29 Sep 2009 16:30:30 +0200
Message-ID: <vpq1vlp962h.fsf@bauges.imag.fr>
References: <970bc7c80909290720i1c5566fer1c1a3db744edc609@mail.gmail.com>
	<fabb9a1e0909290725w616c3ea9vcb1d2c53950f7788@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Bennett <benbennett@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 16:31:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsdjE-0002rj-Lu
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 16:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbZI2Oad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 10:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752802AbZI2Oad
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 10:30:33 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34099 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752765AbZI2Oac (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 10:30:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n8TER3nk020672
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 29 Sep 2009 16:27:03 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Msdio-0007Jk-53; Tue, 29 Sep 2009 16:30:30 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Msdio-0005Cr-3e; Tue, 29 Sep 2009 16:30:30 +0200
In-Reply-To: <fabb9a1e0909290725w616c3ea9vcb1d2c53950f7788@mail.gmail.com> (Sverre Rabbelier's message of "Tue\, 29 Sep 2009 16\:25\:58 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 29 Sep 2009 16:27:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8TER3nk020672
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1254839225.07207@6xGTd+y5EbQwe/1qNhP2uQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129306>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Tue, Sep 29, 2009 at 16:20, Ben Bennett <benbennett@gmail.com> wrote:
>> Is there any escape sequence for the @ symbol when cloning?
>
> I thought @ is not allowed to be in an url? What do you need to
> escape it for?

If your username is "foo@bar.com", then the clone URL might well be

ssh://foo@bar.com@server.com/path/to/repo

The question is which @ is the login/server separator, and which one
is included in the login. A quick test with

git clone ssh://foo@bar.com@localhost/path/to/repo

shows me that Git does the right thing, i.e. uses "foo@bar.com" as the
login, without the need to escape it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
