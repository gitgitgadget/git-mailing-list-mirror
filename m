From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] rebase -i: add run command to launch a shell command
Date: Sat, 31 Jul 2010 15:27:25 +0200
Message-ID: <vpq62zv2342.fsf@bauges.imag.fr>
References: <1280323784-27462-1-git-send-email-Matthieu.Moy@imag.fr>
	<4C52E6E1.20101@xiplink.com> <vpqd3u53sd2.fsf@bauges.imag.fr>
	<i2v5hc$6ep$4@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Neal Kreitzinger" <neal@rsss.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 15:31:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfC9c-0002sQ-DR
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 15:31:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355Ab0GaNax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jul 2010 09:30:53 -0400
Received: from imag.imag.fr ([129.88.30.1]:65502 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059Ab0GaNaw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 09:30:52 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o6VDRPVX022691
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 31 Jul 2010 15:27:25 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OfC61-0005iy-AO; Sat, 31 Jul 2010 15:27:25 +0200
In-Reply-To: <i2v5hc$6ep$4@dough.gmane.org> (Neal Kreitzinger's message of "Fri\, 30 Jul 2010 13\:26\:11 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sat, 31 Jul 2010 15:27:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152325>

"Neal Kreitzinger" <neal@rsss.com> writes:

> "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr> wrote in message 
> news:vpqd3u53sd2.fsf@bauges.imag.fr...
>> Marc Branchaud <marcnarc@xiplink.com> writes:
>>
>>>> The name of the command may be subject to discussions. I've chosen
>>>> "run", but maybe "shell" would be OK too. In both cases, it doesn't
>>>> allow the one-letter version since both "r" and "s" are already used.
>>>
>>> "exec" with one-letter "x"?
>>
>> Thanks, that sounds good, yes. Any other thought?
>
> "call" with one-letter "c"?

"call" would suggest a function or command, but here, you can give
something more elaborate like

  exec cd "some directory"; make

so I prefer the "exec/x" version.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
