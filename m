From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Commit/merge messages for binary files
Date: Fri, 18 Feb 2011 22:19:00 +0100
Message-ID: <vpqwrkx9h2z.fsf@bauges.imag.fr>
References: <AANLkTikXMi92iUd-1bEfs5WfawyHp4G7=Ynd+eaq_wsR@mail.gmail.com>
	<vpq39nlsb3r.fsf@bauges.imag.fr> <4D5ED6F2.8030008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 22:21:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqXlx-0002XW-Ab
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 22:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435Ab1BRVVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 16:21:48 -0500
Received: from imag.imag.fr ([129.88.30.1]:55128 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753468Ab1BRVVr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 16:21:47 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id p1ILJ0MB014212
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 18 Feb 2011 22:19:00 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PqXjA-0003oY-E0; Fri, 18 Feb 2011 22:19:00 +0100
In-Reply-To: <4D5ED6F2.8030008@gmail.com> (Piotr Krukowiecki's message of "Fri\, 18 Feb 2011 21\:30\:42 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 18 Feb 2011 22:19:00 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167229>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> W dniu 18.02.2011 14:53, Matthieu Moy pisze:
>> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
>> 
>>> Hi,
>>>
>>> there's a different output when committing change and when merging
>>> change for a binary file.
>>> Do the insertions/deletions have any meaning for binary files?
>> 
>> No. They're inserted/deleted *lines*, and that wouldn't make sense for
>> binary files.
>
> So it's a bug?

I don't see any bug. There were no insertion/deletion in text files,
hence you see 0 for both.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
