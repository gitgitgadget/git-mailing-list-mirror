From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [BUG] git-svn dcommit fails (connection closed unexpectedly)
Date: Mon, 14 May 2007 14:27:21 +0200
Message-ID: <vpq4pmfr3o6.fsf@bauges.imag.fr>
References: <vpq7irfengj.fsf@bauges.imag.fr> <20070513171707.GA14024@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 14 14:27:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnZeI-0008Hw-Tp
	for gcvg-git@gmane.org; Mon, 14 May 2007 14:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbXENM13 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 08:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbXENM13
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 08:27:29 -0400
Received: from imag.imag.fr ([129.88.30.1]:35074 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349AbXENM13 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 08:27:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l4ECRM1Z026741
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 14 May 2007 14:27:22 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HnZe5-0004X4-RL; Mon, 14 May 2007 14:27:21 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HnZe5-00050M-P6; Mon, 14 May 2007 14:27:21 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <20070513171707.GA14024@muzzle> (Eric Wong's message of "Sun\, 13 May 2007 10\:17\:07 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 14 May 2007 14:27:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47233>

Eric Wong <normalperson@yhbt.net> writes:

> Does the patch in
>   http://permalink.gmane.org/gmane.comp.version-control.git/47126
> help?

I don't have the failure right now, I'll tell you when I get it again.

> If your local username the same as the username
> you're using for svn it shouldn't fail for the reason that patch
> above is needed.

It is the same on both machines.

> Which version of SVN is running on the server?

$ svn --version
svn, version 1.1.4 (r13838)
   compiled Apr 12 2005, 16:01:59
$ cat /etc/redhat-release
Red Hat Enterprise Linux ES release 4 (Nahant Update 5)

-- 
Matthieu
