From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Undoing merges
Date: Tue, 08 Dec 2009 18:48:09 +0100
Message-ID: <vpqpr6pqrvq.fsf@bauges.imag.fr>
References: <8440EA2C12E50645A68C4AA98871665131D8D8@SERVER.webdezign.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Richard" <richard@webdezign.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 08 18:49:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI4Al-0004rR-3f
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 18:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965680AbZLHRsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 12:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965676AbZLHRsM
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 12:48:12 -0500
Received: from mx2.imag.fr ([129.88.30.17]:52141 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965674AbZLHRsL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 12:48:11 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id nB8HkI3h024624
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 8 Dec 2009 18:46:18 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NI4AT-0001vD-8f; Tue, 08 Dec 2009 18:48:09 +0100
In-Reply-To: <8440EA2C12E50645A68C4AA98871665131D8D8@SERVER.webdezign.local> (richard@webdezign.co.uk's message of "Tue\, 8 Dec 2009 17\:16\:48 -0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 08 Dec 2009 18:46:18 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nB8HkI3h024624
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1260899181.51849@0cB/JK30JsGECJvYLpMeGg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134901>

"Richard" <richard@webdezign.co.uk> writes:

> Hi git list,
>
> I'm trying to find out how to undo a merge.

When sitting on a merge commit,

  git reset --merge HEAD^

will undo this merge commit (i.e. pretend the merge has never occured,
at least in your branch). Don't do that if you already published this
merge commit.

> I know that my branches are independent and that I can just carry on
> working on them and merge again later, but I'm just trying to keep
> my revision graph tidier. Should I even be undoing merges?

If it's about cleaning up your history, "git rebase" is your friend,
too (with the same limitation: don't do that on published history). By
default, it does some kind of history flattening.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
