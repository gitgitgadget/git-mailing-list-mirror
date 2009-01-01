From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git-difftool
Date: Thu, 01 Jan 2009 18:58:07 +0100
Message-ID: <vpq8wpux61c.fsf@bauges.imag.fr>
References: <20081226013021.GA15414@gmail.com>
	<vpqhc4kz5zh.fsf@bauges.imag.fr>
	<402731c90812311211p548c49d3p100f79ddee7163b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David Aguilar" <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 01 19:03:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIRtS-0003Xi-Lb
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 19:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbZAASB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 13:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbZAASB0
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 13:01:26 -0500
Received: from imag.imag.fr ([129.88.30.1]:41919 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719AbZAASBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 13:01:25 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n01Hw7Eu002674
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 1 Jan 2009 18:58:07 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LIRo7-0001cR-Cj; Thu, 01 Jan 2009 18:58:07 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LIRo7-0005Od-AS; Thu, 01 Jan 2009 18:58:07 +0100
In-Reply-To: <402731c90812311211p548c49d3p100f79ddee7163b0@mail.gmail.com> (David Aguilar's message of "Wed\, 31 Dec 2008 12\:11\:07 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 01 Jan 2009 18:58:08 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104305>

"David Aguilar" <davvid@gmail.com> writes:

> Hmm... in theory, yes, but in practice, no.
> xxdiff is too gimp to handle what 'git diff' hands it =)

As done with "vimdiff" in another message, simply write a one-liner
wrapper script that calls xxdiff $2 $3, and call this wrapper script.

-- 
Matthieu
