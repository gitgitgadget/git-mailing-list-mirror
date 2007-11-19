From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [user] git-svn and svn cp
Date: Mon, 19 Nov 2007 14:49:56 +0100
Message-ID: <vpqtzni1h17.fsf@bauges.imag.fr>
References: <47416F68.9070908@ogersoft.at> <vpq3av25sg0.fsf@bauges.imag.fr>
	<86k5oez9f5.fsf@lola.quinscape.zz> <vpqzlxa2y2f.fsf@bauges.imag.fr>
	<EB96D9F3-D69C-4D46-961C-27885CBC0E52@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gerhard.oettl.ml@ogersoft.at, David Kastrup <dak@gnu.org>,
	Git Mailing List <git@vger.kernel.org>
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Mon Nov 19 14:51:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu723-0002Mv-KC
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 14:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbXKSNvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 08:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752843AbXKSNvF
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 08:51:05 -0500
Received: from imag.imag.fr ([129.88.30.1]:57524 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752829AbXKSNvE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 08:51:04 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lAJDo3BN020592
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 19 Nov 2007 14:50:03 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Iu70e-0006sK-R5; Mon, 19 Nov 2007 14:49:56 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Iu70e-0006Cc-OU; Mon, 19 Nov 2007 14:49:56 +0100
In-Reply-To: <EB96D9F3-D69C-4D46-961C-27885CBC0E52@lrde.epita.fr> (Benoit Sigoure's message of "Mon\, 19 Nov 2007 14\:20\:09 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 19 Nov 2007 14:50:04 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65445>

Benoit Sigoure <tsuna@lrde.epita.fr> writes:

>> Not in the details. Well, I believe the accurate question (to original
>> poster) is: does your svn repository use the standard svn layout
>> (tags/, branches/, trunk/)?
>
> I think this is irrelevant to the question he asked.

Well, I'm far enough from being a git-svn expert, but I suppose
git-svn will special-case the content of tags/ and branches/
directories, and consider copies there to be tags and branches. I
don't know whether git-svn does it efficiently, though.

If you use "svn copy" with the meaning "create a tag" with a
destination other than tags/ directory, then, git-svn can not guess it
was actually a tag.

-- 
Matthieu
