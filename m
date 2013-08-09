From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git status resets permissions on index file -- Ubuntu 12.04 64b
Date: Fri, 09 Aug 2013 14:58:20 +0200
Message-ID: <vpqa9krja1f.fsf@anie.imag.fr>
References: <CACO0oR7a1-fUASQ+SJVbH1CU8d=NbHrK0MuMu+9Pr4_=7q85Vw@mail.gmail.com>
	<52040F27.4050908@googlemail.com> <20130808221807.GA8518@gmail.com>
	<C525FA0D-D22C-4C78-8C97-45819FD58DD7@gmail.com>
	<CACO0oR7tJNKWA=cynBA8R2kaGr2iKNCiCmXKLur9nub6pnBG0g@mail.gmail.com>
	<8761vf3uml.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Justin Collum <jcollum@gmail.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	Andrew Ruder <andy@aeruder.net>, Git List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Aug 09 14:58:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7mH4-00009v-0v
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 14:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966786Ab3HIM6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 08:58:30 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42321 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757403Ab3HIM63 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 08:58:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r79CwJHe012630
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 9 Aug 2013 14:58:19 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V7mGr-0006Uj-0v; Fri, 09 Aug 2013 14:58:21 +0200
In-Reply-To: <8761vf3uml.fsf@igel.home> (Andreas Schwab's message of "Fri, 09
	Aug 2013 14:40:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 09 Aug 2013 14:58:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r79CwJHe012630
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1376657901.73497@k3f7SNbgdAOSthib9i8c9g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231978>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Justin Collum <jcollum@gmail.com> writes:
>
>>      sudo chmod 644 ./.git/index
>
> That doesn't make sense.  If you are the owner of the file, why do you
> need sudo???

I suspect that some over-use of "sudo" resulted in files or directories
belonging to root. What does

  find . -user 0

say?

(As a developer, you should never need sudo. You should only need in as
an administrator of your machine.)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
