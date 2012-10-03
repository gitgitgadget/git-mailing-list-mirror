From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 03 Oct 2012 16:52:49 +0200
Message-ID: <vpqr4pfboam.fsf@grenoble-inp.fr>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<7vhaqc7in6.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
	<90464C79DA97415C9D66846A77ECAA4A@PhilipOakley>
	<CAB9Jk9ARWnE-cWVjqMUFiua21QjqGEX3VhYjKQMBSotVYXXK1Q@mail.gmail.com>
	<vpq626s6kwu.fsf@grenoble-inp.fr>
	<CAB9Jk9DFb2s4s00yCNUytxFdrOQKPEKZGsXpKzwZDo5WAOdXaQ@mail.gmail.com>
	<vpqvcer4xvo.fsf@grenoble-inp.fr>
	<CAB9Jk9BTCaV7RDx6_K+MKOeJTdOQPOwvnGM0UNxg9S8KMo4D4Q@mail.gmail.com>
	<vpqfw5v1wva.fsf@grenoble-inp.fr>
	<CAB9Jk9Ar3PbbBu-8AEBsNGDAUeghyi2maLCbdZjSdpMCWseq6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 16:53:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJQJv-0002M8-7G
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 16:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248Ab2JCOwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 10:52:55 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51250 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753605Ab2JCOwy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 10:52:54 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q93ElJVn007854
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 3 Oct 2012 16:47:19 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TJQJd-0005EO-Sn; Wed, 03 Oct 2012 16:52:49 +0200
In-Reply-To: <CAB9Jk9Ar3PbbBu-8AEBsNGDAUeghyi2maLCbdZjSdpMCWseq6w@mail.gmail.com>
	(Angelo Borsotti's message of "Wed, 3 Oct 2012 16:46:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 03 Oct 2012 16:47:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q93ElJVn007854
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1349880440.26449@RsSPgX5cgA1+V+9k+wuIzw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206904>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> Hi Matthiew,
>
>>
>> You don't understand what an orphan branch is.
>
> I do not think so. I wanted to create a branch with a commit that has no parent,
> and I think that this is called "orphan branch".

Yes, and this is what you did.

> I wanted also to have another branch, pointing to a different commit,
> the difference
> being that this contains binaries, and the other does not.

If they contain different content, they will be different commits, with
different sha1.

> So, having two references pointing to the same commit is not a problem
> for me,

So, you have no problem.

End of discussion for me, sorry.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
