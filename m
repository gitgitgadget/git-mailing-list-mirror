From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] pull: clarify the large && { ... } form
Date: Fri, 14 Jun 2013 11:09:50 +0200
Message-ID: <vpqr4g5kqht.fsf@anie.imag.fr>
References: <1371200178-9927-1-git-send-email-artagnon@gmail.com>
	<1371200178-9927-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 11:10:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnQ1A-0001Xb-Lr
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 11:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050Ab3FNJJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 05:09:56 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45300 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707Ab3FNJJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 05:09:56 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5E99nCv009747
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 14 Jun 2013 11:09:49 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UnQ10-0005hx-E5; Fri, 14 Jun 2013 11:09:50 +0200
In-Reply-To: <1371200178-9927-3-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 14 Jun 2013 14:26:18 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 14 Jun 2013 11:09:50 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227799>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> -test true = "$rebase" && {
> +if test true = "$rebase"; then

Use a newline, not a ';'.

See CodingGuideLines:

 - Do not write control structures on a single line with semicolon.
   "then" should be on the next line for if statements, and "do"
   should be on the next line for "while" and "for".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
