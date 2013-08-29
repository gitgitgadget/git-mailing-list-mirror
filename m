From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] stage: add edit command
Date: Thu, 29 Aug 2013 20:35:06 +0200
Message-ID: <vpqk3j4s5ut.fsf@anie.imag.fr>
References: <20130829180129.GA4880@nysa>
	<1377799744-5201-1-git-send-email-felipe.contreras@gmail.com>
	<1377799744-5201-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 20:35:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF743-0006to-UZ
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756902Ab3H2SfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:35:18 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56617 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756379Ab3H2SfR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:35:17 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7TIZ57J009299
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Aug 2013 20:35:05 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VF73j-00030T-4b; Thu, 29 Aug 2013 20:35:07 +0200
In-Reply-To: <1377799744-5201-3-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 29 Aug 2013 13:09:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 29 Aug 2013 20:35:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7TIZ57J009299
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378406109.01398@GbreW9UEsbq20jB8KsowYQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233327>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> +'edit'::
> +
> +Manually edit the staging area (as a diff).
> +

That sounds interesting. It reminds me "git add --edit", but they are
different ('stage edit' edits the patch with HEAD, 'add --edit' edits
the patch with the worktree).

Can we find a consistent user-interface where "git add --edit" and "git
stage edit" have a closer syntax? Maybe "git stage edit --work" as a
synonym for "git add --edit"?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
