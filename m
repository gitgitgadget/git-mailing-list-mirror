From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: how can we git out source code base on git log?
Date: Tue, 08 Mar 2011 09:22:42 +0100
Message-ID: <vpq8vwqvx65.fsf@bauges.imag.fr>
References: <AANLkTimAPBoHJX0iZOt949xQ8HeGPXRyKfD4CDNJFv7u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: loody <miloody@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 09:22:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwsBx-0005aA-F3
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 09:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827Ab1CHIWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 03:22:48 -0500
Received: from mx2.imag.fr ([129.88.30.17]:34128 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753168Ab1CHIWr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 03:22:47 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p288MfTi032354
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 8 Mar 2011 09:22:41 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PwsBm-0006HJ-CS; Tue, 08 Mar 2011 09:22:42 +0100
In-Reply-To: <AANLkTimAPBoHJX0iZOt949xQ8HeGPXRyKfD4CDNJFv7u@mail.gmail.com>
	(loody's message of "Tue, 8 Mar 2011 01:25:53 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 08 Mar 2011 09:22:42 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p288MfTi032354
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1300177363.1144@UbQVSoZwfA7v3iNqnJuQoQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168638>

loody <miloody@gmail.com> writes:

> Is it possible I can check out the commit as
> 3831530dcb7b71329c272ccd6181f8038b6a6dd0,?

In complement to Jeff's answer: you can also get the content of a
specific file without checking out with

  git show 3831530dcb7b713:path/to/file

> commit 3831530dcb7b71329c272ccd6181f8038b6a6dd0
> Author: Mikhail Zolotaryov <lebon@lebon.org.ua>
> Date:   Wed Sep 8 17:06:03 2010 +0300
> .......
> .......
>
> Tag: aabb

  git log --decorate

does this (except that tags appear after the commit ID, not after the
log message). You may also want to look at gitk.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
