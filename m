From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git should not use a default user.email config value
Date: Tue, 13 Aug 2013 10:08:56 +0200
Message-ID: <vpqsiyehv1j.fsf@anie.imag.fr>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
	<20130809194214.GV14690@google.com>
	<20130809223758.GB7160@sigill.intra.peff.net>
	<20130809231928.GY14690@google.com>
	<20130810064717.GB30185@sigill.intra.peff.net>
	<52060EF9.2040504@alum.mit.edu>
	<7vvc3d1o01.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 13 10:09:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V99fR-0005UW-6j
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 10:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902Ab3HMIJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 04:09:19 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51971 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752584Ab3HMIJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 04:09:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7D88uK2006381
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 13 Aug 2013 10:08:56 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V99ey-0007kk-Og; Tue, 13 Aug 2013 10:08:56 +0200
In-Reply-To: <7vvc3d1o01.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 10 Aug 2013 09:58:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 13 Aug 2013 10:08:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7D88uK2006381
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1376986137.58049@HrN4PTqqYlkk5yMGGhRj6Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232215>

Junio C Hamano <gitster@pobox.com> writes:

>  (2) configure "include.path" to point at "~/.git-profile/open" at
>      the very end

I'd rather have it ~/.config/git/profile/ (or
$XDG_CONFIG_HOME/git/profile if $XDG_CONFIG_HOME is set), but the
proposal makes sense.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
