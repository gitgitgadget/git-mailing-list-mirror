From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: clone from url with email address as username?(escaping @ symbol)
Date: Tue, 29 Sep 2009 22:47:35 +0200
Message-ID: <vpqzl8dmqag.fsf@bauges.imag.fr>
References: <970bc7c80909290720i1c5566fer1c1a3db744edc609@mail.gmail.com>
	<fabb9a1e0909290725w616c3ea9vcb1d2c53950f7788@mail.gmail.com>
	<vpq1vlp962h.fsf@bauges.imag.fr>
	<fabb9a1e0909290732h5119170ew133d906b67e49f99@mail.gmail.com>
	<970bc7c80909290831l59b7fc4at4ec0082f42f3ef87@mail.gmail.com>
	<vpq63b1u1p6.fsf@bauges.imag.fr>
	<alpine.DEB.2.00.0909291946520.23903@tvnag.unkk.fr>
	<vpqws3hpqr1.fsf@bauges.imag.fr>
	<alpine.DEB.2.00.0909292228120.23903@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Bennett <benbennett@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Tue Sep 29 22:48:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsjcB-0005Gm-4b
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 22:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551AbZI2Uri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 16:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752519AbZI2Uri
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 16:47:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48729 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752315AbZI2Urh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 16:47:37 -0400
Received: from archeboc.imag.fr (archeboc.imag.fr [129.88.43.1])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n8TKi8cw011806
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 29 Sep 2009 22:44:08 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by archeboc.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Msjbj-000521-Cf; Tue, 29 Sep 2009 22:47:35 +0200
In-Reply-To: <alpine.DEB.2.00.0909292228120.23903@tvnag.unkk.fr> (Daniel Stenberg's message of "Tue\, 29 Sep 2009 22\:38\:19 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 29 Sep 2009 22:44:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8TKi8cw011806
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1254861848.50178@qDuOXArm3PP8UoGlB4gl8Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129327>

Daniel Stenberg <daniel@haxx.se> writes:

>> Many tools do in this case, Firefox is one of them.
>
> So what if you had that @ in your password and not in your user
> name?

Then the last @ would still be the separator between the
login/password and the hostname, and looking at the '@' starting from
the right hand side would still work.

The problem is if you have a ":" in your login or password, _then_ it
is ambiguous (but by far less common), but the @ is here to split
something that can have a @ in it (login:pass) and something which
can't (hostname), so there isn't any ambiguity.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
