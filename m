From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG] git gui blame: Show History Context [still] broken since 29e5573d
Date: Thu, 22 Jul 2010 10:11:52 +0200
Message-ID: <vpqzkxkorzr.fsf@bauges.imag.fr>
References: <vpqy6e4v1h0.fsf@bauges.imag.fr> <87sk3qrjk3.fsf@fox.patthoyts.tk>
	<7vtyo4a096.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	git <git@vger.kernel.org>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Jul 22 10:16:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObqxH-0005g6-0O
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 10:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478Ab0GVIQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 04:16:29 -0400
Received: from imag.imag.fr ([129.88.30.1]:48756 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751433Ab0GVIQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 04:16:26 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o6M8BqeD024629
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 22 Jul 2010 10:11:52 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Obqsi-0001lX-Mm; Thu, 22 Jul 2010 10:11:52 +0200
In-Reply-To: <7vtyo4a096.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 12 Jul 2010 13\:55\:17 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 22 Jul 2010 10:11:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151445>

Junio C Hamano <gitster@pobox.com> writes:

> Pat Thoyts <patthoyts@users.sourceforge.net> writes:
>
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>>Hi,
>>>
>>>I reported this bug a while ago:
>>>
>>>http://kerneltrap.org/mailarchive/git/2010/2/22/24038
>>>
>>>In short, the "Show history context" item of the context menu of "git
>>>gui blame" is broken since february. Two patches were proposed:
>>>
>>>http://thread.gmane.org/gmane.comp.version-control.git/140688
>>>http://thread.gmane.org/gmane.comp.version-control.git/140288
>>>
>>>But I've just noticed that none of theme were applied.
>>
>> Checking this it seems you are correct. This has been fixed for
>> msysGit with the above patch included there but is missing from
>> git-gui itself and hence missing from core git.
>
> Can we resolve this before 1.7.2 final?

Too late for the 1.7.2, but can we finally get one of these patches
applied? They're both very short and straightforward, and fix an
important feature of git-gui which is basically broken as of now.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
