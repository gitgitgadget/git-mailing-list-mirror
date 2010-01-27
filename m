From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Testing if a certain commit is in the current branch
Date: Wed, 27 Jan 2010 09:26:22 +0100
Message-ID: <vpqiqaonec1.fsf@bauges.imag.fr>
References: <201001270819.39819.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
X-From: git-owner@vger.kernel.org Wed Jan 27 09:30:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na3I9-0001G0-0I
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 09:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821Ab0A0I3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 03:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753121Ab0A0I3k
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 03:29:40 -0500
Received: from imag.imag.fr ([129.88.30.1]:59088 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752626Ab0A0I3c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 03:29:32 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o0R8QRmQ005495
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 27 Jan 2010 09:26:27 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Na3EE-000898-Pp; Wed, 27 Jan 2010 09:26:22 +0100
In-Reply-To: <201001270819.39819.elendil@planet.nl> (Frans Pop's message of "Wed\, 27 Jan 2010 08\:19\:39 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 27 Jan 2010 09:26:28 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138113>

Frans Pop <elendil@planet.nl> writes:

> I'm currently using the following command for this:
>    git log --pretty=format:%H | grep -q '^<commit id>"
>
> Problem is that with large repos that can be quite slow.
>
> Is there a faster way to do the test?

Not answering the question exactly, but "git branch --contains <commitid>"
does almost this and a bit more.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
