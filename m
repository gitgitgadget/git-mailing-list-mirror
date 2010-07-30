From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 4/5] log: parse detached options like git log --grep foo
Date: Fri, 30 Jul 2010 10:27:17 +0200
Message-ID: <vpq7hkdml22.fsf@bauges.imag.fr>
References: <1280391629-30017-1-git-send-email-Matthieu.Moy@imag.fr>
	<1280391629-30017-5-git-send-email-Matthieu.Moy@imag.fr>
	<20100729222436.GA1824@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 10:32:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oel0Y-00089d-Rs
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 10:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588Ab0G3Iby convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jul 2010 04:31:54 -0400
Received: from imag.imag.fr ([129.88.30.1]:46284 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751764Ab0G3Ibx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jul 2010 04:31:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o6U8RIIw016444
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 30 Jul 2010 10:27:18 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Oekw1-0000X0-OC; Fri, 30 Jul 2010 10:27:17 +0200
In-Reply-To: <20100729222436.GA1824@burratino> (Jonathan Nieder's message of "Thu\, 29 Jul 2010 17\:25\:16 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 30 Jul 2010 10:27:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152226>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I think arg should be optarg in the string comparison, too.

Definitely, yes.

> Sorry I didn=E2=80=99t notice last time.

Ahem, sorry for making the bug in the first place ;-).

> I wonder why t3900 and t8005 do not catch this.

Good question. I don't understand exactly what's going on with commit
messages encoding, so I can't say.

Resend follows.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
