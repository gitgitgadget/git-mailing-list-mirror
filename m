From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Fix deletion of last character in levenshtein distance
Date: Tue, 18 Nov 2008 21:23:02 +0100
Message-ID: <vpqiqqkbx7d.fsf@bauges.imag.fr>
References: <20081118185326.12721.71576.stgit@arrakis.enst.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Tue Nov 18 21:29:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2XCK-0001EX-47
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 21:29:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbYKRU2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 15:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752684AbYKRU2D
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 15:28:03 -0500
Received: from imag.imag.fr ([129.88.30.1]:59389 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589AbYKRU2B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 15:28:01 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id mAIKN27I004849
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Nov 2008 21:23:02 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1L2X6E-0003Ui-BB; Tue, 18 Nov 2008 21:23:02 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1L2X6E-0003Qb-8v; Tue, 18 Nov 2008 21:23:02 +0100
In-Reply-To: <20081118185326.12721.71576.stgit@arrakis.enst.fr> (Samuel Tardieu's message of "Tue\, 18 Nov 2008 19\:53\:26 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 18 Nov 2008 21:23:02 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101283>

Samuel Tardieu <sam@rfc1149.net> writes:

> Without this change, "git tags" will not suggest "git tag"
> (it will only suggest "git status"), and "git statusx" will
> not suggest anything.

Tested and approved, but I didn't check the code.

Thanks,

-- 
Matthieu
