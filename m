From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Moving git
Date: Fri, 16 Oct 2009 18:11:58 +0200
Message-ID: <vpqbpk71fox.fsf@bauges.imag.fr>
References: <25926819.post@talk.nabble.com> <vpqk4yv2ws6.fsf@bauges.imag.fr>
	<8440EA2C12E50645A68C4AA988716651244654@SERVER.webdezign.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Richard" <richard@webdezign.co.uk>
X-From: git-owner@vger.kernel.org Fri Oct 16 18:21:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MypSk-00049v-BA
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 18:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695AbZJPQPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 12:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752550AbZJPQPN
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 12:15:13 -0400
Received: from imag.imag.fr ([129.88.30.1]:60011 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752278AbZJPQPM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 12:15:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n9GGBwYh014806
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 16 Oct 2009 18:11:58 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1MypPK-0004yH-8w; Fri, 16 Oct 2009 18:11:58 +0200
In-Reply-To: <8440EA2C12E50645A68C4AA988716651244654@SERVER.webdezign.local> (richard@webdezign.co.uk's message of "Fri\, 16 Oct 2009 16\:45\:24 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 16 Oct 2009 18:11:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130507>

"Richard" <richard@webdezign.co.uk> writes:

> Hi Matthieu,
>
>
> Thanks for replying.
>
> Basically, I used git-svn to import from git. I'm trying to get rid of
> the origin branch. (I probably should have used the no-metdata switch).
>
> The command I used was
>
> git branch prune origin
>
> I tried "git remote rm origin" which worked on my local win32 machine,
> but the linux server I was working on did not recognise "git remote rm".
>
> I'm pretty sure git stores the current git directory as I've seen the
> --git-dir and --work-tree environment variables.

Git doesn't store them by default for the current repository. "git
rev-parse --git-dir" guesses where your .git/ directory is (looking
for ./.git/, ../.git, and so on). OTOH, Git stores URLs for remote
repositories (see .git/config).

> Plus I also noticed on msysgit gives " Local uncommitted changes,
> not checked in to index" sometimes, when I move the directory.

I don't know msysgit, but I guess you'll have problems if your
repository is on a FAT filesystem. Is it the case?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
