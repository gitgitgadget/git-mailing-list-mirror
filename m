From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Are non regression tests available ?
Date: Fri, 22 Jun 2012 11:20:57 +0200
Message-ID: <vpqk3yzpurq.fsf@bauges.imag.fr>
References: <1340356664063-7561954.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: lalebarde <l.alebarde@free.fr>
X-From: git-owner@vger.kernel.org Fri Jun 22 11:21:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si03F-0008C4-Im
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 11:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758721Ab2FVJVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 05:21:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50010 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758634Ab2FVJVF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 05:21:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5M9KXNS006587
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 22 Jun 2012 11:20:33 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Si02z-00041b-PZ; Fri, 22 Jun 2012 11:20:57 +0200
In-Reply-To: <1340356664063-7561954.post@n2.nabble.com> (lalebarde's message
	of "Fri, 22 Jun 2012 02:17:44 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 22 Jun 2012 11:20:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5M9KXNS006587
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340961638.08859@vnJxGeNONj/cq750z/qziw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200430>

lalebarde <l.alebarde@free.fr> writes:

> Hi all,
> Though the documentation of Git is very good, I remain puzzled on the
> accurate workflow between /working/stagging/repository/ areas versus
> /text/indent/filter/sha1/diff/ operations.
> *Is there somewhere a set of non regression tests covering all Git
> functionalities that would enable to see exactly what happens and what is
> expected ?*

Yes, in the t/ directory of the Git source distribution. But I don't
think you want to read this to _understand_ how Git works ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
