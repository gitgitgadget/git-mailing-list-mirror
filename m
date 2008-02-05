From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [BUG] (minor) "git status ." reports added files as untracked
Date: Tue, 05 Feb 2008 07:08:17 +0100
Message-ID: <vpqy7a00wby.fsf@bauges.imag.fr>
References: <vpqtzko8ws2.fsf@bauges.imag.fr>
	<7v7ihkjtvg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 07:09:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMGzT-0001aP-0I
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 07:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbYBEGIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 01:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752355AbYBEGIf
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 01:08:35 -0500
Received: from imag.imag.fr ([129.88.30.1]:54978 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752004AbYBEGIe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 01:08:34 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m1568H8I008378
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 5 Feb 2008 07:08:17 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JMGyf-0005oM-FD; Tue, 05 Feb 2008 07:08:17 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JMGyf-0006Uu-Cn; Tue, 05 Feb 2008 07:08:17 +0100
In-Reply-To: <7v7ihkjtvg.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 04 Feb 2008 13\:26\:27 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 05 Feb 2008 07:08:18 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72628>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> Indeed, I've always considered the fact that "git status ." reports
>> untracked files outside the current directory as a bug, but I'm not
>> sure whether this is intended or not.
>
> It is intended.
>
> "git status $args" was designed as "show me what happens if I
> ran 'git commit $args' now", and because a commit is a whole
> tree operation, 

I don't understand the point: "git commit" doesn't care about
untracked files. So if "git status" would really only "show me what
happens if I run git commit now", it wouldn't show untracked files, at
all.

Showing untracked files is status is IMHO a good thing, it helps me to
see if I forget to "git add" something. But if I explicitely ask for a
limited commit, I really mean I don't care about what happens outside
the directory I'm commiting.

-- 
Matthieu
