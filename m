From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv6 2/4] Let core.excludesfile default to $XDG_CONFIG_HOME/git/ignore
Date: Fri, 08 Jun 2012 10:47:39 +0200
Message-ID: <vpqk3zi1978.fsf@bauges.imag.fr>
References: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
	<1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
	<1338988885-21933-2-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
	<7vk3ziem2n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>, git@vger.kernel.org,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 10:47:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScurM-0000Vz-KZ
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 10:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933878Ab2FHIrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 04:47:49 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44508 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933872Ab2FHIrq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 04:47:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q588ckZx003301
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 8 Jun 2012 10:38:46 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Scur6-0007CI-9I; Fri, 08 Jun 2012 10:47:40 +0200
In-Reply-To: <7vk3ziem2n.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 07 Jun 2012 16:31:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 08 Jun 2012 10:38:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q588ckZx003301
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339749527.64596@wx6VXHAanVb+B/hiM9spNA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199469>

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps the problem you are solving is something like this (by the
> way, you didn't state what problem you are trying to solve at all):
> [...]

That is a very good summary of what the patch tries to do. Following XDG
is a nice side effect, but not the primary goal.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
