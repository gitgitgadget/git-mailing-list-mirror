From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] userdiff: funcname and word patterns for sh
Date: Mon, 09 Mar 2015 21:34:39 +0100
Message-ID: <vpqy4n53o68.fsf@anie.imag.fr>
References: <1425918999-11992-1-git-send-email-adrien+dev@schischi.me>
	<1425918999-11992-2-git-send-email-adrien+dev@schischi.me>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Adrien Schildknecht <adrien+dev@schischi.me>
X-From: git-owner@vger.kernel.org Mon Mar 09 21:34:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV4O2-000798-6K
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 21:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbbCIUep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 16:34:45 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55300 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107AbbCIUeo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 16:34:44 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t29KYaUe001032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 9 Mar 2015 21:34:36 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t29KYdvP020107;
	Mon, 9 Mar 2015 21:34:39 +0100
In-Reply-To: <1425918999-11992-2-git-send-email-adrien+dev@schischi.me>
	(Adrien Schildknecht's message of "Mon, 9 Mar 2015 17:36:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 09 Mar 2015 21:34:36 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t29KYaUe001032
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1426538077.60547@i5t+1Hw3QwhOzpBebDOoyA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265193>

Adrien Schildknecht <adrien+dev@schischi.me> writes:

> +	"^([ \t]*(function[ \t]*)?[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\).*)$",

I guess this should be 'function[ \t]+' (+, not *).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
