From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/5] t1507: add additional tests for @{upstream}
Date: Wed, 11 Apr 2012 19:59:23 +0200
Message-ID: <vpqk41m40as.fsf@bauges.imag.fr>
References: <1334161035-26355-1-git-send-email-zbyszek@in.waw.pl>
	<1334161035-26355-2-git-send-email-zbyszek@in.waw.pl>
	<7vfwcakvfw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 20:01:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI1rC-0007mL-Sk
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 20:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932819Ab2DKSBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 14:01:05 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45116 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932781Ab2DKSBB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 14:01:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q3BHrXF9015075
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 11 Apr 2012 19:53:33 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SI1pE-0000hC-6C; Wed, 11 Apr 2012 19:59:24 +0200
In-Reply-To: <7vfwcakvfw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 11 Apr 2012 10:52:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 11 Apr 2012 19:53:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3BHrXF9015075
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1334771613.59883@ZKs9KGEJ67QVI1EQ1WFQgA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195228>

Junio C Hamano <gitster@pobox.com> writes:

> We may want to update the error message for "@{u}" when the current one is
> not tracked, instead of saying ''.  Perhaps
>
> 	error: No upstream branch found for the current branch.
>
> or something?
>
> Likewise for the detached HEAD case.

This is indeed the point of the patch serie, and I like how it first
shows how bad the error messages can be, and then illustrate the fix
with patch hunks in the newly added testcases in further patches.

But the commit message for this patch could probably be improved: we
usually do not give a list of _what_ is done, since the code already
says that, but we insist on _why_ it is done.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
