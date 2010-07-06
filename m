From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Re: [PATCH 1/2] Fix MSVC build
Date: Tue, 6 Jul 2010 12:12:30 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1007061211590.2326@intel-tinevez-2-302>
References: <1278358897-488-1-git-send-email-pharris@opentext.com> <4C32C53C.8020105@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Harris <pharris@opentext.com>, msysgit@googlegroups.com,
	git@vger.kernel.org, ramsay@ramsay1.demon.co.uk, jrnieder@gmail.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jul 06 12:12:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW58x-0005Ck-6w
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 12:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024Ab0GFKMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 06:12:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:39841 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753407Ab0GFKMi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 06:12:38 -0400
Received: (qmail invoked by alias); 06 Jul 2010 10:12:36 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp049) with SMTP; 06 Jul 2010 12:12:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Aia0Kg/WAwaYwQQCsmbrwC47mJbw7PiR4Nm7v3k
	3pZLqtAnfUVsPx
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4C32C53C.8020105@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150340>

Hi,

On Tue, 6 Jul 2010, Johannes Sixt wrote:

> Am 7/5/2010 21:41, schrieb Peter Harris:
> > Signed-off-by: Peter Harris <pharris@opentext.com>
> > ---
> >  compat/mingw.h |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/compat/mingw.h b/compat/mingw.h
> > index 8104039..08fea02 100644
> > --- a/compat/mingw.h
> > +++ b/compat/mingw.h
> > @@ -14,11 +14,13 @@ typedef int uid_t;
> >  #define S_ISSOCK(x) 0
> >  
> >  #ifndef _STAT_H_
> > +#ifndef S_IRUSR
> >  #define S_IRUSR 0
> >  #define S_IWUSR 0
> >  #define S_IXUSR 0
> >  #define S_IRWXU (S_IRUSR | S_IWUSR | S_IXUSR)
> >  #endif
> > +#endif
> >  #define S_IRGRP 0
> >  #define S_IWGRP 0
> >  #define S_IXGRP 0
> 
> This doesn't apply: I don't see the #ifndef _STAT_H_ brackets anywhere in
> my version of compat/mingw.h.

Obviously, this is a patch against 4msysgit's devel branch.

Hth,
Dscho
