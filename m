From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] "not uptodate" changed to "has local changes"
Date: Sat, 17 May 2008 17:32:01 +0200
Message-ID: <vpq63tdgd5a.fsf@bauges.imag.fr>
References: <1209833972-12256-1-git-send-email-timcharper@gmail.com>
	<e2b179460805060631l506e2a6leaafc9c0acf3b05b@mail.gmail.com>
	<b8bf37780805151914j65ce5406xc5e6b3d29e3bfb9b@mail.gmail.com>
	<alpine.DEB.1.00.0805161125320.30431@racer>
	<1ED37CF1-EABD-4881-BA29-ED2CB1CE73FC@sb.org>
	<b8bf37780805162030m4c961505nabd72e8f5bd08404@mail.gmail.com>
	<alpine.DEB.1.00.0805171102480.30431@racer>
	<393B2C1A-49D3-48A7-BF7D-7938D212AF82@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?iso-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>,
	Kevin Ballard <kevin@sb.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat May 17 17:36:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxOSK-0008FY-Fu
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 17:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbYEQPfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 11:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752430AbYEQPfa
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 11:35:30 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:55131 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751680AbYEQPf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 11:35:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m4HFZAYQ003057;
	Sat, 17 May 2008 17:35:10 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JxOO9-0004TO-6E; Sat, 17 May 2008 17:32:01 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JxOO9-0006S7-3t; Sat, 17 May 2008 17:32:01 +0200
In-Reply-To: <393B2C1A-49D3-48A7-BF7D-7938D212AF82@wincent.com> (Wincent Colaiuta's message of "Sat\, 17 May 2008 17\:08\:23 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Sat, 17 May 2008 17:35:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82352>

Wincent Colaiuta <win@wincent.com> writes:

> That would indicate a problem, if stuff not intended for human
> consumption is being dished up for exactly that: human consumption.

There have been other instances of this one, and the output of
git-update-index has been replaced by a call to "git status" in the
porcelain.

-- 
Matthieu
