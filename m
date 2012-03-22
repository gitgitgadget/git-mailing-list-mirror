From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG] git bash-completion is incorrect for "git pull origin mas<tab>" if the ssh key is encrypted
Date: Thu, 22 Mar 2012 18:55:17 +0100
Message-ID: <vpqvclwo70a.fsf@bauges.imag.fr>
References: <4F6AC0FA.7040708@gmail.com> <4F6AFEC8.9090907@in.waw.pl>
	<7vmx78y1eq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Hong Xu <xuhdev@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 18:56:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAmF2-0007Uk-BD
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 18:56:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069Ab2CVRzz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Mar 2012 13:55:55 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41416 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752954Ab2CVRzv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2012 13:55:51 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q2MHoRlx021793
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 22 Mar 2012 18:50:28 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SAmEI-0004NM-NT; Thu, 22 Mar 2012 18:55:18 +0100
In-Reply-To: <7vmx78y1eq.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 22 Mar 2012 10:46:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 22 Mar 2012 18:50:28 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2MHoRlx021793
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1333043432.19272@F/5QcznA0Z9Q77BPTkW6TQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193671>

Junio C Hamano <gitster@pobox.com> writes:

> Zbigniew J=C4=99drzejewski-Szmek  <zbyszek@in.waw.pl> writes:
>
>> Maybe git-ls-remote should learn --quiet?
>
> I would rather think that the completion should ask for refs only whe=
n
> dealing with local repositories, without going over network, whether =
the
> query involves authentication or not.

It depends on what "network" is. When the network is just a machine on
the same Gb-ethernet LAN, completion can still be useful (only if you
have password-less authentication of course). I don't use it much with
Git, but I find it handy that ZSH completes rsync remote pathes for
example.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
