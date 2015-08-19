From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-am: add am.threeWay config variable
Date: Wed, 19 Aug 2015 11:45:38 +0200
Message-ID: <vpq4mjv7gsd.fsf@anie.imag.fr>
References: <1438697966-4958-1-git-send-email-pyokagan@gmail.com>
	<vpqfv3h9bvf.fsf@anie.imag.fr>
	<CACRoPnTY8mALN8KbjR0CHeaKOkm2oSLRL9=4X1tU1LmHiJTeNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 11:46:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRzwU-0004NC-JX
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 11:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbbHSJpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 05:45:54 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48068 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058AbbHSJpx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 05:45:53 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t7J9jbhA026380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 19 Aug 2015 11:45:37 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7J9jcqr016934;
	Wed, 19 Aug 2015 11:45:38 +0200
In-Reply-To: <CACRoPnTY8mALN8KbjR0CHeaKOkm2oSLRL9=4X1tU1LmHiJTeNg@mail.gmail.com>
	(Paul Tan's message of "Wed, 19 Aug 2015 16:33:36 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 19 Aug 2015 11:45:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7J9jbhA026380
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1440582341.90583@95dYNg8vsI8oQSMrEwqhBw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276166>

Paul Tan <pyokagan@gmail.com> writes:

> On Tue, Aug 18, 2015 at 5:36 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> I don't remember the details of the regression we had with the shell
>> version, but that would probably deserve an additional test to enforce
>> the "Hopefully there will be no regressions" part of your message.
>
> Actually, technically, I think this patch by its own would reintroduce
> the regression ;)
>
> The reason is that the bug was caused by the overall structure of the
> git-am.sh code, and not the patch itself[1].
>
> This is fixed in another patch series[2] on top of this patch which
> also implements a test for "git am --3way".

OK, perfect. I had missed that. Thanks again.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
