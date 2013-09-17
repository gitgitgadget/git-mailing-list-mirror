From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: 1.8.4 rebase regression?
Date: Tue, 17 Sep 2013 09:15:43 +0200
Message-ID: <vpqd2o77wbk.fsf@anie.imag.fr>
References: <20130915235739.GA712@quark> <vpqioy1815z.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Patrick Welche <prlw1@cam.ac.uk>
X-From: git-owner@vger.kernel.org Tue Sep 17 09:15:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLpVt-0007TG-EK
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 09:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739Ab3IQHPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 03:15:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41556 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392Ab3IQHPx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 03:15:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r8H7FgK1015210
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Sep 2013 09:15:43 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VLpVf-0001VN-GK; Tue, 17 Sep 2013 09:15:43 +0200
In-Reply-To: <vpqioy1815z.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	16 Sep 2013 13:18:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 17 Sep 2013 09:15:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8H7FgK1015210
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1380006945.38455@FG6x/BpEBHABgKqzTSiNhQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234857>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Patrick Welche <prlw1@cam.ac.uk> writes:
>
>> $ git diff
>> ESC[1mdiff --cc glib/gmain.cESC[m
>> ESC[1mindex 738e69c,5aaebd0..0000000ESC[m
>> ESC[1m--- a/glib/gmain.cESC[m
>> ESC[1m+++ b/glib/gmain.cESC[m
>> ESC[36m@@@ -4953,32 -4921,32 +4953,48 @@@ESC[m ESC[mg_unix_signal_watch_dispatch (GSourcESC[m
>>
>>
>> (same xterm, no change of TERM in both invocations above)
>> git status in 1.8.4 does show red, so colour does work...
>>
>> Thoughts on how to help debug?
>
> Can you try:
>
> git -c color.ui=never diff
> git -c color.ui=auto diff
> git -c color.ui=always diff
>
> ?

... and Junio suggested offline to look for a broken pager, so, you can
try this too:

git --no-pager diff

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
