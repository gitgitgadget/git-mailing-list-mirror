From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: hg2git error
Date: Mon, 25 May 2009 13:57:19 +0200
Message-ID: <vpqprdxpf8g.fsf@bauges.imag.fr>
References: <alpine.DEB.1.00.0905241932301.26154@pacific.mpi-cbg.de>
	<20090525113418.GA3259@robert>
	<alpine.DEB.1.00.0905251341370.4288@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rocco Rutte <pdmef@gmx.net>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 25 14:00:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8YqX-0002nE-4y
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 14:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbZEYL7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 07:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbZEYL7w
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 07:59:52 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:45296 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751277AbZEYL7w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 07:59:52 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n4PBvKMn029435;
	Mon, 25 May 2009 13:57:20 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1M8Ynw-0008JF-1X; Mon, 25 May 2009 13:57:20 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1M8Ynv-0002No-WE; Mon, 25 May 2009 13:57:19 +0200
In-Reply-To: <alpine.DEB.1.00.0905251341370.4288@intel-tinevez-2-302> (Johannes Schindelin's message of "Mon\, 25 May 2009 13\:43\:15 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Mon, 25 May 2009 13:57:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119926>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I disagree... The worst solution is to stop working at all.  A better 
> solution would be to ignore the unnamed head,

... or to import the commits of this unnamed head, without setting a
Git reference to it (with a message on the console saying stg like
"Unnamed head imported as commit %s\n" to let the user do something
with the sha1).

> and the best solution would probably be to generate ref names that
> are _not_ branch names for such heads.

Stg like refs/hg-heads/<branch>/<number> ? (seems to be accepted in
the Git namespace)

(my 2 cents)

-- 
Matthieu
