From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] send-email: make annotate configurable
Date: Sat, 07 Apr 2012 12:34:14 +0200
Message-ID: <vpqaa2n7rvd.fsf@bauges.imag.fr>
References: <1333758550-9187-1-git-send-email-felipe.contreras@gmail.com>
	<7vy5q8xhkb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	"Yann Dirson" <ydirson@altern.org>,
	"Michael Witten" <mfwitten@MIT.EDU>,
	"Ryan Anderson" <ryan@michonline.com>,
	"Michael Witten" <mfwitten@gmail.com>,
	"Adam Roben" <aroben@apple.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 07 12:34:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGSyk-0003Cy-CD
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 12:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157Ab2DGKel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 06:34:41 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50777 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752846Ab2DGKek (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2012 06:34:40 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q37ASbVj009067
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 7 Apr 2012 12:28:38 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SGSyF-0005ms-S0; Sat, 07 Apr 2012 12:34:15 +0200
In-Reply-To: <7vy5q8xhkb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 06 Apr 2012 22:00:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 07 Apr 2012 12:28:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q37ASbVj009067
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1334399322.04662@r73632JxGW8c4wny9vabJQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194946>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Some people always do --annotate, lets not force them to always type
>> that.
>
> Thanks.
>
> As long as there is --no-annotate to cancel a configured value for
> one-shot invocation (I didn't check, but it should be added if there isn't
> already one), I think this change makes sense (I admit that I do not use
> the --annotate option myself, though).

I almost always use --annotate, so this option definitely makes sense
for me (I usually call send-email through an alias that adds --annotate
anyway).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
