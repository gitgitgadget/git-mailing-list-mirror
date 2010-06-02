From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git locate
Date: Wed, 02 Jun 2010 13:27:52 +0200
Message-ID: <vpqwruhwu6f.fsf@bauges.imag.fr>
References: <43d8ce651001191717l58d10919j691f4e5b056fe9b5@mail.gmail.com>
	<alpine.DEB.1.00.1001200224270.4985@pacific.mpi-cbg.de>
	<m3zl49bk0o.fsf@localhost.localdomain>
	<alpine.DEB.1.00.1001201021060.31129@intel-tinevez-2-302>
	<4B579BA8.8050000@gmail.com>
	<fabb9a1e1002150520v29cf8d59ke27cde3e9697b011@mail.gmail.com>
	<AANLkTim6cLkr5BFTRTh2nZGwsfVgHZi3M-b9IER8dHf3@mail.gmail.com>
	<AANLkTil38OLw3J6ZPvv2wNu98QuTXJKtNwRZP0NDZPWn@mail.gmail.com>
	<80y6ex3f8b.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>
To: Bruce Stephens <bruce.stephens@isode.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 13:28:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJm79-000418-NC
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 13:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757636Ab0FBL16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 07:27:58 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34755 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616Ab0FBL16 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 07:27:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o52BKVug010415
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 2 Jun 2010 13:20:31 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OJm6y-0003Bi-PM; Wed, 02 Jun 2010 13:27:52 +0200
In-Reply-To: <80y6ex3f8b.fsf@tiny.isode.net> (Bruce Stephens's message of "Wed\, 02 Jun 2010 11\:23\:32 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 02 Jun 2010 13:20:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o52BKVug010415
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1276082434.20696@k5DOTcqeKFe5D1Q9fkopig
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148244>

Bruce Stephens <bruce.stephens@isode.com> writes:

> John Tapsell <johnflux@gmail.com> writes:
>
> [...]
>
>> Actually could someone help me with this.. the trouble is that this
>> returns paths relative to the root.
>>
>> Can I get it to find all the files, but relative to where I am now?
>
> Something like this is probably part of the answer, which allows an
> alias like this to work:
>
> 	locate = !cd $GIT_CWD && sh -c 'git ls-files "*$1*"' -

There's a patch pending to do more or less the same thing:

  http://thread.gmane.org/gmane.comp.version-control.git/146360/focus=146450

Read Junio's reply there:

  http://thread.gmane.org/gmane.comp.version-control.git/146360/focus=146450

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
