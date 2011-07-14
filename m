From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git bash
Date: Fri, 15 Jul 2011 01:15:21 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1107150114240.2642@bonsai2>
References: <4DFB5C37.1090606@micronengineering.it> <20110617141822.GD7751@centaur.lab.cmartin.tk> <4DFB6710.8090105@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-142430772-1310685323=:2642"
Cc: =?ISO-8859-15?Q?Carlos_Mart=EDn_Nieto?= <carlos@cmartin.tk>,
	Massimo Manca <massimo.manca@micronengineering.it>,
	git@vger.kernel.org
To: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Fri Jul 15 01:15:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhV7y-0000gM-4n
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 01:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566Ab1GNXPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 19:15:25 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:34907 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932558Ab1GNXPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 19:15:25 -0400
Received: (qmail invoked by alias); 14 Jul 2011 23:15:23 -0000
Received: from pD9EB1A02.dip0.t-ipconnect.de (EHLO noname) [217.235.26.2]
  by mail.gmx.net (mp036) with SMTP; 15 Jul 2011 01:15:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+p+ywKJnapW+m5WVQezLXjeQhUXyK945R2yKBUI9
	GnyditTSzR23Zw
X-X-Sender: gene099@bonsai2
In-Reply-To: <4DFB6710.8090105@dirk.my1.cc>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177183>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-142430772-1310685323=:2642
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi Dirk,

On Fri, 17 Jun 2011, Dirk Süsserott wrote:

> I noticed the following: When the ext. HD is attached/mounted *before* I 
> start the bash, then it works. But if I have a running bash and then 
> mount the drive, I cannot cd to it. "No such path" or sth. It seems, 
> that bash builds a list of available drives only at startup. Might that 
> be your problem? If so, then close all bashs and re-open them after 
> mounting the devices.

This behavior is discussed here:

http://permalink.gmane.org/gmane.comp.version-control.git/141867

(look for "NO_FSTAB_THREAD")

Ciao,
Johannes

--8323329-142430772-1310685323=:2642--
