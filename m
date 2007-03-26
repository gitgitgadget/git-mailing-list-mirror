From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: .gitlink for Summer of Code
Date: Mon, 26 Mar 2007 19:22:43 +0200
Message-ID: <vpqr6rbex7g.fsf@olympe.imag.fr>
References: <1174825838.12540.5.camel@localhost>
	<vpqvegpe4e1.fsf@olympe.imag.fr> <1174929374.5662.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 19:22:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVsuG-0000nA-Pa
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 19:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285AbXCZRWx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 13:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753284AbXCZRWx
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 13:22:53 -0400
Received: from imag.imag.fr ([129.88.30.1]:47599 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753305AbXCZRWw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 13:22:52 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l2QHMhME009117
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 26 Mar 2007 19:22:43 +0200 (CEST)
Received: from olympe.imag.fr ([129.88.43.60])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HVsu3-00061e-Lb
	for git@vger.kernel.org; Mon, 26 Mar 2007 19:22:43 +0200
Received: from moy by olympe.imag.fr with local (Exim 4.50)
	id 1HVsu3-0000u2-J3
	for git@vger.kernel.org; Mon, 26 Mar 2007 19:22:43 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <1174929374.5662.15.camel@localhost> (Eric Lesh's message of "Mon\, 26 Mar 2007 10\:16\:14 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 26 Mar 2007 19:22:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43167>

Eric Lesh <eclesh@ucla.edu> writes:

> There is no .git dir for these.  The .gitlink refers back to the main
> repository's .git/external/$submodule, which is a full .git dir with
> index+HEAD and symlinks back to the .git of the main repo for everything
> else.

I don't see any contradiction.

Light checkouts would have an almost empty .git (it still needs an
index, and its own head anyway) and use the .git of the main repo for
everything else.

-- 
Matthieu
