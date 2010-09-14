From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Do not let lstree output recursively when a directory whose name is a prefix of the others is given in the path list.
Date: Tue, 14 Sep 2010 23:22:44 +0200
Message-ID: <vpqmxrk10m3.fsf@bauges.imag.fr>
References: <1284010826-81989-1-git-send-email-davi.reis@gmail.com>
	<vpqzkvr5u73.fsf@bauges.imag.fr>
	<7vhbhwf6q5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davi.reis@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 14 23:24:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvczJ-0003cg-BM
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 23:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755606Ab0INVYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Sep 2010 17:24:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35729 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754141Ab0INVYP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 17:24:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o8ELITGm029049
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 14 Sep 2010 23:18:29 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ovcxg-00046x-G4; Tue, 14 Sep 2010 23:22:44 +0200
In-Reply-To: <7vhbhwf6q5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sat\, 11 Sep 2010 11\:57\:54 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 14 Sep 2010 23:18:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o8ELITGm029049
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1285103914.16504@fBFdvSUHtw2CjU8g4cBGuw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156213>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> That's so close to a real test-case...
>
> Let's do this.
>
>  * t3101 seems somewhat stale; fix the style and add a few missing " &&"
>    cascades as a preparatory patch.
>
>  * Add the "mistaken prefix computation causes unwarranted recursion" fix
>    with a test.

Sounds good, yes.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
