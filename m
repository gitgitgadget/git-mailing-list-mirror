From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/6] show: obey --textconv for blobs
Date: Mon, 22 Apr 2013 17:54:33 +0200
Message-ID: <vpqfvyi7e86.fsf@grenoble-inp.fr>
References: <1547528401.1826118.1366645060312.JavaMail.root@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeremy Rosen <jeremy.rosen@openwide.fr>
X-From: git-owner@vger.kernel.org Mon Apr 22 17:56:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUJ6v-0000nv-1n
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 17:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895Ab3DVP4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 11:56:53 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57368 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753559Ab3DVP4w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 11:56:52 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r3MFsWgO003779
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 22 Apr 2013 17:54:32 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UUJ4c-00070P-7k; Mon, 22 Apr 2013 17:54:34 +0200
In-Reply-To: <1547528401.1826118.1366645060312.JavaMail.root@openwide.fr>
	(Jeremy Rosen's message of "Mon, 22 Apr 2013 17:37:40 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 22 Apr 2013 17:54:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3MFsWgO003779
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1367250877.18485@9mkvkz4YwexBOOZgHcqG5A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222033>

Jeremy Rosen <jeremy.rosen@openwide.fr> writes:

> some features detect if they are piping to a terminal... couldn't we do
> something like that ?

That's OK for convenience features like colors or so, but that would be
really, really unexpected to have

$ git show HEAD:file
foo
$ git show HEAD:file > tmp
$ cat tmp
bar

IMHO.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
