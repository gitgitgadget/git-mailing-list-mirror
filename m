From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: WANTED: patch splitting tool - waypoints
Date: Sun, 02 May 2010 17:20:53 +0200
Message-ID: <vpqpr1euy7e.fsf@bauges.imag.fr>
References: <20100502115842.GA11607@brong.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bron Gondwana <brong@brong.net>
X-From: git-owner@vger.kernel.org Sun May 02 17:21:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8aym-0000RT-Gl
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 17:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906Ab0EBPVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 11:21:07 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58522 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754243Ab0EBPVF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 11:21:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o42FF4NY027657
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 2 May 2010 17:15:04 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1O8ayT-0005SC-B1; Sun, 02 May 2010 17:20:53 +0200
In-Reply-To: <20100502115842.GA11607@brong.net> (Bron Gondwana's message of "Sun\, 2 May 2010 21\:58\:42 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 02 May 2010 17:15:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o42FF4NY027657
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1273418106.52476@UoKhoBpJKh90W9cEluCc/A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146183>

Bron Gondwana <brong@brong.net> writes:

> And a graphical/
> ncurses interface like the kernel's "make menuconfig" at
> the very least would make it much easier than paging
> through piles of diff fragments and hoping you never
> made a mistake.

About the "never made a mistake" part, if you mistakenly add a hunk
with "git add -p", then "git reset -p" (in recent enough Git's) is
your friend.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
