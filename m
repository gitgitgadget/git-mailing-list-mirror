From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git pull (Your local changes to ... would be overwritten by  merge)
Date: Thu, 17 Jun 2010 17:21:05 +0200
Message-ID: <vpqbpb9ofby.fsf@bauges.imag.fr>
References: <AANLkTinokUxiDdetcrsrlSExQ7hmhLS5szbTt9KzGKr_@mail.gmail.com>
	<AANLkTimeIWseETfYiMajIqesjJ_p55pRislnQQIaCrbG@mail.gmail.com>
	<4C19FBF8.6010709@drmicha.warpmail.net>
	<vpq4oh1zzfs.fsf@bauges.imag.fr>
	<AANLkTinWS0zWhh0d-yrb7eWMEeQenoAF8tA6-l9BRP_q@mail.gmail.com>
	<4C1A0DCD.2070906@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Blendea <bdaniel7@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 17 17:21:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPGu7-0006oM-17
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 17:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932833Ab0FQPVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 11:21:14 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56382 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760240Ab0FQPVN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jun 2010 11:21:13 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o5HFCuBN030099
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 17 Jun 2010 17:12:56 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OPGtt-0003w0-UO; Thu, 17 Jun 2010 17:21:05 +0200
In-Reply-To: <4C1A0DCD.2070906@drmicha.warpmail.net> (Michael J. Gruber's message of "Thu\, 17 Jun 2010 13\:58\:05 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 17 Jun 2010 17:12:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5HFCuBN030099
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1277392378.33922@QABrrjaMbFPa45/Ri0woZQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149313>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Daniel Blendea venit, vidit, dixit 17.06.2010 13:18:
>> Windows 7, did not change anything related to crlf.

I never used Git on Windows, but I think Git sets autocrlf to true by
default on Windows.

> I guess this shows that correct diagnostics is not a prerequisite for a
> successful therapy ;)
>
> (The diagnostics really indicate a work tree with local uncommitted
> modifications.)

I'd bet for this kind of issue:

http://kerneltrap.org/mailarchive/git/2010/3/9/25215/thread
From: Johannes Schindelin
Subject: core.autocrlf considered half-assed

Didn't follow the outcome in details, but some patches were proposed
to improve the situation.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
