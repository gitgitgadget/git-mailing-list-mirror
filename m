From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/4] Allow e-mails to be sent with the Unix sendmail tool
Date: Tue, 15 Jul 2008 13:22:20 +0100
Message-ID: <20080715122203.GN25448@sirena.org.uk>
References: <20080713113853.18845.37686.stgit@localhost.localdomain> <20080713114026.18845.77979.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl Hasselstr??m <kha@treskal.com>, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 14:54:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIk2D-00013I-JB
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 14:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755387AbYGOMwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 08:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755310AbYGOMwi
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 08:52:38 -0400
Received: from cassiel.sirena.org.uk ([80.68.93.111]:4527 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755240AbYGOMwh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 08:52:37 -0400
X-Greylist: delayed 1590 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jul 2008 08:52:37 EDT
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.63)
	(envelope-from <broonie@sirena.org.uk>)
	id 1KIjXw-0007BO-MG; Tue, 15 Jul 2008 13:22:20 +0100
Content-Disposition: inline
In-Reply-To: <20080713114026.18845.77979.stgit@localhost.localdomain>
X-Cookie: Remember the... the... uhh.....
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: broonie@sirena.org.uk
X-SA-Exim-Scanned: No (on cassiel.sirena.org.uk); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88555>

On Sun, Jul 13, 2008 at 12:40:26PM +0100, Catalin Marinas wrote:
> If the stgit.smtpserver configuration option does not have a host:port
> format, it is assumed to be an external tool. For example, to use
> sendmail just set this variable to "/usr/sbin/sendmail -t -i" (see the
> examples/gitconfig file).

I'd really expect to be able to just specify the hostname alone if using
the standard SMTP port.  Perhaps checking for a / in the server might be
less surprising?

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
