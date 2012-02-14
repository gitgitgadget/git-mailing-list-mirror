From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Setting up a Git server (+ gitweb) with .htaccess files HOWTO
Date: Tue, 14 Feb 2012 09:59:49 +0100
Message-ID: <vpq7gzpx01m.fsf@bauges.imag.fr>
References: <vpqbop266ak.fsf@bauges.imag.fr>
	<7v1upyft1b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 10:00:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxEFG-0005DK-Ba
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 10:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759748Ab2BNJAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 04:00:14 -0500
Received: from mx2.imag.fr ([129.88.30.17]:49509 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759729Ab2BNJAD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 04:00:03 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q1E8uXfF001444
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 14 Feb 2012 09:56:34 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RxEEo-0002RU-L4; Tue, 14 Feb 2012 09:59:50 +0100
In-Reply-To: <7v1upyft1b.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 13 Feb 2012 11:10:56 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 14 Feb 2012 09:56:34 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q1E8uXfF001444
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1329814595.46462@h54BjVpnStDfVosXAUeOtw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190710>

Junio C Hamano <gitster@pobox.com> writes:

> After seeing the section that runs "git init" in a throw-away CGI script,
> I started wondering what the point of this site in forbidding a shell
> access in the first place.

The sysadmin trusts users enough to allow running arbitrary CGI there.
Not giving shell access greatly limits the accidental mis-uses of the
server, or silly attacks by incompetent users (i.e. "students" ;-) ). A
few years ago, people had shell access on most servers, and they were
using it to run seti@home & other heavy stuff there.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
