From: Sergei Organov <osv@javad.com>
Subject: Re: untracked file deleted from the master branch, when checked out to it from a local branch
Date: Wed, 21 May 2014 14:21:40 +0400
Message-ID: <8761kz5t57.fsf@osv.gnss.ru>
References: <2525467.KRXv8a3gWS@linux-wzza.site>
	<2726779.MFtIaLB4b4@linux-wzza.site>
	<xmqqk39gz4tw.fsf@gitster.dls.corp.google.com>
	<2654529.8c5AhJCJsq@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Arup Rakshit <aruprakshit@rocketmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 12:31:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn3na-0002iY-UD
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 12:31:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbaEUKa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 06:30:59 -0400
Received: from mail.javad.com ([54.86.164.124]:44148 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781AbaEUKa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 06:30:58 -0400
X-Greylist: delayed 554 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 May 2014 06:30:58 EDT
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 98C6F60C03;
	Wed, 21 May 2014 10:21:42 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <s.organov@javad.com>)
	id 1Wn3eW-0003Xz-Qg; Wed, 21 May 2014 14:21:40 +0400
In-Reply-To: <2654529.8c5AhJCJsq@linux-wzza.site> (Arup Rakshit's message of
	"Wed, 21 May 2014 00:10:47 +0630")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249787>

Arup Rakshit <aruprakshit@rocketmail.com> writes:


[...]

> Now you can see, that I have created, a new file called *file.txt*, in the 
> *master branch*.

And here is your basic misunderstanding. You've created file.txt indeed,
but not in the *master branch* (or any branch). You've created it in the
working directory. Only after you add/commit it, will it be "created" in
the branch that is checked out at this time. Until then, git won't touch
the file when you switch between branches.

-- Sergey.
