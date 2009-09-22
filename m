From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Trivial fix: Display a more friendly message with  git-shell.
Date: Tue, 22 Sep 2009 09:28:13 +0200
Message-ID: <vpqr5tzqvzm.fsf@bauges.imag.fr>
References: <1253466672-21051-1-git-send-email-tfransosi@gmail.com>
	<4AB71A76.5010509@viscovery.net> <vpqeiq0ssn7.fsf@bauges.imag.fr>
	<a4c8a6d00909211345q593e673bo4964204afa5ce807@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 09:28:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpznV-0003Tw-M7
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 09:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754104AbZIVH2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 03:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753573AbZIVH2Q
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 03:28:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59832 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035AbZIVH2P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 03:28:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n8M7P8tE013655
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 22 Sep 2009 09:25:08 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MpznJ-0005AD-Ar; Tue, 22 Sep 2009 09:28:13 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MpznJ-0004F3-8J; Tue, 22 Sep 2009 09:28:13 +0200
In-Reply-To: <a4c8a6d00909211345q593e673bo4964204afa5ce807@mail.gmail.com> (Thiago Farina's message of "Mon\, 21 Sep 2009 17\:45\:50 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 22 Sep 2009 09:25:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8M7P8tE013655
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1254209110.46486@GexqPMo+iakgv17ZWl8j5g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128922>

Thiago Farina <tfransosi@gmail.com> writes:

> Hi Matthieu
> On Mon, Sep 21, 2009 at 3:45 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Perhaps one more line saying what 'man git-shell' says in addition
>> would help:
>>
>> $ git-shell
>> git-shell: Restricted login shell for GIT-only SSH access
>> Usage: ...
> I added this line to the output usage, but would be good to show the
> commands that git-shell accept too?

Well, at some point, I think the user will have to read the man page.
I find it better to have a non-agressive error message, but I'm not
sure it's relevant to try to give the complete manual here.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
