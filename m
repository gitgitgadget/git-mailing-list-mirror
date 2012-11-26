From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: commit gone after merge - how to debug?
Date: Mon, 26 Nov 2012 14:23:58 +0100
Message-ID: <vpqr4ngsdjl.fsf@grenoble-inp.fr>
References: <CAO1Khk_eugH--wp3s-gr4HTvuRyL=SaWHWtEXCRZ_Ak7+s5U=w@mail.gmail.com>
	<1353935441-ner-9639@calvin>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Igor Lautar <igor.lautar@gmail.com>, git@vger.kernel.org
To: Tomas Carnecky <tomas.carnecky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 14:24:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcyfe-0000EF-Pl
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 14:24:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331Ab2KZNYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 08:24:05 -0500
Received: from mx2.imag.fr ([129.88.30.17]:43202 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754104Ab2KZNYE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 08:24:04 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id qAQDEZfe024943
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 26 Nov 2012 14:14:35 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TcyfG-0005KP-SR; Mon, 26 Nov 2012 14:23:58 +0100
In-Reply-To: <1353935441-ner-9639@calvin> (Tomas Carnecky's message of "Mon,
	26 Nov 2012 13:10:41 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 26 Nov 2012 14:14:35 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: qAQDEZfe024943
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1354540477.12997@HVzJExxzsDabYtm7uZorZg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210443>

Tomas Carnecky <tomas.carnecky@gmail.com> writes:

> On Mon, 26 Nov 2012 14:06:09 +0100, Igor Lautar <igor.lautar@gmail.com> wrote:
>> git log <file modified by commit>
>>  - commit NOT shown in file history any more and file does not have this change
>
> does `git log --full-history <file modified by commit>` show the commit?

The other related question being: does reading the section "History
Simplification" in "man git-log" help? ;-)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
