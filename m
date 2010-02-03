From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor  with no changes written
Date: Wed, 03 Feb 2010 08:31:40 +0100
Message-ID: <vpqeil2kc6b.fsf@bauges.imag.fr>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com>
	<32541b131002021227o1ec9f369w6096e85382857b8a@mail.gmail.com>
	<76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com>
	<394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com>
	<76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>
	<77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com>
	<76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
	<alpine.DEB.1.00.1002022356460.4985@pacific.mpi-cbg.de>
	<76c5b8581002021534i1f0dbd18y1b216233d282cd84@mail.gmail.com>
	<40aa078e1002021540i13e35776xd733a4e40f34b477@mail.gmail.com>
	<76c5b8581002021548n129b3997r48ee6f6df5a1a4eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wincent Colaiuta <win@wincent.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 08:31:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcZiR-0000Gk-AR
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 08:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087Ab0BCHby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 02:31:54 -0500
Received: from mx1.imag.fr ([129.88.30.5]:44861 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752858Ab0BCHbx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 02:31:53 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o137UIce000852
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 3 Feb 2010 08:30:18 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NcZi8-0004FF-Ub; Wed, 03 Feb 2010 08:31:41 +0100
In-Reply-To: <76c5b8581002021548n129b3997r48ee6f6df5a1a4eb@mail.gmail.com> (Eugene Sajine's message of "Tue\, 2 Feb 2010 18\:48\:13 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 03 Feb 2010 08:30:18 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o137UIce000852
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1265787020.12415@yL3bqEgZarN59t4hkI4ziw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138810>

Eugene Sajine <euguess@gmail.com> writes:

> Thank you, but I'm not wrong, as i described the exact same thing
> somewhere in my second or third message, without even knowing the
> implementation details. I understand the reason WHY it is like it is,
> i just don't like it as it is inconsistent and IMHO incorrect.

Just try:

Create a file.
1) Launch emacs, save and quit.
2) Launch emacs, don't save, and quit.

>From outside, it's EXACTLY the same thing. In the first case, emacs
will just tell you "no change need to be saved" and quit, in the
second, it'll quit. Try deleting the file in the meantime, it won't
change the behavior.

Now, what would you do about this? Ignore Emacs and force people to
use vi?

People have been spending a whole thread to explain you that it's not
going to work. I think it'll either be time to acknowledge that, or to
learn C and write a patch. Or perhaps try to write it in Java to
understand why it doesn't work.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
