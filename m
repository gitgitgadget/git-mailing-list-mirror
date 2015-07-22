From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 9/9] tag.c: implement '--merged' and '--no-merged' options
Date: Wed, 22 Jul 2015 21:40:48 +0200
Message-ID: <vpqy4i8m14v.fsf@anie.imag.fr>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
	<1437256837-13378-1-git-send-email-Karthik.188@gmail.com>
	<1437256837-13378-3-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 21:41:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHzsy-00031n-Bc
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 21:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbbGVTk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 15:40:56 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41919 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154AbbGVTkz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 15:40:55 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t6MJek3E019300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 22 Jul 2015 21:40:46 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6MJemtt029986;
	Wed, 22 Jul 2015 21:40:48 +0200
In-Reply-To: <1437256837-13378-3-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Sun, 19 Jul 2015 03:30:37 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 22 Jul 2015 21:40:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6MJek3E019300
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438198850.56964@+iXkWNQ6g5pGzvwcHoXQWg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274462>

Karthik Nayak <karthik.188@gmail.com> writes:

> +--merged [<commit>]::
> +	Only list tags whose tips are reachable from the
> +	specified commit (HEAD if not specified).
> +
> +--no-merged [<commit>]::
> +	Only list tags whose tips are not reachable from the
> +	specified commit (HEAD if not specified).

You may want to spell it `HEAD` (with backticks).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
