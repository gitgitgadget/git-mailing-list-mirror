From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: immutable tags?
Date: Mon, 28 Dec 2009 21:58:05 +0100
Message-ID: <vpqzl524y02.fsf@bauges.imag.fr>
References: <92c9564e0912281204h13c6a566w95069023e6909eda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Carlos Santana <neubyr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 22:01:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPMi9-0003Dr-EL
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 22:01:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbZL1VAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 16:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbZL1VAz
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 16:00:55 -0500
Received: from imag.imag.fr ([129.88.30.1]:46775 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751483AbZL1VAy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 16:00:54 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nBSKw5K1025689
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 28 Dec 2009 21:58:05 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NPMfF-0007ub-G1; Mon, 28 Dec 2009 21:58:05 +0100
In-Reply-To: <92c9564e0912281204h13c6a566w95069023e6909eda@mail.gmail.com> (Carlos Santana's message of "Mon\, 28 Dec 2009 14\:04\:42 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 28 Dec 2009 21:58:05 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135762>

Carlos Santana <neubyr@gmail.com> writes:

> I would like to know if there is any difference between branches and
> tags. Is it only conceptual - convention to be followed by a developer
> or some technical difference?  e.g. : Is it possible to create
> immutable tags so that nothing can be checked in to that 'tagged
> directory'?

A tag is just a named reference to a particular commit (or other
object indeed). Once you set a tag, it doesn't move (unless you
override it explicitely).

You can't prevent people from commiting something. It won't move the
tag, but it will create a new commit whose parent is the tagged
commit.

A branch is also a named reference to a commit, but the difference is
that when you commit, the current branch is updated (i.e. the
reference points to the new commit).


-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
