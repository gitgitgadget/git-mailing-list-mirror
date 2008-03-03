From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Fix incorrect wording in git-merge.txt.
Date: Mon, 03 Mar 2008 22:25:22 +0100
Message-ID: <vpqwsojlcu5.fsf@bauges.imag.fr>
References: <1204564483-5260-1-git-send-email-Matthieu.Moy@imag.fr>
	<alpine.LFD.1.00.0803031320180.2899@xanadu.home>
	<vpqlk4zoacw.fsf@bauges.imag.fr>
	<alpine.LFD.1.00.0803031519360.2899@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 22:35:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWIJI-0000IA-Oc
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 22:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbYCCVeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 16:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbYCCVeW
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 16:34:22 -0500
Received: from imag.imag.fr ([129.88.30.1]:50658 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908AbYCCVeV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 16:34:21 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m23LPMPp003020
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 3 Mar 2008 22:25:23 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JWI9y-0000Gw-3X; Mon, 03 Mar 2008 22:25:22 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JWI9y-0002Mr-10; Mon, 03 Mar 2008 22:25:22 +0100
In-Reply-To: <alpine.LFD.1.00.0803031519360.2899@xanadu.home> (Nicolas Pitre's message of "Mon\, 03 Mar 2008 15\:39\:31 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 03 Mar 2008 22:25:25 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75985>

Nicolas Pitre <nico@cam.org> writes:

>> Now, I don't understand the distinction you seem to be making between
>> "commit" and "commit object".
>
> Objects are what the low level storage is made of.  Conceptually, The 
> merge operation doesn't work at the object level, but rather at the 
> history graph level.

I still don't get the distinction. What is the "graph" if not a set of
objects pointing to each other?

If you don't want to talk about commit object, then you should fix
also user-manual.txt (for example, it states that a merge "create a
commit object in the history").

Well, that said, the same sentence as the one I propose without
"object" is fine to me, but I just don't understand the difference.

-- 
Matthieu
