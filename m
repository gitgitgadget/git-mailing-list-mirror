From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: "git stash" is not known to git
Date: Mon, 30 Jul 2007 11:44:31 +0200
Message-ID: <vpqwswi2pkw.fsf@bauges.imag.fr>
References: <86bqduutz4.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 11:45:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFRoN-0007nw-EX
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 11:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936415AbXG3JpI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 05:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935502AbXG3JpH
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 05:45:07 -0400
Received: from imag.imag.fr ([129.88.30.1]:36317 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932499AbXG3JpG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 05:45:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l6U9iVVV023167
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 30 Jul 2007 11:44:31 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IFRnj-0005ZG-ER; Mon, 30 Jul 2007 11:44:31 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IFRnj-0002bG-B4; Mon, 30 Jul 2007 11:44:31 +0200
Mail-Followup-To: David Kastrup <dak@gnu.org>, git@vger.kernel.org
In-Reply-To: <86bqduutz4.fsf@lola.quinscape.zz> (David Kastrup's message of "Mon\, 30 Jul 2007 11\:22\:07 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 30 Jul 2007 11:44:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54214>

David Kastrup <dak@gnu.org> writes:

> One has to use git-stash rather than "git stash".  Oversight?

This looks like an incorrect installation, with git-stash in your
$PATH, but not in the place git looks for its commands (I don't
remember the exact mechanism).

-- 
Matthieu
