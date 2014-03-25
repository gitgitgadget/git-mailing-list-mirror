From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git push race condition?
Date: Tue, 25 Mar 2014 15:22:50 +0100
Message-ID: <vpqmwgepdc5.fsf@anie.imag.fr>
References: <CAAyEjTN53+5B9Od9wW698wODNL3hR6Upot8-ZLwEksn3ir_zjA@mail.gmail.com>
	<20140324225434.GB17080@sigill.intra.peff.net>
	<557DE2F7-1024-42A5-8192-ACE910CE6C81@codeaurora.org>
	<CAAyEjTPtaKExJJSc3yrxVNzx0DmOyeUFH-Uxz3dn0iezqc5VKA@mail.gmail.com>
	<vpqvbv2pe8e.fsf@anie.imag.fr>
	<CAAyEjTOy-DyeU96_DWWydgcpb+x5DMRkf1NHBfn+eNZ-yDrZUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Nasser Grainawi <nasser@codeaurora.org>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Scott Sandler <scott.m.sandler@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 15:23:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSSFy-0000ON-5K
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 15:23:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbaCYOXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 10:23:04 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40656 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090AbaCYOXB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 10:23:01 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s2PEMm1n024204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 25 Mar 2014 15:22:48 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2PEMoTR028410;
	Tue, 25 Mar 2014 15:22:50 +0100
In-Reply-To: <CAAyEjTOy-DyeU96_DWWydgcpb+x5DMRkf1NHBfn+eNZ-yDrZUw@mail.gmail.com>
	(Scott Sandler's message of "Tue, 25 Mar 2014 10:16:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 25 Mar 2014 15:22:49 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2PEMm1n024204
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1396362169.75019@UFX5b8qsjdPrdetVjFM2yA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245040>

(please, don't top-post on this list)

Scott Sandler <scott.m.sandler@gmail.com> writes:

> I'd like to see it happen again under these conditions and get that
> information, then enable receive.denyNonFastForwards explicitly just
> to be sure it's not force pushes, and see if it still happens.

To be really sure, you also have to set receive.denyDeletes to true.
Otherwise, a workaround to perform a non-fast forward is to delete the
branch, and re-create it somewhere else in history.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
