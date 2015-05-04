From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 0/7] Improve git-pull test coverage
Date: Mon, 04 May 2015 10:16:22 +0200
Message-ID: <vpqoam0sqp5.fsf@anie.imag.fr>
References: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 04 10:16:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpBYW-0004bc-EM
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 10:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbbEDIQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 04:16:39 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37399 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084AbbEDIQh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 04:16:37 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t448GMgZ007565
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 May 2015 10:16:22 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t448GMJS012452;
	Mon, 4 May 2015 10:16:22 +0200
In-Reply-To: <1430581035-29464-1-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Sat, 2 May 2015 23:37:08 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 04 May 2015 10:16:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t448GMgZ007565
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1431332184.69202@OBho/xSjrY27cSAr8Ttvyg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268312>

Paul Tan <pyokagan@gmail.com> writes:

> Paul Tan (7):
>   t5520: test pulling multiple branches into an empty repository
>   t5520: implement tests for no merge candidates cases
>   t5520: test for failure if index has unresolved entries
>   t5520: test work tree fast-forward when fetch updates head
>   t5520: test --rebase with multiple branches
>   t5520: test --rebase failure on unborn branch with index
>   t5521: test --dry-run does not make any changes

I did a semi-thourough review of the whole series, it looks good to me.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
