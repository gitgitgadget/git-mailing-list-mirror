From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 01/10] ref-filter: add %(refname:shortalign=X) option
Date: Sat, 11 Jul 2015 12:20:36 +0200
Message-ID: <vpqwpy7vvuz.fsf@anie.imag.fr>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
	<1436437671-25600-1-git-send-email-karthik.188@gmail.com>
	<vpq380x8p3a.fsf@anie.imag.fr>
	<CAOLa=ZRJSA7hrRatP8GH49eZUrcSYz=UCnAJPaR+yJ2P-zrP4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 12:20:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDrtm-0006qk-DJ
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 12:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbbGKKUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 06:20:41 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59217 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040AbbGKKUk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 06:20:40 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6BAKZDR015356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 11 Jul 2015 12:20:35 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6BAKa7a021583;
	Sat, 11 Jul 2015 12:20:36 +0200
In-Reply-To: <CAOLa=ZRJSA7hrRatP8GH49eZUrcSYz=UCnAJPaR+yJ2P-zrP4g@mail.gmail.com>
	(Karthik Nayak's message of "Sat, 11 Jul 2015 11:37:01 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 11 Jul 2015 12:20:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6BAKZDR015356
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1437214837.37797@SLCfZFYgo5vgPeNAHk2n/w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273871>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Thu, Jul 9, 2015 at 6:28 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>
>> I think this would deserve a test and documentation. Even though your
>> motivation is for an internal implementation, some users may want to use
>> the feature in 'git for-each-ref --format=...'.
>>
>
> I didn't want to include documentation as this is mostly for internal use,
> but will add with tests.

You need it for internal use, but it's still available to the users, and
may actually turn out to be useful to users.

Actually, you are rewritting tag and branch based on the internal C API,
but it should be possible to write similar commands based on the
command-line interface and by looking at the documentation. It's part of
the philosophy of Git ("toolkit design") to have plumbing commands that
allow writting high-level commands through scripting, or custom commands
through aliases.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
