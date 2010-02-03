From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor  with no changes written
Date: Wed, 03 Feb 2010 19:47:28 +0100
Message-ID: <vpqzl3q2m2n.fsf@bauges.imag.fr>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com>
	<394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com>
	<76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>
	<77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com>
	<76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
	<alpine.DEB.1.00.1002022356460.4985@pacific.mpi-cbg.de>
	<76c5b8581002021534i1f0dbd18y1b216233d282cd84@mail.gmail.com>
	<40aa078e1002021540i13e35776xd733a4e40f34b477@mail.gmail.com>
	<76c5b8581002021548n129b3997r48ee6f6df5a1a4eb@mail.gmail.com>
	<vpqeil2kc6b.fsf@bauges.imag.fr>
	<76c5b8581002030745g634d6ec1hb9e87b687e58e521@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wincent Colaiuta <win@wincent.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 19:48:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NckGe-0007OQ-7u
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 19:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756877Ab0BCSri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 13:47:38 -0500
Received: from mx2.imag.fr ([129.88.30.17]:40407 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756604Ab0BCSrh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 13:47:37 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o13Ik5GU014227
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 3 Feb 2010 19:46:05 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NckG8-00072O-ID; Wed, 03 Feb 2010 19:47:28 +0100
In-Reply-To: <76c5b8581002030745g634d6ec1hb9e87b687e58e521@mail.gmail.com> (Eugene Sajine's message of "Wed\, 3 Feb 2010 10\:45\:54 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 03 Feb 2010 19:46:05 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o13Ik5GU014227
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1265827568.61926@/NHOzdnoOfJ9VRIgQmLtFQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138859>

Eugene Sajine <euguess@gmail.com> writes:

> Tell me you're not serious, please;) I'm working with computers for
> more than 20 years and I do understand how editors are opening files.
> If you are serious though...:

I'm damned serious. If you've been working for 20 years with
computers, you probably understand what "no change need to be saved"
mean.

> The solution should be as Avery proposed - to monitor file
> modification timestamp as well as the content.

Try it. I do mean "try it". I don't think anyone will be able to
explain you better than it has already been done, but ... it doesn't
work.

So, again, stop arguing, try it, and see by yourself. I promise public
apologies if you prove me wrong with an actually working piece of
code.

> Timestamp should be remembered by git when editor is fired up and then
> checked when you're exiting the editor.

Which doesn't work reliable, as you would have noticed by reading my
message.

(and yes, I'm tired and angry after a long day of work ;-) ).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
