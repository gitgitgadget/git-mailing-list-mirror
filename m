From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Octopus merge: unique (?) to git, but is it useful?
Date: Tue, 03 Jun 2008 13:53:47 +0200
Message-ID: <vpqlk1mu438.fsf@bauges.imag.fr>
References: <200806030314.03252.jnareb@gmail.com>
	<vpqabi2zvci.fsf@bauges.imag.fr> <200806031327.52175.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 13:55:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3V79-000284-7y
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 13:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125AbYFCLys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 07:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752995AbYFCLys
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 07:54:48 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:61966 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752780AbYFCLyr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 07:54:47 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m53Brqjm020248;
	Tue, 3 Jun 2008 13:53:52 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1K3V5H-0001Cm-8I; Tue, 03 Jun 2008 13:53:47 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1K3V5H-0002mB-60; Tue, 03 Jun 2008 13:53:47 +0200
In-Reply-To: <200806031327.52175.jnareb@gmail.com> (Jakub Narebski's message of "Tue\, 3 Jun 2008 13\:27\:51 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Tue, 03 Jun 2008 13:53:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83644>

Jakub Narebski <jnareb@gmail.com> writes:

> On Tue, 3 June 2008, Matthieu Moy wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>>> I think that octopus merge (merge with more than two parents/legs) is 
>>> feature which is unique to git (isn't it?).  
>> 
>> bzr can do similar things:
>> 
>> bzr merge some-branch
>> bzr merge --force some-other-branch
>> bzr commit
>> 
>> Since bzr doesn't auto-commit after a merge, the above commands
>> actually creates only one revision with 3 parents (the --force is here
>> to let merge do it's job with uncommited changes in the tree).
>
> But does it store octopus merge as octopus: commit with more than
> two parents?

Yes, it's actually a single commit object with 3 parents.

-- 
Matthieu
