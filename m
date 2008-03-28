From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Silence cpio's "N blocks" output when cloning locally
Date: Fri, 28 Mar 2008 17:29:36 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803281728530.18259@racer.site>
References: <> <1206685186-10352-1-git-send-email-bdonlan@fushizen.net> <alpine.LSU.1.00.0803281400330.18259@racer.site> <2145F4A8-7C6E-4AE9-A531-026DC65417BE@wincent.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1454050381-1206721777=:18259"
Cc: Bryan Donlan <bdonlan@fushizen.net>, git@vger.kernel.org,
	gitster@pobox.com
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 17:30:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfHTC-0004jD-5A
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 17:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867AbYC1Q3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 12:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752818AbYC1Q3i
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 12:29:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:42095 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752497AbYC1Q3i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 12:29:38 -0400
Received: (qmail invoked by alias); 28 Mar 2008 16:29:36 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp010) with SMTP; 28 Mar 2008 17:29:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ZlG0Gj90ZxF9nnBTGX9pLdh6nfa3CuNHx3lBZCp
	uC8W+l6eL03OSl
X-X-Sender: gene099@racer.site
In-Reply-To: <2145F4A8-7C6E-4AE9-A531-026DC65417BE@wincent.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78426>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1454050381-1206721777=:18259
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 28 Mar 2008, Wincent Colaiuta wrote:

> El 28/3/2008, a las 14:01, Johannes Schindelin escribió:
> 
> >On Fri, 28 Mar 2008, Bryan Donlan wrote:
> >
> > >Pass --quiet to cpio in git-clone to hide the (confusing) "0 blocks" 
> > >message. For compatibility with operating systems which might not 
> > >support GNUisms, the presence of --quiet is probed for by grepping 
> > >cpio's --help output.
> >
> >We have a builtin clone which is almost ready for 'next', and I think 
> >that this issue would be resolved there anyway.
> 
> In any case, I'd rather see the cpio check at configure-time rather than 
> run-time.

That would have to be done via ./configure, missing out those people who 
do not run ./configure, but just make.

Ciao,
Dscho

--8323584-1454050381-1206721777=:18259--
