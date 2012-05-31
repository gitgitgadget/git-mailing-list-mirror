From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv4 1/3] wt-status.*: better advices for git status added
Date: Thu, 31 May 2012 08:44:28 +0200
Message-ID: <vpqr4u0rgs3.fsf@bauges.imag.fr>
References: <1338226598-16056-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<7vmx4pzfse.fsf@alter.siamese.dyndns.org>
	<vpq1um0svgn.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 31 08:44:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZz7g-0003A8-Oi
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 08:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092Ab2EaGog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 02:44:36 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58077 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753047Ab2EaGof (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 02:44:35 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q4V6a3GT009838
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 31 May 2012 08:36:03 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SZz7V-0002Ng-PQ; Thu, 31 May 2012 08:44:29 +0200
In-Reply-To: <vpq1um0svgn.fsf@bauges.imag.fr> (Matthieu Moy's message of "Thu,
	31 May 2012 08:42:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 31 May 2012 08:36:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4V6a3GT009838
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339050965.88272@RuhKzLvTY/BrSIW9rxp2nw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198865>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> I doubt it makes much sense to hide only these messages behind "if
>> (advice_status_help)".  Look at how you give your "what to do"
>> advices in wt-status-merge-in-progress function.
>
> I disagree.

But I do agree with your updated suggestion (which I read too late):

Junio C Hamano <gitster@pobox.com> writes:

> So an updated suggestion would be to still move the whole thing to
> wt_status_print_state(), but not check advice.statusHints at the
> beginning of the function (as we will show what we find even when
> the user declines help text) and do the discovery, and hide the help
> messages (i.e. "do this to proceed") behind advice.statusHints,
> without introducing advice.statusHelp.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
