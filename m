From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What's cooking in git.git (Oct 2012, #01; Tue, 2)
Date: Fri, 05 Oct 2012 14:30:54 +0200
Message-ID: <vpqpq4x14ox.fsf@grenoble-inp.fr>
References: <7vmx045umh.fsf@alter.siamese.dyndns.org>
	<CACsJy8BGuoW6K_9vEgGrb2XC2bNtR=0jNRU3JQhsv7_diGQpbA@mail.gmail.com>
	<7vbogj5sji.fsf@alter.siamese.dyndns.org>
	<506D5837.6020708@alum.mit.edu>
	<7vobki19ax.fsf@alter.siamese.dyndns.org> <m2391t1589.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 14:31:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK73o-0004hZ-Vf
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 14:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458Ab2JEMbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 08:31:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40972 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932431Ab2JEMbK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 08:31:10 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q95COUZC006041
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 5 Oct 2012 14:24:30 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TK73O-0004yb-KU; Fri, 05 Oct 2012 14:30:54 +0200
In-Reply-To: <m2391t1589.fsf@igel.home> (Andreas Schwab's message of "Fri, 05
	Oct 2012 14:19:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 05 Oct 2012 14:24:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q95COUZC006041
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1350044673.37183@y/5v/fGP4stwrbzOBMUmww
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207102>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> When we require "x/**/y", I think we still want it to match "x/y".
>
> FWIW, in bash (+extglob), ksh and zsh it doesn't.

You're right about bash, but I see the opposite for zsh and ksh:

zsh$ echo x/**/y
x/y x/z/y

ksh$ echo x/**/y
x/y x/z/y

(didn't check the doc so see whether this was configurable, but I've set
HOME=/ when launching the shell to disable my own configuration)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
