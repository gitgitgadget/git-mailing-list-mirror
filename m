From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [user] git-svn and svn cp
Date: Mon, 19 Nov 2007 13:29:51 +0100
Message-ID: <vpq3av25sg0.fsf@bauges.imag.fr>
References: <47416F68.9070908@ogersoft.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gerhard.oettl.ml@ogersoft.at
X-From: git-owner@vger.kernel.org Mon Nov 19 13:31:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu5mS-0000Q4-QC
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 13:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbXKSMa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 07:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751875AbXKSMa4
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 07:30:56 -0500
Received: from imag.imag.fr ([129.88.30.1]:54491 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751846AbXKSMaz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 07:30:55 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lAJCTxp2029825
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 19 Nov 2007 13:30:00 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Iu5l9-0003rZ-Cl; Mon, 19 Nov 2007 13:29:51 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Iu5l9-0002Be-7z; Mon, 19 Nov 2007 13:29:51 +0100
In-Reply-To: <47416F68.9070908@ogersoft.at> (gerhard oettl ml's message of "Mon\, 19 Nov 2007 12\:11\:36 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 19 Nov 2007 13:30:00 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65432>

gerhard.oettl.ml@ogersoft.at writes:

> I hope this is the correct mailing list. If not please point me in the
> right direction.
>
>
> I played a little with git (1.5.3.4 / debian) and had the following
> observation:
> Doing a "svn cp" (for example for a tag) results in a large traffic
> when doing a "git-svn fetch" afterwards.
>
> To verify I did:
> git-svn clone -s svn://www.ogersoft.at/ogerlit

I guess the --tags=... and --branches=... options of git-svn can help.

[ disclaimer: I never used git-svn on a repository with branches and
  tags ]

-- 
Matthieu
