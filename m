From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Bug in "git show"?
Date: Mon, 15 Jul 2013 14:12:19 +0200
Message-ID: <vpqa9lof2e4.fsf@anie.imag.fr>
References: <51E3DC47.70107@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 14:12:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uyhdk-0000PN-GJ
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 14:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422Ab3GOMMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 08:12:24 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38411 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755262Ab3GOMMX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 08:12:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r6FCCI4j028622
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Jul 2013 14:12:18 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Uyhdb-0008Dw-UD; Mon, 15 Jul 2013 14:12:19 +0200
In-Reply-To: <51E3DC47.70107@googlemail.com> (Stefan Beller's message of "Mon,
	15 Jul 2013 13:25:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 15 Jul 2013 14:12:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r6FCCI4j028622
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1374495139.63776@yMRRcH7iMPMAA8bQk6DpIw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230458>

Stefan Beller <stefanbeller@googlemail.com> writes:

> However I sometimes also get:
> sb@sb:~/OSS/git$ git show --format="%ad" 0da7a53
> Fri Jul 12 10:49:34 2013 -0700
>
> diff --git a/Documentation/RelNotes/1.8.4.txt
> b/Documentation/RelNotes/1.8.4.txt
> index 0e50df8..4250e5a 100644
> --- a/Documentation/RelNotes/1.8.4.txt
> +++ b/Documentation/RelNotes/1.8.4.txt

"git show" will show the diff by default. For merge commits, it shows
the --cc diff which is often empty, hence the behavior you see.

You want to use "git show -s", which suppresses the patch output.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
