From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv6 4/4] Write to $XDG_CONFIG_HOME/git/config file
Date: Sun, 10 Jun 2012 15:21:37 +0200
Message-ID: <vpqmx4bmhem.fsf@bauges.imag.fr>
References: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
	<1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
	<1338988885-21933-4-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
	<CAJDDKr6sCrwy99-5-sOaAuNjYmnw73CicF3PyYMe8hvf38oFvg@mail.gmail.com>
	<7vipf1aty2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Aguilar <davvid@gmail.com>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>, git@vger.kernel.org,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 15:21:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sdi5U-0005mW-Su
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 15:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755256Ab2FJNVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 09:21:45 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60193 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754993Ab2FJNVo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 09:21:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5ADCbtI002160
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 10 Jun 2012 15:12:37 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sdi5K-0004Oj-O8; Sun, 10 Jun 2012 15:21:38 +0200
In-Reply-To: <7vipf1aty2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 08 Jun 2012 23:19:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 10 Jun 2012 15:12:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5ADCbtI002160
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339938760.96641@1W29Qi605Gp0uw1jGP/+GQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199602>

Junio C Hamano <gitster@pobox.com> writes:

> Probably.  I think we should follow whatever existing and prevalent
> practice is, and my gut feeling is that we would end up first doing
> POSIX only thing in my tree, and msysgit folks will quickly feed me
> updates to tweak the behaviour to match what of Windows version.

I don't really have opinion on what Git should do on windows, but in any
case, the current patches only changes the behavior if the XDG file
exists, so it may be suboptimal on windows, but shouldn't harm windows
users.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
