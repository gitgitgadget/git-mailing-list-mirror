From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Cannot rewrite branch(es) with a dirty working directory
Date: Thu, 01 Sep 2011 19:14:30 +0200
Message-ID: <vpqmxeoqj61.fsf@bauges.imag.fr>
References: <CACyv8dfL-G0Px0aFe3VFNHP-1xRUDLsFxgUu3amPGzO7qKp7jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: James Blackburn <jamesblackburn@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 01 19:14:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzAqi-0006vU-Ej
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 19:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755868Ab1IAROi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 13:14:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45231 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755404Ab1IAROi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 13:14:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p81HDnXH021007
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 1 Sep 2011 19:13:49 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QzAqV-0003U4-4v; Thu, 01 Sep 2011 19:14:31 +0200
In-Reply-To: <CACyv8dfL-G0Px0aFe3VFNHP-1xRUDLsFxgUu3amPGzO7qKp7jQ@mail.gmail.com>
	(James Blackburn's message of "Thu, 1 Sep 2011 16:52:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 01 Sep 2011 19:13:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p81HDnXH021007
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1315502030.32973@rlilofnuHkPc1tK9Ubs3rg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180553>

James Blackburn <jamesblackburn@gmail.com> writes:

> Is there a particular reason why filter-branch thinks the tree is
> dirty,

No idea. It comes after a "git reset --hard", so it's supposed to be
clean.

> and status magically fixes this?

The index is considered dirty if the stat information (timestamp) is
different. "git status" updates the stat-cache to consider unmodified
content as up-to-date. So, it's normal that a "git status" repairs the
dirty index.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
