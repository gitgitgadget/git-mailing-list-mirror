From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] status: really ignore config with --porcelain
Date: Mon, 24 Jun 2013 17:04:39 +0200
Message-ID: <vpqa9mfv9bs.fsf@anie.imag.fr>
References: <1372077912-18625-1-git-send-email-artagnon@gmail.com>
	<1372077912-18625-2-git-send-email-artagnon@gmail.com>
	<vpqhagnwraj.fsf@anie.imag.fr>
	<7v8v1zd0du.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 17:05:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur8KT-0001iQ-EQ
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 17:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413Ab3FXPFC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 11:05:02 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53325 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752068Ab3FXPFB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 11:05:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5OF4bSf005904
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 24 Jun 2013 17:04:37 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ur8Jr-0006ox-Bs; Mon, 24 Jun 2013 17:04:39 +0200
In-Reply-To: <7v8v1zd0du.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 24 Jun 2013 07:55:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 24 Jun 2013 17:04:38 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228820>

Junio C Hamano <gitster@pobox.com> writes:

> My knee-jerk reaction is that, because the
> "--porcelain" output was designed to be extensible and scripts
> reading from it is expected to ignore what it does not understand,
> if the setting of status.branch is a problem, the reading side is
> buggy and needs to be fixed.

It is extensible in the sense that the caller can provide more
command-line options to get more output (i.e. say --branch --porcelain),
but providing different results for the same call because of the
configuration file is broken IMHO.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
