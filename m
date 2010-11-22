From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Setting http proxy and http password
Date: Mon, 22 Nov 2010 23:50:12 +0100
Message-ID: <vpqeiadc6sb.fsf@bauges.imag.fr>
References: <o28rr7-5r4.ln1@homer.bruehl.pontohonk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christoph Bartoschek <bartoschek@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 22 23:50:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKfDP-0008SM-94
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 23:50:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211Ab0KVWuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 17:50:21 -0500
Received: from mx2.imag.fr ([129.88.30.17]:55763 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932166Ab0KVWuV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 17:50:21 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id oAMMnxIc007483
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 22 Nov 2010 23:49:59 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PKfDB-0004Xp-5k; Mon, 22 Nov 2010 23:50:13 +0100
In-Reply-To: <o28rr7-5r4.ln1@homer.bruehl.pontohonk.de> (Christoph Bartoschek's message of "Mon\, 22 Nov 2010 23\:39\:52 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 22 Nov 2010 23:49:59 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oAMMnxIc007483
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1291071003.40636@zLIny6T1PZIv52LWgbi82Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161916>

Christoph Bartoschek <bartoschek@gmx.de> writes:

> 1. How can I set the proxy that should be used for git commands? For 
> externals pages I have a proxy. But for our git server no proxy should be 
> used. How can I configure git to never use the proxy?

Search for proxy here:

http://www.kernel.org/pub/software/scm/git/docs/git-config.html

but I think the more or less standard $http_proxy environment variable
does the trick.

> 2. How can I have git remember the username and password for our git server?

Either use ~/.netrc (see
http://www.kernel.org/pub/software/scm/git/docs/howto/setup-git-server-over-http.txt ),
or set the URL of the remote repo to
http(s)://user:password@server.com/path in .git/config (after
restricting read permissions on this file appropriately, of course).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
