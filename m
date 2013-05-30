From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Should "git help" respect the 'pager' setting?
Date: Thu, 30 May 2013 18:42:36 +0200
Message-ID: <vpqtxlko1vn.fsf@anie.imag.fr>
References: <CAKtB=OCyoN8ECYiAzXc3UiCrLfWn7Pq7_5CSQUjJ2dhbzQ2RsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael Campbell <michael.campbell@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 18:42:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui5w4-00078U-E5
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 18:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935573Ab3E3Qml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 12:42:41 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41904 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935566Ab3E3Qmj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 12:42:39 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r4UGgZsw025325
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 30 May 2013 18:42:35 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ui5vw-0004Uv-UB; Thu, 30 May 2013 18:42:36 +0200
In-Reply-To: <CAKtB=OCyoN8ECYiAzXc3UiCrLfWn7Pq7_5CSQUjJ2dhbzQ2RsQ@mail.gmail.com>
	(Michael Campbell's message of "Thu, 30 May 2013 12:33:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 30 May 2013 18:42:35 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226021>

Michael Campbell <michael.campbell@gmail.com> writes:

> I have my global git config pager set to 'cat', but when I do a "git
> help <command>", it still uses a pager.  This is especially irksome in
> emacs shell buffers, where I am most of the time.  I know I can do a
> M-x man -> git-<whatever>, but wondered if this was a bug or user
> error.  ("git --no-pager help <command>" does the same.)

"git help foo" just calls "man git-foo" by default, so what happens is
the same as if you called "man git-foo" by hand. Git does not have
much control over what man will do, it could probably call "man -P
$pager" when the Git pager is set, but I'd find it a bit weird.

If you're an Emacs user, you can read about man.viewer and set it to
woman, or set PAGER=cat when inside Emacs.

I personally run M-x git-foo RET, and never run "git help".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
