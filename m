From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH 3/3] The "curl" executable is no longer required
Date: Sun, 15 Jun 2008 14:04:50 +0200
Message-ID: <vpqej6ylx99.fsf@bauges.imag.fr>
References: <200806120920.31161.johan@herland.net>
	<ee77f5c20806150352n6ccf00e9w8083a17d8c5c2326@mail.gmail.com>
	<m3fxreq60t.fsf@localhost.localdomain>
	<200806151347.31676.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	David Symonds <dsymonds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 15 14:07:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7r13-0000IL-FL
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 14:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339AbYFOMGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 08:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757337AbYFOMGb
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 08:06:31 -0400
Received: from imag.imag.fr ([129.88.30.1]:59294 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757307AbYFOMGa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 08:06:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m5FC5HWP011302
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 15 Jun 2008 14:05:17 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1K7qyY-0001l6-Co; Sun, 15 Jun 2008 14:04:50 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1K7qyY-0004KZ-AR; Sun, 15 Jun 2008 14:04:50 +0200
In-Reply-To: <200806151347.31676.johan@herland.net> (Johan Herland's message of "Sun\, 15 Jun 2008 13\:47\:31 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 15 Jun 2008 14:05:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85084>

Johan Herland <johan@herland.net> writes:

> On Sunday 15 June 2008, Jakub Narebski wrote:
>> It is not necessary to enumerate simple library dependencies, as
>> rpmbuild _detects_ those dependencies during building binary RPMS.

Good to know, and that seems to be a valid argument ("seems to"
because of my lack of knowledge of rpm, not lack of trust ;-) ).

>> Besides it worked without libcurl in Requires, so it should
>> continue to work without it, isn't it?

It used to have a dependency on curl, which itself requires libcurl,
so the dependency was implicit.

> Someone with more RPM knowledge will have to determine which is
> right.

+1

-- 
Matthieu
