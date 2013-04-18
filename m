From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git over HTTPS with basic authentication
Date: Thu, 18 Apr 2013 21:54:32 +0200
Message-ID: <vpq8v4f62dj.fsf@grenoble-inp.fr>
References: <1366314422.12299.3.camel@sibbo-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sebastian Schmidt <isibboi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 21:54:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USuut-0002Y6-9B
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 21:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936553Ab3DRTyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 15:54:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55844 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936486Ab3DRTym (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 15:54:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r3IJsUMH016568
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 18 Apr 2013 21:54:30 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1USuuf-0004rT-3Z; Thu, 18 Apr 2013 21:54:33 +0200
In-Reply-To: <1366314422.12299.3.camel@sibbo-laptop> (Sebastian Schmidt's
	message of "Thu, 18 Apr 2013 21:47:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 18 Apr 2013 21:54:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3IJsUMH016568
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1366919672.77036@Rbkgi9TxxuZaEWrvpNzO1w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221689>

Sebastian Schmidt <isibboi@gmail.com> writes:

> Why is git not working over HTTPS with basic authentication? I can clone
> just fine, but when I try to push, it tells me

What are you using on the server? Dumb HTTP works by serving the
repository files as static pages, which is fundamentally read-only. The
recommended way is to use smart-HTTP (see man git-http-backend, requires
Git on the server), and the alternative is to use webdav (much slower).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
