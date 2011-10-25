From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: pull is not a git command - 1.7.6.4
Date: Tue, 25 Oct 2011 19:01:50 +0200
Message-ID: <vpqr521j98h.fsf@bauges.imag.fr>
References: <CAPZPVFbakHo0hgz3bo+SLMuYnQSEA=ab+4W92+Lr5Fq4XZy2PA@mail.gmail.com>
	<7vipnd3trk.fsf@alter.siamese.dyndns.org>
	<CAPZPVFanWTpCDO+A0dV4TWUVx-22VjFOdk6f7cmgfU59GqG3sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 25 19:02:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIkO3-0001L2-Do
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 19:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961Ab1JYRB6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Oct 2011 13:01:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45454 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751724Ab1JYRB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 13:01:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p9PGwBli020035
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 25 Oct 2011 18:58:11 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RIkNq-0001ge-SP; Tue, 25 Oct 2011 19:01:50 +0200
In-Reply-To: <CAPZPVFanWTpCDO+A0dV4TWUVx-22VjFOdk6f7cmgfU59GqG3sQ@mail.gmail.com>
	(Eugene Sajine's message of "Tue, 25 Oct 2011 12:52:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 25 Oct 2011 18:58:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p9PGwBli020035
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1320166694.53706@+BPTwju7VJwrZQFErBsGog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184224>

Eugene Sajine <euguess@gmail.com> writes:

> On Tue, Oct 25, 2011 at 12:45 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>
>> Just a wild guess. perhaps you specified prefix=3D/usr/local/git-1.7=
=2E4.1/
>> eons ago when you built and installed 1.7.4.1 like this:
>>
>> =A0 =A0make prefix=3D/usr/local/git-1.7.4.1 all install
>>
>> and then you did it differently when you installed 1.7.6.4, e.g.
>>
>> =A0 =A0make all
>> =A0 =A0make prefix=3D/usr/local/git-1.7.6.4 install
>>
>>
>
>
> Are you saying that the first command is more correct?
> I will check it.

At build time, Git registers the "exec path" (i.e. where to find
git-<command> executables). So, if you run "make all" without specifyin=
g
the install path, Git will set an arbitrary exec-path, and the
installation won't work.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
