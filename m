From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [q] git-diff --reverse 7def2be1..7def2be1^
Date: Fri, 20 Jun 2008 13:30:01 +0200
Message-ID: <vpqiqw42vk6.fsf@bauges.imag.fr>
References: <20080620082034.GA24913@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Fri Jun 20 13:32:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9eqr-00024J-Bv
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 13:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbYFTLbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 07:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754473AbYFTLbN
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 07:31:13 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:59816 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752397AbYFTLbM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 07:31:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m5KBU7KM008105;
	Fri, 20 Jun 2008 13:30:07 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1K9eob-0003Dg-Cw; Fri, 20 Jun 2008 13:30:01 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1K9eob-0004WM-Ai; Fri, 20 Jun 2008 13:30:01 +0200
In-Reply-To: <20080620082034.GA24913@elte.hu> (Ingo Molnar's message of "Fri\, 20 Jun 2008 10\:20\:34 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Fri, 20 Jun 2008 13:30:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85620>

Ingo Molnar <mingo@elte.hu> writes:

> 1) the SHA1 is duplicated above, is there a way to avoid it? Initially i 
>    tried the obvious extension:
>
>       git-diff --reverse 7def2be1..^
>
>    But Git didnt recognize that as a valid commit range.

Git may not know how to do it, but since you can omit the .. here,
your shell knows:

  git diff whatever{,^}

(BTW, git-foo is being obsoleted in favor of "git foo")

-- 
Matthieu
