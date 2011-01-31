From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Mon, 31 Jan 2011 22:08:59 +0100
Message-ID: <vpqwrlkg4r8.fsf@bauges.imag.fr>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
	<7vwrll57ha.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.00.1101311459000.8580@xanadu.home>
	<7vvd144wrl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 22:09:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk0zz-0002ZU-V6
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 22:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559Ab1AaVJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 16:09:19 -0500
Received: from mx1.imag.fr ([129.88.30.5]:57592 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753178Ab1AaVJS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 16:09:18 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p0VL8vLA030557
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 31 Jan 2011 22:08:57 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Pk0zc-0003Lr-0S; Mon, 31 Jan 2011 22:09:00 +0100
In-Reply-To: <7vvd144wrl.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 31 Jan 2011 12\:57\:02 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 31 Jan 2011 22:08:58 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p0VL8vLA030557
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1297112940.46096@q1OvtrJBvwSGhiZq8tpHNw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165753>

Junio C Hamano <gitster@pobox.com> writes:

> Knee-jerk reaction: not very motivated to make the top-level directory
> just a skeleton that holds various directories with a handful of
> administrative files like Makefile, README, etc.  Under your proposal, the
> bulk of the current content at the top would simply move to another single
> directory anyway, so I don't immediately see much point of such a move,

There would be at least one obvious benefit: currently, we have this

git$ ls | wc -l
623

(that's after a build)

It's a bit hard to find the interesting bits (README, Documentation/,
contrib/ for example) in the output of "ls".

> other than adding merge burden on me and rebase burden on others, that
> is.

That can be seen as a test of how good Git is at bulk rename
management ;-).

All that said, I cannot really say whether the benefit is higher than
the cost.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
