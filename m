From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Feature request: "author branch" in commit object
Date: Wed, 03 Jul 2013 11:33:22 +0200
Message-ID: <vpqehbgrnrx.fsf@anie.imag.fr>
References: <CADL+T9YGtvFrzStxJW64OJEV6H0BroMbkVCJdsDwWDaUWd91zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ed Hutchins <eh@demeterr.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 11:33:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuJRN-0008CY-W9
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 11:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402Ab3GCJda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 05:33:30 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50174 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754699Ab3GCJd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 05:33:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r639XLR6028161
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 3 Jul 2013 11:33:21 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UuJRC-0001Dm-RS; Wed, 03 Jul 2013 11:33:22 +0200
In-Reply-To: <CADL+T9YGtvFrzStxJW64OJEV6H0BroMbkVCJdsDwWDaUWd91zQ@mail.gmail.com>
	(Ed Hutchins's message of "Tue, 2 Jul 2013 12:37:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 03 Jul 2013 11:33:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r639XLR6028161
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1373448803.00337@KtlPIJofs8eVJjq2X1aD7Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229476>

Ed Hutchins <eh@demeterr.com> writes:

> I realize that branch names are ephemeral repo-specific things, but it
> would be really useful to be able to determine what branch a commit
> was authored from (as a hint to ancestry graph layout tools, for
> example). Is there any way to do this currently, is it planned, or
> would it be deemed useful enough to be worth adding to each commit
> object?

FWIW, this is what Mercurial's "named branches" do. Instead of having
branches point to commit, each commit says what branch it belongs to.

One drawback of this approach is that the branch name is part of the
commit and can't be changed without changing the commit's sha1. Hence, a
local, private, branch name becomes permanent the day it's merged
upstream.

(for completeness: Mercurial also has essentially Git-like branches,
but they call this "bookmarks")

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
