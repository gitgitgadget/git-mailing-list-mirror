From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 0/11] create ref-filter from for-each-ref
Date: Mon, 08 Jun 2015 19:15:40 +0200
Message-ID: <vpqoakqunnn.fsf@anie.imag.fr>
References: <5572F904.1080608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 19:15:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z20eN-0005XN-4k
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 19:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961AbbFHRPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 13:15:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55454 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627AbbFHRPp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 13:15:45 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t58HFcMk019002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Jun 2015 19:15:38 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t58HFeXg009615;
	Mon, 8 Jun 2015 19:15:40 +0200
In-Reply-To: <5572F904.1080608@gmail.com> (Karthik Nayak's message of "Sat, 06
	Jun 2015 19:13:32 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 08 Jun 2015 19:15:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t58HFcMk019002
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434388541.07964@qtu6TM/oh6CeXaPC9iflOQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271087>

Karthik Nayak <karthik.188@gmail.com> writes:

> Version four of this patch can be found here :
> http://www.mail-archive.com/git@vger.kernel.org/msg70280.html
>
> v5 : http://www.mail-archive.com/git@vger.kernel.org/msg70888.html
>
> Changes in v5:
> *    Rename functions to better suit the code.
> *    implement filter_refs()
> *    use FLEX_ARRAY for refname
> *    other small changes
>
> Changes in v6:
> *	based on latest master branch (github.com/git/git)
> *	rename variables named sort to sorting.

Other than the hunk in PATCH 9 that belongs to PATCH 10, and the
misleading commit message in PATCH 2, the series looks good to me.

(BTW, an easy way to check that each patch is compilable is to run
"git rebase -i --exec make". It would have noticed the issue with
filter_refs() automatically)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
