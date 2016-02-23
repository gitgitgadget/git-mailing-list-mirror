From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 4/5] README.md: don't call git stupid in the title
Date: Tue, 23 Feb 2016 21:51:06 +0100
Message-ID: <vpqmvqrf8w5.fsf@anie.imag.fr>
References: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr>
	<1456249229-30454-5-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqegc31br3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, emma.westby@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 21:51:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYJvQ-0000Tm-15
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 21:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289AbcBWUvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 15:51:12 -0500
Received: from mx2.imag.fr ([129.88.30.17]:50217 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755051AbcBWUvM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 15:51:12 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NKp4Ie004323
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 23 Feb 2016 21:51:04 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NKp67d014799;
	Tue, 23 Feb 2016 21:51:06 +0100
In-Reply-To: <xmqqegc31br3.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 23 Feb 2016 11:13:04 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 23 Feb 2016 21:51:04 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1NKp4Ie004323
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1456865464.90207@/xCHYRkrMlgKA59iomqoKQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287115>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> "the stupid content tracker" was true in the early days of Git, but
>> hardly applicable these days. "fast, scalable, distributed" describes
>> Git more accuralety.
>>
>> Also, "stupid" can be seen as offensive by some people. Let's not use it
>> in the very first words of the README.
>>
>> The new formulation is taken from the description of the Debian package.
>>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>
> This self-derogatory reference shouldn't offend those who didn't
> help write it.
>
> Having said that, I agree with the spirit of 4/5 and 5/5; but it is
> sad that this line is not resurrected by 5/5 in some way.

Do you mean something like this:

diff --git a/README.md b/README.md
index 40de78e..b1c89bd 100644
--- a/README.md
+++ b/README.md
@@ -41,7 +41,8 @@ list.  The discussion following them give a good reference for
 project status, development direction and remaining tasks.
 
 The name "git" was given by Linus Torvalds when he wrote the very
-first version. He described it as (depending on your mood):
+first version. He described the tool as "the stupid content tracker"
+and the name as (depending on your mood):
 
  - random three-letter combination that is pronounceable, and not
    actually used by any common UNIX command.  The fact that it is a

?

Why not, but I don't think it adds really much, and I'd rather keep the
README as short as possible.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
