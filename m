From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv2 1/2] wt-status: better advices for git status
Date: Sun, 27 May 2012 14:58:52 +0200
Message-ID: <vpqfwallr03.fsf@bauges.imag.fr>
References: <1337852264-32619-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338035905-24166-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<CACsJy8Dx=HWKJ8H3LQhVAAJGtZKmMe0d5e3Q7eHER6Xo4yTAZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 27 14:59:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYd3k-0002nV-Fz
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 14:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315Ab2E0M65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 08:58:57 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42496 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975Ab2E0M64 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 08:58:56 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q4RCoeqV010892
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 27 May 2012 14:50:40 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SYd3d-0007h9-Ho; Sun, 27 May 2012 14:58:53 +0200
In-Reply-To: <CACsJy8Dx=HWKJ8H3LQhVAAJGtZKmMe0d5e3Q7eHER6Xo4yTAZw@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Sat, 26 May 2012 20:01:08 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 27 May 2012 14:50:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4RCoeqV010892
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1338727840.95081@Vzu+ql9Zf+K0cWUPF4apOw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198589>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Nice. Although git-status is sometimes too heavy I avoid it. But I
> like this. I don't know, it might help if this info could be printed
> alone, maybe with an option, without the actual status stuff (changed,
> cached, others...).

Once this is implemented as a "git status" addition, we may want to add
a "git status --very-short" (or find a better naming) to show only the
header of the status.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
