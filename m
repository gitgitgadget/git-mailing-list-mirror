From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 1/2] reset: enable '-' short-hand for previous branch
Date: Tue, 10 Mar 2015 14:17:48 +0100
Message-ID: <vpqioe9xa83.fsf@anie.imag.fr>
References: <1425984728-27996-1-git-send-email-sudshekhar02@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com, davvid@gmail.com,
	sunshine@sunshineco.com
To: Sudhanshu Shekhar <sudshekhar02@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 14:18:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVK33-0006sn-Gq
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 14:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbbCJNSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 09:18:03 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43441 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797AbbCJNSC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 09:18:02 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t2ADHlNJ009054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Mar 2015 14:17:47 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t2ADHmCJ004285;
	Tue, 10 Mar 2015 14:17:48 +0100
In-Reply-To: <1425984728-27996-1-git-send-email-sudshekhar02@gmail.com>
	(Sudhanshu Shekhar's message of "Tue, 10 Mar 2015 16:22:07 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 10 Mar 2015 14:17:47 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t2ADHlNJ009054
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1426598270.75846@f20SCJ7E3xTozd/LIPq1uA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265232>

Sudhanshu Shekhar <sudshekhar02@gmail.com> writes:

>  	*rev_ret = rev;
> -
>  	if (read_cache() < 0)

Please don't make whitespace-only changes like this in your patches.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
