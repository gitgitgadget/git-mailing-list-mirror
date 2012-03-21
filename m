From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] rebase -i: inform the user they can re-order commits
Date: Wed, 21 Mar 2012 09:25:56 +0100
Message-ID: <vpq7gyee4x7.fsf@bauges.imag.fr>
References: <4F63205A.6000202@seap.minhap.es> <vpqlin0n8w5.fsf@bauges.imag.fr>
	<7vty1oivub.fsf@alter.siamese.dyndns.org>
	<4F63571D.4070405@seap.minhap.es> <vpqaa3geiso.fsf@bauges.imag.fr>
	<7vpqccipuv.fsf@alter.siamese.dyndns.org>
	<7vlin0ip9l.fsf@alter.siamese.dyndns.org>
	<7vobrq50su.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 09:26:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAGs6-0000bd-2W
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 09:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932Ab2CUI0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 04:26:10 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50641 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301Ab2CUI0G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 04:26:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q2L8LAZQ009376
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 21 Mar 2012 09:21:10 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SAGrk-0007B3-VJ; Wed, 21 Mar 2012 09:25:57 +0100
In-Reply-To: <7vobrq50su.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 20 Mar 2012 16:07:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 21 Mar 2012 09:21:11 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2L8LAZQ009376
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1332922871.70581@3jTirf1nbN3lXXQ/dzb0zw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193560>

Junio C Hamano <gitster@pobox.com> writes:

> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -846,6 +846,8 @@ cat >> "$todo" << EOF
>  #  f, fixup = like "squash", but discard this commit's log message
>  #  x, exec = run command (the rest of the line) using shell
>  #
> +# These lines can be re-ordered; they are executed from top to bottom.
> +#

Great, it says everything that needs to be said, in just a line!

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
