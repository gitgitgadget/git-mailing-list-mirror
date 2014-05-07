From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] Windows: Always normalize paths to Windows-style
Date: Wed, 7 May 2014 20:44:44 +0200
Message-ID: <20140507184444.GB4013@sandbox-ub>
References: <20140428083931.GA10257@camelia.ucw.cz>
 <CABPQNSaC30p7TEOvc85u=+skjrFj17182vWWSL=QNVuvzVFE=w@mail.gmail.com>
 <20140428113815.GA10559@camelia.ucw.cz>
 <20140428114224.GA11186@camelia.ucw.cz>
 <CABPQNSbDkE+Vff=4MmPO9oMfjRay6Oin51zZRoZ8mOEhGoaD3Q@mail.gmail.com>
 <20140428142931.GA12056@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Wed May 07 20:45:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi6pr-0000ZI-Iu
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 20:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbaEGSov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 14:44:51 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.42]:44948 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920AbaEGSot (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 14:44:49 -0400
Received: from [77.20.146.74] (helo=sandbox-ub)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Wi6pi-0001a6-EK; Wed, 07 May 2014 20:44:46 +0200
Content-Disposition: inline
In-Reply-To: <20140428142931.GA12056@camelia.ucw.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248345>

Hi,

On Mon, Apr 28, 2014 at 04:29:31PM +0200, Stepan Kasal wrote:
> this is another patch that lives in msysGit for a long time.
> Originally, it had two parts:
> (Cf https://github.com/msysgit/git/commit/64a8a03 )
> 
> 1) adding alias pwd='pwd -W' to git-sh-setup.sh
>    This one went upstream, though as a shell function.
> 
> 2) revert of commit 4dce7d9b by Johannes Sixt <j6t@kdbg.org>
> This mingw-specific commit was created less than 3 weeks before
> it was reverted.  And it stayed reverted for two years.
> 
> Could you please either accept this patch, or revert 4dce7d9b ?
> (Both alternatives are exactly the same.)

Sorry for the late reply.  To me reverting (or omitting at the next
rebasing merge) this patch sound fine, as it seems to be superseeded by
the upstream change.

As I can see thats already done on master, so it seems to be all good.

Cheers Heiko
