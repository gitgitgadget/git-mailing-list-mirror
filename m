From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: date change of commit?
Date: Sun, 25 Oct 2009 18:14:38 +0100
Message-ID: <vpq1vkrqttt.fsf@bauges.imag.fr>
References: <e4a904790910250435p3ff50dcfv5c0c6a86c13d17b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex K <spaceoutlet@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 18:17:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N26ix-0003iV-CO
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 18:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661AbZJYRRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 13:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753437AbZJYRRf
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 13:17:35 -0400
Received: from imag.imag.fr ([129.88.30.1]:49495 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753359AbZJYRRf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 13:17:35 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n9PHEcOD009513
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 25 Oct 2009 18:14:38 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1N26fu-0001qX-IM; Sun, 25 Oct 2009 18:14:38 +0100
In-Reply-To: <e4a904790910250435p3ff50dcfv5c0c6a86c13d17b@mail.gmail.com> (Alex K.'s message of "Sun\, 25 Oct 2009 12\:35\:23 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 25 Oct 2009 18:14:38 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131225>

Alex K <spaceoutlet@gmail.com> writes:

> Hello,
>
> Is it possible to change the date of a commit?

See git-filter-branch. This won't change the date of the existing
commit (which is impossible in Git), but will create another commit
where only the date has been changed.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
