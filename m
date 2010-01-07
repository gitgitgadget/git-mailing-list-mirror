From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: origin/branchname and tracking branch pointing to different commits?
Date: Thu, 07 Jan 2010 18:06:34 +0100
Message-ID: <vpqmy0plu91.fsf@bauges.imag.fr>
References: <76c5b8581001070903i3810f63crd764d451f7454584@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 18:06:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSvor-0002KU-N7
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 18:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473Ab0AGRGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 12:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752418Ab0AGRGl
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 12:06:41 -0500
Received: from mx1.imag.fr ([129.88.30.5]:41275 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172Ab0AGRGk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 12:06:40 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o07H6VkD029455
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 7 Jan 2010 18:06:31 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NSvog-0007MV-RV; Thu, 07 Jan 2010 18:06:34 +0100
In-Reply-To: <76c5b8581001070903i3810f63crd764d451f7454584@mail.gmail.com> (Eugene Sajine's message of "Thu\, 7 Jan 2010 12\:03\:45 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 07 Jan 2010 18:06:31 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o07H6VkD029455
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1263488791.54278@Lda/unoCqeLuANPP0JAJbA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136359>

Eugene Sajine <euguess@gmail.com> writes:

> gives me qa branch history advanced by 4 commits comparing to
> origin/qa

This means you have local commits which are not in the remote branch.

> $git pull origin qa

If you want to send your local commits, use "git push".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
