From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: About detached heads
Date: Fri, 14 Mar 2008 11:48:13 +0100
Message-ID: <vpq1w6dvaxe.fsf@bauges.imag.fr>
References: <93c3eada0803140246k53408c74m21f9dc277857202d@mail.gmail.com>
	<9A4AC53D-BCFA-4BEE-BD53-AA7F29781454@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: geoffrey.russell@gmail.com, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 11:50:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja7Ua-0002Tn-3a
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 11:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbYCNKtn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Mar 2008 06:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbYCNKtn
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 06:49:43 -0400
Received: from imag.imag.fr ([129.88.30.1]:64931 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024AbYCNKtm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 06:49:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m2EAmMdD025186
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 14 Mar 2008 11:48:23 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Ja7SP-0002iG-BX; Fri, 14 Mar 2008 11:48:13 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Ja7SP-0001KW-4w; Fri, 14 Mar 2008 11:48:13 +0100
In-Reply-To: <9A4AC53D-BCFA-4BEE-BD53-AA7F29781454@wincent.com> (Wincent Colaiuta's message of "Fri\, 14 Mar 2008 11\:15\:11 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 14 Mar 2008 11:48:24 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77204>

Wincent Colaiuta <win@wincent.com> writes:

> El 14/3/2008, a las 10:46, Geoff Russell escribi=F3:
>
>> This should be simple! I have a series of commits:
>>
>>           1---2---3---4---5
>>
>> I want to go back to 3 but not branch, so I want
>>
>>           1---2---3---4---5---3
>
> How about?
>
>   git cherry-pick the-sha-1-id-of-commit-3

Correct me if I'm wrong, but I believe this will try to re-apply
commit 3 (probably a no-op since commit 3 is already in the history,
perhaps tons of conflicts if 4 and 5 touched the same pieces of code).

The OP wants to keep commit 3, and to revert commits 4 and 5. As
mentionned in other messages, either "git revert" 4 and 5, or just
commit a new revision with the same tree as 3 had.

--=20
Matthieu
