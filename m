From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Chicken/egg problem building from a 'git clone'
Date: Fri, 6 Feb 2009 05:44:49 +0100
Message-ID: <20090206044449.GA31491@atjola.homenet>
References: <loom.20090206T035001-370@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Joi Ellis <gyles19@visi.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 05:51:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVIgU-0006l9-4n
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 05:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbZBFEpA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2009 23:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbZBFEo7
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 23:44:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:53406 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751341AbZBFEo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 23:44:59 -0500
Received: (qmail invoked by alias); 06 Feb 2009 04:44:57 -0000
Received: from i577BA589.versanet.de (EHLO atjola.local) [87.123.165.137]
  by mail.gmx.net (mp020) with SMTP; 06 Feb 2009 05:44:57 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+tL9BofLetq8quLk06VvdqCVYi1FEgkZmup2KWPL
	EMX1/1dPMSGjGQ
Content-Disposition: inline
In-Reply-To: <loom.20090206T035001-370@post.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108652>

On 2009.02.06 04:09:24 +0000, Joi Ellis wrote:
> "make all" fails becuase my libaries are old:
>=20
>     LINK git-fast-import
> fast-import.o: In function `store_object':
> /usr/local/src/git/git/fast-import.c:1086: undefined reference to `de=
flateBound'
> /usr/local/src/git/git/fast-import.c:1109: undefined reference to `de=
flateBound'

You can define NO_DEFLATE_BOUND. That and a bunch of other things you
can control are documented within the Makefile. No need for configure.

Bj=F6rn
