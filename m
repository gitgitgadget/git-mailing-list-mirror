From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] commit: fix memory-leak
Date: Mon, 07 Feb 2011 19:48:02 +0100
Message-ID: <vpqei7jfzq5.fsf@bauges.imag.fr>
References: <1297104044-4684-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com, blees@dcon.de
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 19:48:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmW8G-0001fI-IG
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 19:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489Ab1BGSsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 13:48:10 -0500
Received: from mx2.imag.fr ([129.88.30.17]:54204 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754234Ab1BGSsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 13:48:09 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p17Im1eS022707
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 7 Feb 2011 19:48:01 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PmW82-0005Pf-PM; Mon, 07 Feb 2011 19:48:02 +0100
In-Reply-To: <1297104044-4684-1-git-send-email-kusmabite@gmail.com> (Erik Faye-Lund's message of "Mon\,  7 Feb 2011 19\:40\:44 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 07 Feb 2011 19:48:01 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p17Im1eS022707
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1297709284.91486@EPLDs9jXNWe2r7qdtcgPtQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166270>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> At the same time, this fixes a problem with strict-POSIX getenv
> implementations. POSIX says "The return value from getenv() may
> point to static data which may be overwritten by subsequent calls
> to getenv()", so duplicating the strings is a potential bug.
                  ^
                 not
?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
