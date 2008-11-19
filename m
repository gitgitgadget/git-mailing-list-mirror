From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] builtin-branch: use strbuf in rename_branch()
Date: Wed, 19 Nov 2008 02:11:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811190209470.30769@pacific.mpi-cbg.de>
References: <cover.1226954771.git.vmiklos@frugalware.org> <b3716161b2a3d508ec4306623c5c8889d9367e1d.1226954771.git.vmiklos@frugalware.org> <5dee4e908190e7a4ed4a693fdf0fb3b3af88fc57.1226954771.git.vmiklos@frugalware.org>
 <225d83c1ead50340eed97c64fbb8995017bf1ca8.1226954771.git.vmiklos@frugalware.org> <7vbpwcvb8i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 02:04:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2bUZ-0005J5-G5
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 02:04:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbYKSBDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 20:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbYKSBDJ
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 20:03:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:46418 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751147AbYKSBDH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 20:03:07 -0500
Received: (qmail invoked by alias); 19 Nov 2008 01:03:05 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp054) with SMTP; 19 Nov 2008 02:03:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/vNrd4/LrvjoQAmxGVdiAtWCFmsbSWl4z38hojoO
	94ulr/gfeM109a
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vbpwcvb8i.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101297>

Hi,

On Tue, 18 Nov 2008, Junio C Hamano wrote:

> Miklos Vajna <vmiklos@frugalware.org> writes:
> 
> > -	snprintf(logmsg, sizeof(logmsg), "Branch: renamed %s to %s",
> > -		 oldref, newref);
> > +	strbuf_addf(&logmsg, "Branch: renamed %s to %s",
> > +		 oldref.buf, newref.buf);
> 
> I am wondering why nobody has complained until now, but shouldn't this 
> be oldname and newname?

I think that was the intention.  Lars?

Ciao,
Dscho
