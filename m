From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git: "No you can't handle my root!" (?)
Date: Mon, 12 Oct 2009 21:02:08 +0200
Message-ID: <vpqfx9oxwpb.fsf@bauges.imag.fr>
References: <20091012012826.7sffggwmm8sk0cc8@webmail.demarque.qc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: sylvain@demarque.qc.ca
X-From: git-owner@vger.kernel.org Mon Oct 12 21:09:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxQHL-0001BQ-Uo
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 21:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757360AbZJLTCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 15:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757282AbZJLTCy
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 15:02:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57505 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756563AbZJLTCx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 15:02:53 -0400
Received: from archeboc.imag.fr (archeboc.imag.fr [129.88.43.1])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n9CJ1v4d002497
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 12 Oct 2009 21:01:57 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by archeboc.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1MxQ9o-0001ST-GH; Mon, 12 Oct 2009 21:02:08 +0200
In-Reply-To: <20091012012826.7sffggwmm8sk0cc8@webmail.demarque.qc.ca> (sylvain@demarque.qc.ca's message of "Mon\, 12 Oct 2009 01\:28\:26 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 12 Oct 2009 21:01:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n9CJ1v4d002497
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1255978918.77573@bb98UzwLcsrssPcr3UvcnA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130053>

sylvain@demarque.qc.ca writes:

> localhost / # cd etc
> localhost etc # git add X11/xorg.conf
> fatal: pathspec 'etc/X11/xorg.conf' did not match any files

cd ..
git add etc/X11/xorg.conf

works. I don't know why the other doesn't (just tested adding from an
untracked directory in another project, it does work).

If you want to version a large directory like /, I'd advise putting
"*" in /.gitignore to make sure Git never tries to traverse the whole
filesystem.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
