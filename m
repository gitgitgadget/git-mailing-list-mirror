From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Rewriting git-repack.sh in C
Date: Mon, 05 Aug 2013 12:34:27 +0200
Message-ID: <vpqy58g2zpo.fsf@anie.imag.fr>
References: <51FBB8CB.8020600@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 12:34:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6I7b-0002cL-3h
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 12:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584Ab3HEKef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 06:34:35 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40204 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607Ab3HEKee (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 06:34:34 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r75AYQ6M005559
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 5 Aug 2013 12:34:26 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V6I7P-0004m4-M8; Mon, 05 Aug 2013 12:34:27 +0200
In-Reply-To: <51FBB8CB.8020600@googlemail.com> (Stefan Beller's message of
	"Fri, 02 Aug 2013 15:48:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 05 Aug 2013 12:34:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r75AYQ6M005559
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1376303668.22587@SSLeFUkV38U1gz+SGm6cxA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231642>

Stefan Beller <stefanbeller@googlemail.com> writes:

> Hello,
>
> I'd like to rewrite the repack shell script in C.
> So I tried the naive approach reading the man page and 
> the script itself and write C program by matching each block/line 
> of the script with a function in C

You should add one step here: check that tests are good, and possibly
add some to improve coverage. It's easier to add tests when you already
have a reference implementation.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
