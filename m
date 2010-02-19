From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Is git over http (git-http-push) ready for production ?
Date: Fri, 19 Feb 2010 14:46:39 +0100
Message-ID: <vpqr5ohz6bk.fsf@bauges.imag.fr>
References: <hllp07$o78$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Fabien <fabien.ubuntu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 14:50:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiTFE-0004Z9-O8
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 14:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786Ab0BSNuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 08:50:06 -0500
Received: from imag.imag.fr ([129.88.30.1]:60087 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752383Ab0BSNuE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 08:50:04 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o1JDkdZ3000155
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 19 Feb 2010 14:46:40 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NiTBn-0003zh-NG; Fri, 19 Feb 2010 14:46:39 +0100
In-Reply-To: <hllp07$o78$1@ger.gmane.org> (Fabien's message of "Fri\, 19 Feb 2010 11\:26\:16 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 19 Feb 2010 14:46:40 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140450>

Fabien <fabien.ubuntu@gmail.com> writes:

> Hi,
>
> Following my last email about locks problem with reiserfs (see
> git-http-push (git v1.5) problems with DAVLockDB on reiserfs FS), I was
> wondering how reliable is git-http-push.

My experience is: it mostly works, but sometimes break, usually
doesn't give very helpfull messages when you mis-use it, ...

Rather clearly, git-http-push doesn't have as many users as ssh://,
read-only http:// and git://, and therefore doesn't have as many
testers/developers.

If "production" means "many users" and "need for something
unbreakable", then perhaps the HTTP smart protocol is more promising.

But that's just my experience.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
