From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] add: add a newline at the end of pathless 'add [-u|-A]' warning
Date: Tue, 02 Apr 2013 18:57:22 +0200
Message-ID: <vpqvc84euq5.fsf@grenoble-inp.fr>
References: <vpqk3pefjs4.fsf@grenoble-inp.fr>
	<1362988893-27539-1-git-send-email-Matthieu.Moy@imag.fr>
	<1362988893-27539-2-git-send-email-Matthieu.Moy@imag.fr>
	<7v7gldc44p.fsf@alter.siamese.dyndns.org>
	<vpqehetgfh0.fsf@grenoble-inp.fr>
	<7vppycgahu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 18:59:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN4Xz-0004Sg-5I
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 18:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761833Ab3DBQ63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 12:58:29 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49855 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761624Ab3DBQ62 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 12:58:28 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r32GvLxg010503
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 2 Apr 2013 18:57:21 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UN4WQ-0006HI-QP; Tue, 02 Apr 2013 18:57:22 +0200
In-Reply-To: <7vppycgahu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 02 Apr 2013 09:31:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 02 Apr 2013 18:57:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r32GvLxg010503
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1365526642.12559@3emtEqpEEpU/H+ipi7FVxw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219800>

Junio C Hamano <gitster@pobox.com> writes:

> diff --git a/builtin/add.c b/builtin/add.c
> index a4028ee..db02233 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -57,7 +57,9 @@ static void warn_pathless_add(void)
>  		  "  git add %s .\n"
>  		  "  (or git add %s .)\n"
>  		  "\n"
> -		  "With the current Git version, the command is restricted to the current directory."),
> +		  "With the current Git version, the command is restricted to "
> +		  "the current directory.\n",
> +		  ""),

Looks good. Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
