From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] send-email: make annotate configurable
Date: Wed, 11 Apr 2012 11:43:21 +0200
Message-ID: <vpqaa2i61ty.fsf@bauges.imag.fr>
References: <1333758550-9187-1-git-send-email-felipe.contreras@gmail.com>
	<7vy5q8xhkb.fsf@alter.siamese.dyndns.org>
	<vpqaa2n7rvd.fsf@bauges.imag.fr>
	<7vwr5owzgz.fsf@alter.siamese.dyndns.org>
	<7vlim4vfk7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	"Yann Dirson" <ydirson@altern.org>,
	"Michael Witten" <mfwitten@MIT.EDU>,
	"Ryan Anderson" <ryan@michonline.com>,
	"Michael Witten" <mfwitten@gmail.com>,
	"Adam Roben" <aroben@apple.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 11:43:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHu5j-0001wH-El
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 11:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754934Ab2DKJnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 05:43:50 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45117 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754398Ab2DKJnt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 05:43:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q3B9bWNg019003
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 11 Apr 2012 11:37:32 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SHu5C-0000fG-Fk; Wed, 11 Apr 2012 11:43:22 +0200
In-Reply-To: <7vlim4vfk7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 09 Apr 2012 13:03:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 11 Apr 2012 11:37:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3B9bWNg019003
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1334741859.44405@owH9h6R+dfCumj/IaKda6A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195157>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I do not doubt the usefulness of it, but if there is no --no-annotate, it
>> would make the new variable unusable for those who would never run it
>> without --annotate option
>
> Sorry; I meant to say "for those who mostly but not always run it with
> the --annotate option".

Actually, I guess you also meant "and who sometimes use older versions
of Git", since the --no-annotate is there for people who always use the
new version.

I don't think we can do anything for it. Any patch that introduces a new
command-line option has the same issue. The only solution is on the user
side: use only features that work for all versions of Git you use. In
this case, it means "wait for all your machines to upgrade Git before
setting sendemail.annotate".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
