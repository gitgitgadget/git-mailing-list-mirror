From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [1.8.0] Change branch --set-uptream to take an argument
Date: Tue, 01 Feb 2011 10:01:25 +0100
Message-ID: <vpqzkqg5dsq.fsf@bauges.imag.fr>
References: <AANLkTinUn2SMijphe3EmPMVOOwBjPB5ffFwwqZVxQmW0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 10:04:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkCAP-0000rg-Tr
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 10:04:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057Ab1BAJEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 04:04:48 -0500
Received: from imag.imag.fr ([129.88.30.1]:44142 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481Ab1BAJEq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 04:04:46 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id p1191QwX025024
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 1 Feb 2011 10:01:26 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PkC74-0001wm-44; Tue, 01 Feb 2011 10:01:26 +0100
In-Reply-To: <AANLkTinUn2SMijphe3EmPMVOOwBjPB5ffFwwqZVxQmW0@mail.gmail.com> (Jay Soffian's message of "Tue\, 1 Feb 2011 01\:57\:03 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 01 Feb 2011 10:01:26 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165798>

Jay Soffian <jaysoffian@gmail.com> writes:

> Currently it is very easy to misinvoke --set-upstream if you assume it
> takes an argument:

Your proposal sounds interesting, but I'd like to see something more
global: right now, some commands take a --track option and other take
a --set-upstream. In short, I'd like to see this --track deprecated
(since it's not actually about remote-tracking ...).

> (Though I'm not sure whether the options parser allows for both
> --set-upstream and --set-upstream=<arg>)

There are already many instances of this. When <arg> is mandatory, you
can write either --option <arg> or --option=<arg> (like "git log
--grep pattern" Vs "git log --grep=pattern"), and when <arg> is
optional, you can write either --option alone, or --option=<arg> (like
"git diff --color-words" and "git diff --color-words=.").

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
