From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Fix incorrect wording in git-merge.txt.
Date: Mon, 03 Mar 2008 20:50:39 +0100
Message-ID: <vpqlk4zoacw.fsf@bauges.imag.fr>
References: <1204564483-5260-1-git-send-email-Matthieu.Moy@imag.fr>
	<alpine.LFD.1.00.0803031320180.2899@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 20:53:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWGil-0003VI-L2
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 20:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbYCCTwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 14:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbYCCTwe
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 14:52:34 -0500
Received: from imag.imag.fr ([129.88.30.1]:49737 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771AbYCCTwd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 14:52:33 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m23Joi3x014370
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 3 Mar 2008 20:50:44 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JWGgJ-0006EV-4V; Mon, 03 Mar 2008 20:50:39 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JWGgJ-00026u-2B; Mon, 03 Mar 2008 20:50:39 +0100
In-Reply-To: <alpine.LFD.1.00.0803031320180.2899@xanadu.home> (Nicolas Pitre's message of "Mon\, 03 Mar 2008 13\:26\:42 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 03 Mar 2008 20:50:45 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75978>

Nicolas Pitre <nico@cam.org> writes:

> You don't really merge a commit _object_.
> You merge with one or more other commits, tipycally identified by a 
> branch name or a tag.

Strictly speaking, you can merge any commit, not necessarily a branch
or a tag. That can be "git merge 66f0a4d" or whatever. Admitedly, the
common case is to merge a tag or a branch (which is why I keep it in
parentheses).

Now, I don't understand the distinction you seem to be making between
"commit" and "commit object".

-- 
Matthieu
