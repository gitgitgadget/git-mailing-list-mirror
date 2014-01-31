From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Having Git follow symlinks
Date: Fri, 31 Jan 2014 10:56:41 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1401311052370.3993@ds9.cixit.se>
References: <alpine.DEB.2.02.1401281443330.17426@perkele.intern.softwolves.pp.se> <CALKQrgf5o-ZcaeqXLm3P7RpK2yPcFd_HnG4ewwoEGESduyDSjQ@mail.gmail.com> <alpine.DEB.2.00.1401300958320.30100@ds9.cixit.se> <vpqa9ed1w8y.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jan 31 10:57:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9Aqd-0006vJ-0i
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 10:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbaAaJ4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 04:56:48 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:56892 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751006AbaAaJ4r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 04:56:47 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id s0V9ugkY004982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 31 Jan 2014 10:56:42 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id s0V9ufn7004979;
	Fri, 31 Jan 2014 10:56:42 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <vpqa9ed1w8y.fsf@anie.imag.fr>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Fri, 31 Jan 2014 10:56:42 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241294>

Matthieu Moy:

> One option is to have the symlink in the other direction: make 
> /etc/foo a symlink to $GIT_WORKTREE/foo and version the later.

I do that for the software that supports it, but ssh, for instance, is 
very picky that ~/.ssh is a directory and such. And at least one of 
the other files I version-control will be unlinked and overwritten in 
such a way that that does not work.

I could split the repo up (that seems to be what "vcsh" is doing) and 
check the parts out in the corresponding directories, but I do like 
the idea of having one single repo.


Oh, well, if I have the time, maybe I can come up with a patch. There 
is already some hacks in the "core.symlinks" setting, so I guess it 
should be possible.

-- 
\\// Peter - http://www.softwolves.pp.se/
