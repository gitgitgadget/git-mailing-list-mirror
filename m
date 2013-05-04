From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Another use of "@"?
Date: Sat, 04 May 2013 23:11:44 +0200
Message-ID: <vpqtxmi8n73.fsf@grenoble-inp.fr>
References: <CACsJy8AcWV8hmbhG27dw+GdnZf8NnQEctYmowqd3sSzOOHf+xg@mail.gmail.com>
	<CALkWK0=qdGcbQDz2VomhOcy7AybXj5jkxzS53jFGyjdZ9+6juQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 04 23:12:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYjkR-0007Dh-KO
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 23:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757340Ab3EDVLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 17:11:48 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56876 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754282Ab3EDVLr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 17:11:47 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r44LBf1S008474
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 4 May 2013 23:11:41 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UYjk8-0007Tq-Bu; Sat, 04 May 2013 23:11:44 +0200
In-Reply-To: <CALkWK0=qdGcbQDz2VomhOcy7AybXj5jkxzS53jFGyjdZ9+6juQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Sat, 4 May 2013 18:14:07 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 04 May 2013 23:11:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r44LBf1S008474
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1368306703.01821@idGLTy9ISV6aEkP5hkzxuQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223378>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> On Matthieu's note, I have a comment: symbolic refs are an absolute
> dead end.  We didn't think of it from the start, and it's too late
> now.  Do NOT go there: from my investigation, I believe that hooking
> up everything to the revision parser is the way forward.

My comment was not about the solution, but about the problem (which
seemed to have been misunderstood). The question seems to be "get the
reference with the same names as what HEAD points to, but on remote A",
and the "points to" part is about symbolic references.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
