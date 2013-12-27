From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git:// protocol over SSL/TLS
Date: Fri, 27 Dec 2013 15:20:47 +0100
Message-ID: <vpqwqiqpe80.fsf@anie.imag.fr>
References: <CAErtv27qUMo9LsGAZtk5Zv9qnZRB_YAXhtskvrrNbWGqadQh7Q@mail.gmail.com>
	<20131227173655.3f3109e7ba848c90b302e2f9@domain007.com>
	<CAErtv25JGxEs3ytAB019yajQooNs4k=bzukSE9kuHWAbir9-BQ@mail.gmail.com>
	<87mwjm4c3s.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sergey Sharybin <sergey.vfx@gmail.com>,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Git List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Dec 27 15:21:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwYI0-0001zl-61
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 15:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754612Ab3L0OVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 09:21:20 -0500
Received: from mx1.imag.fr ([129.88.30.5]:57784 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753036Ab3L0OVT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 09:21:19 -0500
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id rBREKnsJ017246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 27 Dec 2013 15:20:49 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id rBREKl74018545
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 27 Dec 2013 15:20:50 +0100
In-Reply-To: <87mwjm4c3s.fsf@igel.home> (Andreas Schwab's message of "Fri, 27
	Dec 2013 15:12:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 27 Dec 2013 15:20:49 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: rBREKnsJ017246
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1388758850.75775@Ge4n1D5n5fzxNjH5/d+wEA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239736>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Sergey Sharybin <sergey.vfx@gmail.com> writes:
>
>> So guess we just need to recommend using https:// protocol instead of
>> git:// for our users?
>
> Given how easy it is to verify the integrity of a git repository out of
> band there isn't really much of added security by using TLS for
> transport.

You can verify integrity after the fact, but not guarantee
confidentiality ... so it again depends on the definition of "security".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
