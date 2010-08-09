From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Documentation/git-log: Clarify --full-diff
Date: Mon, 09 Aug 2010 09:45:07 +0200
Message-ID: <vpqy6cgdybg.fsf@bauges.imag.fr>
References: <yf9ocddut4h.fsf@chiyo.mc.pp.se>
	<4acdfd58d0ff4aa6b55dab4d4233f55c1b753b5e.1281281303.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Lars Hjemli <hjemli@gmail.com>,
	Marcus Comstedt <marcus@mc.pp.se>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Aug 09 09:45:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiN35-0006He-KF
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 09:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755595Ab0HIHpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 03:45:24 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51450 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484Ab0HIHpW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 03:45:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o797YM69019139
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 9 Aug 2010 09:34:22 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OiN2i-0002W8-0C; Mon, 09 Aug 2010 09:45:08 +0200
In-Reply-To: <4acdfd58d0ff4aa6b55dab4d4233f55c1b753b5e.1281281303.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Sun\,  8 Aug 2010 17\:31\:34 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 09 Aug 2010 09:34:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o797YM69019139
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281944067.23036@Cm4Hed9Sv0MzlJfcgiU4tw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152955>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -55,6 +55,9 @@ OPTIONS
>  	paths.  With this, the full diff is shown for commits that touch
>  	the specified paths; this means that "<path>..." limits only
>  	commits, and doesn't limit diff for those commits.
> ++
> +Note that this affects all diff-based output types, e.g. those
> +produced by --stat etc.

+1.

This also help people grepping for "--stat" to find "--full-diff".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
