From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] MinGW: Use pid_t more consequently, introduce uid_t
  for greater compatibility
Date: Wed, 30 Dec 2009 12:11:41 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912301209310.4985@pacific.mpi-cbg.de>
References: <hhbldr$di8$1@ger.gmane.org> <4B3A7000.4050308@kdbg.org>  <bdca99240912291649h1c727072q3b1e4099cab426df@mail.gmail.com>  <40aa078e0912291655m57ea0081vddf3b64bf27e1d02@mail.gmail.com> <bdca99240912291716g74c35f22r7599f2c254fb1b09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: kusmabite@gmail.com, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 12:06:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPwNy-0006HE-Om
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 12:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695AbZL3LGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 06:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbZL3LGf
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 06:06:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:54113 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752583AbZL3LGe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 06:06:34 -0500
Received: (qmail invoked by alias); 30 Dec 2009 11:06:32 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp052) with SMTP; 30 Dec 2009 12:06:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+R+e9WdzOR0QXxUSOTECc/RjnA7BM0uYLBf2zHp8
	poBWZIWD5rY3Vp
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <bdca99240912291716g74c35f22r7599f2c254fb1b09@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135888>

Hi,

On Wed, 30 Dec 2009, Sebastian Schuberth wrote:

> Anyway, IMHO the correct declaration of e.g. getuid() is not "int 
> getuid()", but "uid_t getuid()" etc. So even if the uid_t type was not 
> required, it's a good change I think.

FWIW I concur with this reasoning.  Even if in this particular case, we 
could work around the issue, it is basically a non-intrusive, minimal 
janitorial patch.  Especially since the original author of the wrong 
signature concurs.

Ciao,
Dscho
