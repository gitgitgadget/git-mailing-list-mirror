From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv7 1/4] Read (but not write) from $XDG_CONFIG_HOME/git/config file
Date: Thu, 21 Jun 2012 18:55:55 +0200
Message-ID: <vpqhau4sixw.fsf@bauges.imag.fr>
References: <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
	<1339469396-29677-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
To: Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 21 18:56:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Shkfv-0000AT-9N
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 18:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759894Ab2FUQ4C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 12:56:02 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41140 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526Ab2FUQ4B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 12:56:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5LGtYtp027893
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 21 Jun 2012 18:55:34 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Shkfj-00008n-V7; Thu, 21 Jun 2012 18:55:56 +0200
In-Reply-To: <1339469396-29677-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
	(Huynh Khoi Nguyen Nguyen's message of "Tue, 12 Jun 2012 04:49:53
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 21 Jun 2012 18:55:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5LGtYtp027893
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340902536.64217@j8V0cJ/w17x9WBXI2A6eYw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200406>

Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
writes:

> Git will be able to read from $XDG_CONFIG_HOME/git/config, a new
> configuration file following XDG specification. In the order of
> reading, this file is between global configuration file and system
> wide configuration file. Git currently does not write to this new
> configuration file. If $XDG_CONFIG_HOME is either not set or empty,
> $HOME/.config/git/config will be used.

What happened to this serie? I think all comments have been addressed,
but I don't see it in pu... Should I resend and Cc Junio ?

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
