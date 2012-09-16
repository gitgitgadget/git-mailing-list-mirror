From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 7/8] Doc clean: add See Also links
Date: Sun, 16 Sep 2012 14:08:42 +0200
Message-ID: <vpqsjaiyxth.fsf@grenoble-inp.fr>
References: <1347793083-4136-8-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: gitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Sep 16 14:08:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDDeg-0000AT-BN
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 14:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441Ab2IPMIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 08:08:46 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34400 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752387Ab2IPMIq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 08:08:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q8GC43ou025321
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 16 Sep 2012 14:04:03 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TDDeU-0001Fk-KA; Sun, 16 Sep 2012 14:08:42 +0200
In-Reply-To: <1347793083-4136-8-git-send-email-philipoakley@iee.org> (Philip
	Oakley's message of "Sun, 16 Sep 2012 11:58:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 16 Sep 2012 14:04:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q8GC43ou025321
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1348401843.81523@TP8+PvsE5HXLj5neQTQBXw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205610>

Philip Oakley <philipoakley@iee.org> writes:

> --- a/Documentation/git-clean.txt
> +++ b/Documentation/git-clean.txt
> @@ -63,6 +63,12 @@ OPTIONS
>  	Remove only files ignored by git.  This may be useful to rebuild
>  	everything from scratch, but keep manually created files.
>  
> +SEE ALSO
> +--------
> +linkgit:gitignore[5]
> +linkgit:gitrepository-layout[5]
> +The optional configuration variable `core.excludesfile` linkgit:git-config[1]

I think linkgit:gitignore[5] is enough. linkgit:gitrepository-layout[5]
is a very general documentation, it's not clear to the reader which part
is intended to be read in complement to git-clean, and indeed, the
relevant information is already in linkgit:gitignore[5]. Same for
core.excludesfile which is already documented in linkgit:gitignore[5].

Otherwise, I suspect we'll end-up having the transitive closure of SEE
ALSO in each manpage ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
