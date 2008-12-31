From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git-difftool
Date: Wed, 31 Dec 2008 17:04:02 +0100
Message-ID: <vpqhc4kz5zh.fsf@bauges.imag.fr>
References: <20081226013021.GA15414@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 31 17:08:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LI3cb-0007Ln-O2
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 17:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755554AbYLaQHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 11:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755531AbYLaQHP
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 11:07:15 -0500
Received: from imag.imag.fr ([129.88.30.1]:46640 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754923AbYLaQHN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 11:07:13 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id mBVG42qN000033
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 31 Dec 2008 17:04:02 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LI3YA-0006nq-A4; Wed, 31 Dec 2008 17:04:02 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LI3YA-0004eA-69; Wed, 31 Dec 2008 17:04:02 +0100
In-Reply-To: <20081226013021.GA15414@gmail.com> (David Aguilar's message of "Thu\, 25 Dec 2008 17\:30\:23 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 31 Dec 2008 17:04:02 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104279>

David Aguilar <davvid@gmail.com> writes:

> The usual use case for this script is when you have either
> staged or unstaged changes and you'd like to see the changes
> in a side-by-side diff viewer (e.g. xxdiff, tkdiff, etc).
>
> 	git difftool [<filename>*]

Is it not a complex way of saying

        GIT_EXTERNAL_DIFF=xxdiff git diff

?

(My 2 cents, and happy new year ;-)

-- 
Matthieu
