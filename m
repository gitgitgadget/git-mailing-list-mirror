From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: 1.8.4 rebase regression?
Date: Tue, 17 Sep 2013 11:23:51 +0200
Message-ID: <vpq8uyv6btk.fsf@anie.imag.fr>
References: <20130915235739.GA712@quark> <vpqioy1815z.fsf@anie.imag.fr>
	<20130917091333.GB289@quark>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Patrick Welche <prlw1@cam.ac.uk>
X-From: git-owner@vger.kernel.org Tue Sep 17 11:24:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLrVp-0006ci-EZ
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 11:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596Ab3IQJX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 05:23:57 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51696 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222Ab3IQJX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 05:23:56 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r8H9No5x002808
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Sep 2013 11:23:50 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VLrVf-0003Iy-CV; Tue, 17 Sep 2013 11:23:51 +0200
In-Reply-To: <20130917091333.GB289@quark> (Patrick Welche's message of "Tue,
	17 Sep 2013 10:13:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 17 Sep 2013 11:23:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8H9No5x002808
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1380014632.00971@6bDikJ1ywOh7757ctHTl/w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234868>

Patrick Welche <prlw1@cam.ac.uk> writes:

> Got it: the change between 1.8.3.4 and 1.8.4 is that colour is on by
> default. If I take 1.8.3.4 and git -c color.ui=always log, I see
> the same ESC codes => not a regression! I'll just have to sort my
> box out if I want colour. (The only oddity is that git status is
> correctly colourful.)

Maybe you disabled the pager for "git status"?

> (
>> If you have a bit of time, you can use "git bisect" on a clone of
>> git.git to find out the guilty commit.
>
> commit e5be297279e8ee8c503eb59da21ab17edc40e748
> Merge: a3bc3d0 6897a64
>
> but that is presumably just when the default changed
> )

It doesn't seem so.

On my box, color work just fine when piped to less, but I guess not all
pagers accept this, and perhaps a wrong value of $LESS can cause less to
reject it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
