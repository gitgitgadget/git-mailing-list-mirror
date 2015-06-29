From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v10.1 7/7] bisect: allow any terms set by user
Date: Mon, 29 Jun 2015 11:51:39 +0200
Message-ID: <vpq381aetas.fsf@anie.imag.fr>
References: <xmqqsi9etjwy.fsf@gitster.dls.corp.google.com>
	<1435351183-27100-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqa8vmrtsh.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1PyS_qM3EHW_Nzmo=3aeTDkZ0M3hnhRQANAO+ShF3H1Q@mail.gmail.com>
	<CAPc5daXSnovQPxR5kVoeRy4kApH7DiuTDvAz1ooQFp=5DZZg4Q@mail.gmail.com>
	<CAP8UFD0Zzjcc94qcUJOpfSrTej-o6hRKzZOuTufzAbOPkjUr_A@mail.gmail.com>
	<vpq7fqppn5h.fsf@anie.imag.fr>
	<xmqq8ub5f0z2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 11:52:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9VjM-00084q-37
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 11:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318AbbF2Jvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 05:51:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36225 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753308AbbF2Jvx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 05:51:53 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5T9pcMU028100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Jun 2015 11:51:38 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5T9pd4E023911;
	Mon, 29 Jun 2015 11:51:39 +0200
In-Reply-To: <xmqq8ub5f0z2.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sat, 27 Jun 2015 11:41:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 29 Jun 2015 11:51:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5T9pcMU028100
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436176302.56417@2L8CM84jsdQ8/8j3nYt28g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272947>

Junio C Hamano <gitster@pobox.com> writes:

> I moderately hate to see both from aesthetics point of view, but can
> we at least lose "--name-" prefix?

I changed it to --term- prefix, but I'd rather not drop it. When reading
"--old=foo", it is not clear to me whether the meaning should be "the
term used for old is foo" or "mark foo as old". The longer version does
not have this problem.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
